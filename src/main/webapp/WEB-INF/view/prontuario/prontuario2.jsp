<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="vetweb" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<vetweb:layout title="Prontuario do Animal2">
	<jsp:attribute name="jsHead">
    <script src="https://cloud.tinymce.com/stable/tinymce.min.js?apiKey=2i80p03koooieys6i5h5yz1n9d4uaxrwt1iaoy9938bmcahs"></script>
        <script>tinymce.init({ selector:'#preenchimentoModeloAtendimento' });</script>
        <script>
            $(document).ready(function(){
               $('#historicos').dataTable({
                    language: {
                        "sEmptyTable": "Nenhum registro encontrado",
                        "sInfo": "Mostrando de _START_ até _END_ de _TOTAL_ registros",
                        "sInfoEmpty": "Mostrando 0 até 0 de 0 registros",
                        "sInfoFiltered": "(Filtrados de _MAX_ registros)",
                        "sInfoPostFix": "",
                        "sInfoThousands": ".",
                        "sLengthMenu": "_MENU_ resultados por página",
                        "sLoadingRecords": "Carregando...",
                        "sProcessing": "Processando...",
                        "sZeroRecords": "Nenhum registro encontrado",
                        "sSearch": "Pesquisar",
                        "oPaginate": {
                            "sNext": "Próximo",
                            "sPrevious": "Anterior",
                            "sFirst": "Primeiro",
                            "sLast": "Último"
                        },
                        "oAria": {
                            "sSortAscending": ": Ordenar colunas de forma ascendente",
                            "sSortDescending": ": Ordenar colunas de forma descendente"
                        }
                    }                  
               });
            });
        </script>       
    </jsp:attribute>
	<jsp:body>
        <div class="page-wrapper">
            <!-- INICIO MENU DE CONSULTA DE NAVEGAÇÃO -->
            <div class="row page-titles">
                <div class="col-md-5 align-self-center">
                    <h3 class="text-primary">Prontuário</h3> 
                </div>
                <div class="col-md-7 align-self-center">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a
                            href="<c:url value="/"></c:url>">Home</a></li>
                        <li class="breadcrumb-item"><a
                            href="<c:url value="/clientes/listar"></c:url>">Animais</a></li>
                        <li class="breadcrumb-item active">Detalhes do Animal</li>
                        <li class="breadcrumb-item active">Prontuário do Animal</li>
                    </ol>
                </div>
            </div>
            <!-- FIM MENU DE CONSULTA DE NAVEGAÇÃO -->

            <!-- INICIO CORPO DA PÁGINA  -->
            
                <div class="">
                    <div class="col-12">
                        <div class="card">          
                            <div class="card-body">
                                <h2 class="card-title">Prontuário do Animal XXXX</h2>
                                <div class="col-md-12">
                                    <button type="button" data-toggle="modal" data-target="#modalAtendimento" onclick="ajaxService.buscarModeloPorTipoDeAtendimento()" class="btn btn-info">
                                        <i class="fa fa-medkit fa-5x" aria-hidden="true"></i>
                                    </button>
                                    <button type="button" data-toggle="modal" data-target="#modalVacina" class="btn btn-warning">
                                        <i class="fa fa-eyedropper fa-5x"></i>
                                    </button>
                                    <button type="button" data-toggle="modal" data-target="#modalPatologia" class="btn btn-danger">
                                        <i class="fa  fa-plus-square fa-5x" aria-hidden="true"></i>
                                    </button>
                                    <button type="button" data-toggle="modal" data-target="#modalExame" class="btn btn-secondary">
                                        <i class="fa fa-stethoscope fa-5x" aria-hidden="true"></i>
                                    </button>
                                </div>

                                <div class="table-responsive m-t-40">
                                    
                                    <h3 class="card-title">Linha do tempo</h3>
							
							
							
                                    <div class="tab-content">
                                        <div class="tab-pane active" id="home" role="tabpanel">
                                        
											<div class="card-body">
                                                <div class="profiletimeline">


														<c:forEach items="${historico}" var="elementoHistorico">
														
														<c:if test="${elementoHistorico.tipo == 'ATENDIMENTO'}">
					                                                    <div class="sl-item">
					                                                        <div class="sl-left"> <img src="<c:url value="/resources/images/img-vetweb/p_medkit.png"></c:url>" class="img-circle"> </div>
					                                                        <div class="sl-right">
					                                                            <div><a href="#" class="link">${elementoHistorico.tipo}</a> <span class="sl-date">${elementoHistorico.data}</span>
					                                                                <p><a href="#">${elementoHistorico.descricao}</a></p>
					                                                            </div>
					                                                            <button data-toggle="modal" data-target="#modalAtendimento" onclick="ajaxService.editarAtendimento(${elementoHistorico.ocorrenciaId})"
                                                                         class="btn btn-success btn-flat btn-addon m-b-10 m-l-5"><i class="ti-save"></i> Editar</button>
                                        								
                                        								<a href="<c:url value="/prontuario/removerAtendimentoDoProntuario/${prontuario.prontuarioId}/${elementoHistorico.ocorrenciaId}"></c:url>">
																		  	<button class="btn btn-inverse btn-flat btn-addon m-b-10 m-l-5"><i class="ti-save"></i> Excluir</button>
																		</a>
					                                                        </div>
					                                                    </div>
					                                                    <hr>
                                                    </c:if>
                                                    
                                                    <c:if test="${elementoHistorico.tipo == 'VACINA'}">
                                                    <div class="sl-item">
                                                        <div class="sl-left"> <img src="<c:url value="/resources/images/img-vetweb/p_eyedropper.png"></c:url>" alt="user" class="img-circle"> </div>
                                                        <div class="sl-right">
                                                            <div> <a href="#" class="link">${elementoHistorico.tipo}</a> <span class="sl-date">${elementoHistorico.data}</span>
                                                                <div class="m-t-20 row">
                                                                    <div class="col-md-9 col-xs-12">
                                                                        <p>${elementoHistorico.descricao}</a></div>
                                                                </div>
                                                                <button data-toggle="modal" data-target="#modalVacina" onclick="ajaxService.editarVacina(${elementoHistorico.ocorrenciaId})"
                                                                         class="btn btn-success btn-flat btn-addon m-b-10 m-l-5"><i class="ti-save"></i> Editar</button>
                                        								
                                        								<a href="<c:url value="/prontuario/removerVacinaDoProntuario/${prontuario.prontuarioId}/${elementoHistorico.ocorrenciaId}?inclusaoOcorrenciaVacina=${elementoHistorico.data}"></c:url>">
																		  	<button class="btn btn-inverse btn-flat btn-addon m-b-10 m-l-5"><i class="ti-save"></i> Excluir</button>
																		</a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <hr>
                                                    </c:if>
                                                    
                                                    <c:if test="${elementoHistorico.tipo == 'PATOLOGIA'}">
                                                    <div class="sl-item">
                                                        <div class="sl-left"> <img src="<c:url value="/resources/images/img-vetweb/p_plus-square.png"></c:url>" alt="user" class="img-circle"> </div>
                                                        <div class="sl-right">
                                                            <div><a href="#" class="link">${elementoHistorico.tipo}</a> <span class="sl-date">${elementoHistorico.data}</span>
                                                                <blockquote class="m-t-10">
                                                                    ${elementoHistorico.descricao}
                                                                </blockquote>
                                                            </div>
                                                            <button data-toggle="modal" data-target="#modalPatologia" onclick="ajaxService.editarPatologia(${elementoHistorico.ocorrenciaId})"
                                                                         class="btn btn-success btn-flat btn-addon m-b-10 m-l-5"><i class="ti-save"></i> Editar</button>
                                        								
                                        								<a href="<c:url value="/prontuario/removerPatologiaDoProntuario/${prontuario.prontuarioId}/${elementoHistorico.ocorrenciaId}"></c:url>">
																		  	<button class="btn btn-inverse btn-flat btn-addon m-b-10 m-l-5"><i class="ti-save"></i> Excluir</button>
																		</a>
                                                        </div>
                                                    </div>
                                                    </c:if>
                                                    
             
                                                    <c:if test="${elementoHistorico.tipo == 'EXAME'}">
                                                    <div class="sl-item">
                                                        <div class="sl-left"> <img src="<c:url value="/resources/images/img-vetweb/p_stethoscope.png"></c:url>" alt="user" class="img-circle"> </div>
                                                        <div class="sl-right">
                                                            <div><a href="#" class="link">${elementoHistorico.tipo}</a> <span class="sl-date">${elementoHistorico.data}</span>
                                                                <blockquote class="m-t-10">
                                                                ${elementoHistorico.descricao}
                                                                </blockquote>
                                                            </div>
                                                            <button data-toggle="modal" data-target="#modalExame" onclick="ajaxService.editarExame(${elementoHistorico.ocorrenciaId})"
                                                                         class="btn btn-success btn-flat btn-addon m-b-10 m-l-5"><i class="ti-save"></i> Editar</button>
                                        								
                                        								<a href="<c:url value="/prontuario/removerExameDoProntuario/${prontuario.prontuarioId}/${elementoHistorico.ocorrenciaId}"></c:url>">
																		  	<button class="btn btn-inverse btn-flat btn-addon m-b-10 m-l-5"><i class="ti-save"></i> Excluir</button>
																		</a>
                                                        </div>
                                                    </div>
                                                    </c:if>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            <!-- FIM CORPO DA PÁGINA  -->
        </div>

        <!-- INICIO DAS MODAIS  -->
        <vetweb:modalAtendimento prontuario="${prontuario}" tiposDeAtendimento="${tiposDeAtendimento}"></vetweb:modalAtendimento>
        <vetweb:modalPatologia prontuario="${prontuario}" patologias="${patologia}"></vetweb:modalPatologia>
        <vetweb:modalVacina prontuario="${prontuario}" vacinas="${vacinas}"></vetweb:modalVacina>
        <vetweb:modalExame prontuario="${prontuario}" exames="${exames}"></vetweb:modalExame>
        <!-- INICIO DAS MODAIS  -->
    </jsp:body>

</vetweb:layout>