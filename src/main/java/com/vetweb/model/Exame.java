package com.vetweb.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.Duration;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "tbl_exame")
@NamedQuery(name = "consultaValorPendenteEmExames", query = "SELECT SUM (exame.preco) FROM Exame exame "
		+ "JOIN exame.exames ex "
		+ "JOIN ex.prontuario pront "
		+ "JOIN pront.animal animal "
		+ "JOIN animal.proprietario prop "
		+ "WHERE prop.pessoaId = :codigoCliente "
		+ "AND ex.pago = false")
public class Exame implements Serializable {
	
	private static final long serialVersionUID = 1L;

	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long exameId;
	
	private String descricao;
    
	@Column(columnDefinition = "TEXT")
    private String apresentacao;
	
	@Column(columnDefinition = "TEXT")
    private String encerramento;
	
	private BigDecimal preco;
	
	private Duration duracao;

    public Exame() {
	}
    
	public Exame(Long exameId, String apresentacao, String encerramento) {
		this.exameId = exameId;
		this.apresentacao = apresentacao;
		this.encerramento = encerramento;
	}

	public Long getExameId() {
		return exameId;
	}

	public void setExameId(Long exameId) {
		this.exameId = exameId;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public String getApresentacao() {
		return apresentacao;
	}

	public void setApresentacao(String apresentacao) {
		this.apresentacao = apresentacao;
	}

	public String getEncerramento() {
		return encerramento;
	}

	public void setEncerramento(String encerramento) {
		this.encerramento = encerramento;
	}

	public BigDecimal getPreco() {
		return preco;
	}

	public void setPreco(BigDecimal preco) {
		this.preco = preco;
	}

	public Duration getDuracao() {
		return duracao;
	}

	public void setDuracao(Duration duracao) {
		this.duracao = duracao;
	}
    
}