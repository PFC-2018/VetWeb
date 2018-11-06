package com.vetweb.scheduled;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.vetweb.dao.AtendimentoDAO;
import com.vetweb.dao.ProntuarioDAO;
import com.vetweb.dao.ProprietarioDAO;
import com.vetweb.model.OcorrenciaAtendimento;
import com.vetweb.model.Pessoa;
import com.vetweb.model.Proprietario;
import com.vetweb.service.EmailService;

@Component
@Transactional
@EnableScheduling
public class Scheduler {
	
	@Autowired
	private ProprietarioDAO proprietarioDAO;
	
	@Autowired
	private AtendimentoDAO atendimentoDAO;
	
	@Autowired
	private ProntuarioDAO prontuarioDAO; 
	
	@Autowired
	private EmailService emailService;
	
	private static final Logger LOGGER = Logger.getLogger(Scheduler.class);
	
	private static final long MINUTO = 60000;
	
	
    @Scheduled(fixedDelay = MINUTO/4)
    public void verificarClientesEmDebitoDesativar() {
    	LOGGER.info("EXECUTANDO JOB - VERIFICANDO CLIENTES DEVEDORES - DESATIVACAO");
    	List<Proprietario> proprietariosComDebito = proprietarioDAO.buscarClientesEmDebito();
    	proprietariosComDebito
    		.stream()
    		.filter(prop -> prop.isAtivo())
    		.filter(prop -> prop.getAnimais().size() > 0)
    		.peek(prop -> LOGGER.info("INATIVANDO CLIENTE " + prop.getNome()))
    		.forEach(prop ->  {prop.setAtivo(false); proprietarioDAO.salvar(prop);});
    	LOGGER.info("FIM DO JOB - VERIFICANDO CLIENTES DEVEDORES - DESATIVACAO");
    }
    
    @Scheduled(fixedDelay = MINUTO/4)
    public void verificarClientesEmDebitoAtivar() {
    	LOGGER.info("EXECUTANDO JOB - VERIFICANDO CLIENTES DEVEDORES - ATIVACAO");
    	Set<Proprietario> proprietariosInativosAdimplentes = proprietarioDAO.buscarClientesInativosAdimplentes();
    	proprietariosInativosAdimplentes
    		.stream()
    		.peek(prop -> LOGGER.info("REATIVANDO CLIENTE " + prop.getNome()))
    		.forEach(prop -> {prop.setAtivo(true); proprietarioDAO.salvar(prop); });
    	LOGGER.info("FIM DO JOB - VERIFICANDO CLIENTES DEVEDORES - ATIVACAO");
    }
    
    
    @Scheduled(fixedDelay = MINUTO)
    public void verificacaoRetornoAtendimento() {
    	LOGGER.info("EXECUTANDO JOB - VERIFICANDO RETORNO DE ATENDIMENTO");
    	List<Proprietario> p = new ArrayList<>();
    	
    	proprietarioDAO
    		.listarTodos()
    		.stream()
    		.filter(prop -> prop.isAceitaNotificacoes())
    		.filter(prop -> p.add(prop));
    	
    	for (Proprietario proprietario : p) {
    		atendimentoDAO
    		.listarTodos()
    		.stream()
    		.filter(ate -> 
    			LocalDate.of(ate.getData().getYear(), ate.getData().getMonthValue(), ate.getData().getDayOfMonth())
    			.isEqual(LocalDate.now()))
    		.forEach(ate -> this.notificaRetornoAtendimento(ate));
		}
    	
    	LOGGER.info("FIM DO JOB - VERIFICANDO RETORNO DE ATENDIMENTO");
    }
    
    @SuppressWarnings("static-access")
	private void notificaRetornoAtendimento(OcorrenciaAtendimento atendimento) {
    	Pessoa pessoaDestinatario = prontuarioDAO.buscarProntuarioDoAtendimento(atendimento).getAnimal().getProprietario();
    	StringBuilder mensagemRetorno = new StringBuilder();
    	mensagemRetorno.append("O RETORNO DO ATENDIMENTO "
    				+ atendimento.getTipoDeAtendimento().getNome() + " FEITO EM " + atendimento.getData() + " E HOJE. FAVOR COMPARECER A CLINICA. ");
    	emailService.enviar(pessoaDestinatario, mensagemRetorno.toString(), "RETORNO DE ATENDIMENTO");
    }
    
}
