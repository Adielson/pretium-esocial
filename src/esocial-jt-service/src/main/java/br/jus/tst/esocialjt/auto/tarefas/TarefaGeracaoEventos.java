package br.jus.tst.esocialjt.auto.tarefas;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.jus.tst.esocialjt.dominio.Ocorrencia;
import br.jus.tst.esocialjt.negocio.OcorrenciaServico;
import br.jus.tst.esocialjt.pretium.BuscarProximoEnvioService;

@Service
public class TarefaGeracaoEventos implements Tarefa{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(TarefaGeracaoEventos.class);
	
	@Autowired
	private OcorrenciaServico ocorrenciaServico;
	
	@Autowired
	private BuscarProximoEnvioService buscarProximoEnvio; 
	
	@Override
	public boolean executar() {

		/*
		try {
			this.buscarProximoEnvio.registrarEventoParaEnvio();
		} catch (IOException e) {
			e.printStackTrace();
		}
		*/
		
		List<Ocorrencia> ocorrencias = ocorrenciaServico.recuperaOcorrenciasSemEventos();
		if(! ocorrencias.isEmpty()) {
			LOGGER.info("Gerando eventos para " + ocorrencias.size() + " ocorrencias");
		}
		ocorrencias.forEach(ocorrenciaServico::gerarEvento);
		return true;
	}

}
