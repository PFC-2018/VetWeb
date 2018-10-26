<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="vetweb" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
    prefix="security"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<vetweb:layout title="Agendamento">
     <jsp:attribute name="jsFooter">
     
     	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.47/js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
     
        <script>
        
        var remarcacaoInicio = null;
        
        var remarcacaoFim = null;
        
        var remarcacao = null;
        
        var remarcacaoType = null;
        
            $(document).ready(function() {
            	$('#dataRemarcacao').datetimepicker();
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
					eventDrop: function(event, delta, revertFunc, jsEvent, ui, view) {
					    if (!confirm("CONFIRMA A REMARCAÇÃO DA OCORRÊNCIA DE " + event.type + "?")) {
					        revertFunc();
				      	} else {
				      		try {
			   				 	ajaxService.remarcarOcorrencia(event.id, event.type, moment(event.start._i).format('YYYY-MM-DDTHH:mm'), moment(event.end._i).format('YYYY-MM-DDTHH:mm'));
				      		} catch(e) {
				      			 if (confirm('JÁ EXISTE OCORRÊNCIA NA DATA/INTERVALO SELECIONADO. DESEJA REMARCAR A OCORRÊNCIA SOBRESCRITA OU CANCELAR A OPERAÇÃO?')) {
				      				remarcacao = event.id;
				      				remarcacaoType = event.type;
				      				remarcacaoInicio = moment(event.start._i).format('YYYY-MM-DDTHH:mm');
				      				remarcacaoFim = moment(event.end._i).format('YYYY-MM-DDTHH:mm');
				      				$('#modalReagendar').modal('show');
				      			 }
				      		}
				      	}
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
            
			$('#btnRemarcacao').on('click', function() {
				ajaxService.remarcarOcorrenciasIntervalo(remarcacao, remarcacaoType, moment($('#dataRemarcacao').val()).format('YYYY-MM-DDTHH:mm'), remarcacaoInicio, remarcacaoFim);				
   				$('#modalReagendar').modal('toggle');
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
            <!-- INICIO MENU DE CONSULTA DE NAVEGAÇÃO -->
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
            <!-- FIM MENU DE CONSULTA DE NAVEGAÇÃO -->

            <!-- INICIO CORPO DA PÁGINA  -->
            
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
                                    
                                    <vetweb:modalReagendar></vetweb:modalReagendar>

                                </table>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            <!-- FIM CORPO DA PÁGINA  -->
        </div>
    </jsp:body>

</vetweb:layout>