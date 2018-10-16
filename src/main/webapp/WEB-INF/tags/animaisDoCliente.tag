<%@ taglib prefix="vetweb" tagdir="/WEB-INF/tags"%>
<%@attribute name="proprietario" required="true" type="java.lang.Object" %><!--    Informa que recebe um atributo obrigat�rio title    -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%><!--  tags �teis do spring framework   -->
<!--Por padr�o o tipo dos atributos � String, necess�rio alterar p/ Object p/ reconhecer atributos-->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %><!--    Importa��o JSTL -->


<c:if test="${proprietario.animais.size() >= 0}">
    <c:forEach items="${proprietario.animais}" var="animal">
        <ul>
            <li><a href="<c:url value="/animais/detalhesAnimal/${animal.nome}"></c:url>"> ${animal.nome}</a></li>
        </ul>
    </c:forEach>                           
</c:if>
<c:if test="${proprietario.animais.size() < 0}">Sem animal cadastrado</c:if>

<button type="button" class="btn btn-warning btn-sm m-b-10 m-l-5" onclick="location.href='<c:url value="/clientes/addAnimal/${proprietario.pessoaId}"></c:url>'"><i class="ti-plus"></i> Adicionar Animal</button>