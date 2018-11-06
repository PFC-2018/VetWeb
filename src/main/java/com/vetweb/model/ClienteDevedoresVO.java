package com.vetweb.model;

import java.math.BigDecimal;
import java.util.List;

public class ClienteDevedoresVO {
	
	private String nome;
	private String contato;
	private String observacoes;
	private List<Animal> animais;
	private BigDecimal totalPendente;
	
	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getContato() {
		return contato;
	}

	public void setContato(String contato) {
		this.contato = contato;
	}

	public String getObservacoes() {
		return observacoes;
	}

	public void setObservacoes(String observacoes) {
		this.observacoes = observacoes;
	}

	public List<Animal> getAnimais() {
		return animais;
	}

	public void setAnimais(List<Animal> animais) {
		this.animais = animais;
	}

	public BigDecimal getTotalPendente() {
		return totalPendente;
	}

	public void setTotalPendente(BigDecimal totalPendente) {
		this.totalPendente = totalPendente;
	}
	
	
	
}
