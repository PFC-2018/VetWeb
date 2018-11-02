package com.vetweb.service;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.vetweb.dao.AtendimentoDAO;
import com.vetweb.dao.ProntuarioDAO;
import com.vetweb.dao.ProprietarioDAO;
import com.vetweb.model.ClienteDevedoresVO;
import com.vetweb.model.Proprietario;
import com.vetweb.model.report.Report;
import com.vetweb.scheduled.Scheduler;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.export.JRPdfExporter;

@Component
@Transactional
public class JasperService {
	@Autowired
	private ProprietarioDAO proprietarioDAO;

	@Autowired
	private AtendimentoDAO atendimentoDAO;

	@Autowired
	private ProntuarioDAO prontuarioDAO;

	private static final Logger LOGGER = Logger.getLogger(JasperService.class);

	public Connection getConnection() {
		try {
			return DriverManager.getConnection("jdbc:postgresql://localhost:5432/vetweb_database", "postgres",
					"postgres");
		} catch (SQLException sqlException) {
			throw new RuntimeException(sqlException);
		}
	}

	public void gerarRelatorio(Report report, OutputStream outputStream) throws IOException {
		try {
			Connection connection = getConnection();
			String reportName = report.getType().name();
			Map<String, Object> parameterMap = new HashMap<>();
			if (report.getParameters() != null) {
				parameterMap = report.getParameters().stream()
						.collect(Collectors.toMap(param -> param.getKey(), param -> param.getValue()));
			}
			String reportLocation = new ClassPathResource(reportName + ".jrxml").getFile().getAbsolutePath();
			JasperCompileManager.compileReportToFile(reportLocation);
			JasperPrint jasperPrint = JasperFillManager.fillReport(
					new ClassPathResource(reportName + ".jasper").getFile().getAbsolutePath(), parameterMap,
					connection);
			;
			JRExporter jrExporter = new JRPdfExporter();
			jrExporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
			jrExporter.setParameter(JRExporterParameter.OUTPUT_STREAM, outputStream);
			jrExporter.exportReport();
			connection.close();
		} catch (JRException e) {
			throw new RuntimeException(e);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public void gerarRelatorioComObjeto(Report report, OutputStream outputStream) throws IOException {
		List<ClienteDevedoresVO> clientesDevedores = verificacaoClientesEmDebito();
		
		
		// Gerar relatório
		try {
			Connection connection = getConnection();
			String reportName = report.getType().name();
			Map<String, Object> parameterMap = new HashMap<>();
			if (report.getParameters() != null) {
				parameterMap = report.getParameters().stream()
						.collect(Collectors.toMap(param -> param.getKey(), param -> param.getValue()));
			}
			String reportLocation = new ClassPathResource(reportName + ".jrxml").getFile().getAbsolutePath();
			JasperCompileManager.compileReportToFile(reportLocation);
			JasperPrint jasperPrint = JasperFillManager.fillReport(
					new ClassPathResource(reportName + ".jasper").getFile().getAbsolutePath(), parameterMap,
					new JRBeanCollectionDataSource(clientesDevedores));
			JRExporter jrExporter = new JRPdfExporter();
			jrExporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
			jrExporter.setParameter(JRExporterParameter.OUTPUT_STREAM, outputStream);
			jrExporter.exportReport();
			connection.close();
		} catch (JRException e) {
			throw new RuntimeException(e);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public List<ClienteDevedoresVO> verificacaoClientesEmDebito() {
		Double ttlAtendimentos = 0.0;
		List<ClienteDevedoresVO> cVOList = new ArrayList<ClienteDevedoresVO>();
		List<Proprietario> proprietariosComDebito = proprietarioDAO.buscarClientesEmDebito();
		proprietariosComDebito.stream()
				.peek(prop -> LOGGER.info("JasperService - Clientes Devedores " + prop.getNome()))		
				.forEach(prop -> { 
						ClienteDevedoresVO cVO = new ClienteDevedoresVO(); 
						cVO.setNome(prop.getNome());
						
						cVOList.add(cVO); 
					});	

		return cVOList;
	}

}
