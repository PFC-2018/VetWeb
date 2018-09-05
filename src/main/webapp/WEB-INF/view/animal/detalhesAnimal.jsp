<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="vetweb" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<vetweb:layout title="Animal ${animal.nome}">
	<jsp:body>
        <div class="page-wrapper">
            <!-- INICIO MENU DE CONSULTA DE NAVEGAÇÃO -->
            <div class="row page-titles">
                <div class="col-md-5 align-self-center">
                    <h3 class="text-primary">Clientes</h3> 
                </div>
                <div class="col-md-7 align-self-center">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a
							href="<c:url value="/"></c:url>">Home</a></li>
                        <li class="breadcrumb-item"><a
							href="<c:url value="/clientes/listar"></c:url>">Animais</a></li>
                        <li class="breadcrumb-item active">Detalhes do Animal</li>
                    </ol>
                </div>
            </div>
            <!-- FIM MENU DE CONSULTA DE NAVEGAÇÃO -->

            <!-- INICIO CORPO DA PÁGINA  -->
            <div class="col-md-8">
                <div class="card">
                    <div class="card-body p-b-0">
                        
                        <h4 class="card-title">Animal ${animal.nome}</h4>
                        <!-- Nav tabs -->
                        <ul class="nav nav-tabs customtab"
							role="tablist">
                            <li class="nav-item"> <a
								class="nav-link active" data-toggle="tab" href="#dadosAnimais"
								role="tab"><span class="hidden-sm-up"><i
										class="ti-home"></i></span> <span class="hidden-xs-down">Dados do Animal</span></a> </li>
                        </ul>
                        <!-- Tab panes -->

                        <div class="tab-content">
                            <div class="tab-pane active "
								id="dadosAnimais" role="tabpanel">
                                <div class="p-20 ">
                                    <table
										class="table table-responsive" id="detalhesProprietario">
                                        <tbody>

                                            <tr>
                                            <th>Foto Animal</th>
                                            <td>
                                                <c:if
														test="${fn:containsIgnoreCase(animal.imagem, 'imagens')}">
                                                    <img
															src="${pageContext.request.contextPath}${animal.imagem}"
															height="30%" alt="${animal.imagem}" />                
                                                </c:if>
                                                <c:if
														test="${not fn:containsIgnoreCase(animal.imagem, 'imagens')}">
                                                    <img
															src="${animal.imagem}" height="30%"
															alt="${animal.imagem}" />                
                                                </c:if>
                                            </td>
                                            </tr>


                                            <tr>
                                                <th><spring:message
														code="nomeAnimal" /></th>
                <td>${animal.nome}</td>
                                            </tr>
                                            <tr>
                                                  <th><spring:message
														code="nascimento" /></th>
                <td>${animal.dtNascimento}</td>
                                            </tr>
                                            <tr>
                                                <th><spring:message
														code="esteril" /></th>
                <td>${animal.esteril}</td>
                                            </tr>
                                            <tr>
                                                 <th><spring:message
														code="status" /></th>
                <td>${animal.status}</td>
                                            </tr>
                                            <tr>
                                                   <th><spring:message
														code="peso" /></th>
                <td>${animal.peso}</td>
                                            </tr>
                                            <tr>
                                                 <th><spring:message
														code="pelagem" /></th>
                <td>${animal.pelagem.descricao}</td>
                                            </tr>
                                            <tr>
                                                 <th><spring:message
														code="especie" /></th>
                <td>${animal.raca.descricao}</td>
                                          
                                        
										</tbody>
                                    </table>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
                <!-- FIM CORPO DA PÁGINA  -->
            </div>
    </jsp:body>
</vetweb:layout>