<%@ taglib prefix="vetweb" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@attribute name="proprietarios" required="true" type="java.util.List" %>
<%@attribute name="tiposDeAtendimento" required="true" type="java.util.List" %>
<%@attribute name="vacinas" required="true" type="java.util.List" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

       <!-- Modal -->
       <div class="modal" id="modalAgendamento">
         <div class="modal-dialog" role="document">
           <div class="modal-content">
             <div class="modal-header">
               <h5 class="modal-title">Adicionar Agendamento</h5>
               <button type="button" class="close" data-dismiss="modal">&times;</button>
             </div>
             
             <div class="modal-body">
					<form:form servletRelativeAction="/agendamento/ocorrencia" method="post">
	                   <tbody>
						<label id="lblCliente" for="slcProprietarios"><spring:message code="cliente"/></label>
		                   <select id="slcProprietarios" name="slcProprietarios">
		                   		<c:forEach items="${proprietarios}" var="prop">
		                   			<option value="${prop.pessoaId}">${prop}</option>
		                   		</c:forEach>
		                   </select>
		                   <br/>
		                
						<label id="lblAnimal" for="slcAnimal"><spring:message code="nomeAnimal"/></label>   
		                <select id="slcAnimal" style="display: none;" name="slcAnimal"></select><br>
						<label id="lblTipo" for="tipoOcorrencia"><spring:message code="tipo"/></label>
	               		  <input type="radio" name="tipoOcorrencia" value="VACINA" class="rdoTipo"> Vacina
	               		  <input type="radio" name="tipoOcorrencia" value="ATENDIMENTO" class="rdoTipo"> Atendimento<br	/>
							<label id="lblVacina" for="slcVacina" style="display: none;"><spring:message code="selecioneVacina"/></label>
		                   <select id="slcVacina" style="display: none;" name="slcVacina">
		                   		<c:forEach items="${todasAsVacinas}" var="vacina">
		                   			<option value="${vacina.vacinaId}">${vacina.nome}</option>
		                   		</c:forEach>
		                   </select>
		                   <br/>
		                   
							<label id="lblAtendimento" for="slcAtendimento" style="display: none;"><spring:message code="selecioneAtendimento"/></label>
		                   <select id="slcAtendimento" style="display: none;" name="slcAtendimento">
		                   		<c:forEach items="${tiposDeAtendimento}" var="atendimento">
		                   			<option value="${atendimento.tipoDeAtendimentoId}">${atendimento.nome}</option>
		                   		</c:forEach>
		                   </select>
	                   		
	                   		<br/>
	                   		
							<label id="lblDataHoraInicial" for="dataHoraInicial" style="display: none;"><spring:message code="dataHoraInicial"/></label>
							<input type="datetime-local" name="dataHoraInicial" id="dataHoraInicial" style="display: none;">
							
		                   <br/>
							
							<label id="lblDataHoraFinal" for="dataHoraFinal" style="display: none;"><spring:message code="dataHoraFinal"/></label>
							<input type="datetime-local" name="dataHoraFinal" id="dataHoraFinal" style="display: none;">
	                   		
	                   </tbody>
	                   
	                   <div class="modal-footer">
	                       <button type="submit" class="btn btn-success btn-flat btn-addon m-b-10 m-l-5"><i class="ti-save"></i> Cadastrar</button>
                       	<button type="reset" class="btn btn-danger btn-flat btn-addon m-b-10 m-l-5"><i class="ti-close"></i> Limpar</button>
	                   </div>
					</form:form>
             </div>
           </div>
         </div>
       </div>