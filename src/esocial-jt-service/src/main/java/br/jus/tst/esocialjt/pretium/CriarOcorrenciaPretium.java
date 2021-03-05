package br.jus.tst.esocialjt.pretium;

import br.jus.tst.esocial.ocorrencia.OcorrenciaDTO;

public interface CriarOcorrenciaPretium {
	
	OcorrenciaDTO gerarOcorrencia(Long _eventosParaEnviarId) throws Exception;

}
