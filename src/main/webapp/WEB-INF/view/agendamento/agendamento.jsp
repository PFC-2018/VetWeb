<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="vetweb" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
    prefix="security"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<vetweb:layout title="Agendamento">
     <jsp:attribute name="jsFooter">
        <script>
            $(document).ready(function() {
                ajaxService.buscarAnimaisPorCliente();
                  $('#calendar').fullCalendar({
                    header: {
                        left: 'prev,next today',
                        center: 'title',
                        right: 'month,agendaWeek,agendaDay'
                    },
                    defaultDate: Date(),
                    navLinks: true,
                    editable: true,
                    eventClick: function(calEvent, jsEvent, view) {
                        $('#modalOcorrenciaProntuario #id').text(calEvent.id);
                        $('#modalOcorrenciaProntuario #type').text(calEvent.type);
                        $('#modalOcorrenciaProntuario #title').text(calEvent.title);
                        $('#modalOcorrenciaProntuario #start').text(calEvent.start.format('DD/MM/YYYY HH:mm:ss'));
                        $('#modalOcorrenciaProntuario').modal('show');
                        ajaxService.buscarAnimaisPorCliente();
                        var enderecoProntuario = $('#irParaOProntuario');
                        var url = '/vetweb/agendamento/ocorrencia/';
                        enderecoProntuario.attr('href', url + $('#type').text() + '/' + $('#id').text());
                    },
                    selectable: true,
                    selectHelper: true,
                    select: function(start, end){
                        $('#modalAgendamento').modal('show');
                        $('#dataHoraInicial').val(moment(start._i).format('YYYY-MM-DDTHH:mm'));
                        $('#dataHoraFinal').val(moment(end._i).format('YYYY-MM-DDTHH:mm'));
                    },
                    eventTextColor: '#000000',
                    events: 'http://localhost:8080/vetweb/agendamento/eventos'
                  });
            });
            
            $('#slcProprietarios').on('change', function() {
                ajaxService.buscarAnimaisPorCliente();
            });
            
            $('.rdoTipo').on('click', function() {
                var rdoSelecionado = $(this); 
                if (rdoSelecionado.val() === 'VACINA') {
                    $('#slcVacina').css('display', 'block');
                    $('#lblVacina').css('display', 'block');
                    $('#slcAtendimento').css('display', 'none');
                    $('#lblAtendimento').css('display', 'none');
                }
                if (rdoSelecionado.val() === 'ATENDIMENTO') {
                    $('#slcAtendimento').css('display', 'block');
                    $('#lblAtendimento').css('display', 'block');
                    $('#slcVacina').css('display', 'none');
                    $('#lblVacina').css('display', 'none');
                } 
                
                $('#lblDataHoraFinal').css('display', 'inline');
                $('#lblDataHoraInicial').css('display', 'inline');
                $('#dataHoraInicial').css('display', 'inline');
                $('#dataHoraFinal').css('display', 'inline');
                            
            });
        </script>
        
    </jsp:attribute>
    <jsp:body>
        <div class="page-wrapper">
            <!-- INICIO MENU DE CONSULTA DE NAVEGA플O -->
            <div class="row page-titles">
                <div class="col-md-5 align-self-center">
                    <h3 class="text-primary">Agendamento</h3> 
                </div>
                <div class="col-md-7 align-self-center">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a
                            href="<c:url value="/"></c:url>">Home</a></li>
                        <li class="breadcrumb-item active"><a
                            href="#">Agendamento</a></li>
                    </ol>
                </div>
            </div>
            <!-- FIM MENU DE CONSULTA DE NAVEGA플O -->

            <!-- INICIO CORPO DA P핯INA  -->
            
                <div class="">
                    <div class="col-12">
                        <div class="card">          
                            <div class="card-body">
                                <h5 class="card-title">Organize sua agenda</h5>
                                <div class="table-responsive m-t-40">
                                    <table id="proprietarios"
                                    class="display nowrap table table-hover table-striped table-bordered"
                                    cellspacing="0" width="100%">
                                        

                                <div id="calendar"></div>

                                <vetweb:modalOcorrenciaProntuario></vetweb:modalOcorrenciaProntuario>
          
                                  <vetweb:modalAgendamento proprietarios="${todosOsClientes}"
                                    tiposDeAtendimento="${tiposDeAtendimento}"
                                    vacinas="${todasAsVacinas}">
                                    </vetweb:modalAgendamento>

                                </table>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            <!-- FIM CORPO DA P핯INA  -->
        </div>
    </jsp:body>

</vetweb:layout>