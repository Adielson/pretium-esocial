package br.jus.tst.esocialjt.mapper;

import org.junit.Test;

import br.jus.tst.esocial.esquemas.eventos.pgtos.ESocial.EvtPgtos;
import br.jus.tst.esocial.ocorrencia.dados.Pgtos;
import br.jus.tst.esocialjt.CriadorObjetoAleatorio;
import br.jus.tst.esocialjt.mapper.infrateste.MapperAssertion;

public class PgtosMapperTest {
	
	@Test
	public void deveMapearEvento() {
		Pgtos pgtos = CriadorObjetoAleatorio.criarEPreencher(Pgtos.class);
		EvtPgtos evtPgtos = PgtosMapper.INSTANCE.comoEvtPgtos(pgtos);

		 MapperAssertion
		 	.assertThat(evtPgtos.getIdeEmpregador())
		 	.isEqualToComparingFieldByFieldRecursively(pgtos.getIdeEmpregador());
		
		 MapperAssertion
		 	.assertThat(evtPgtos.getIdeBenef())
		 	.isEqualToComparingFieldByFieldRecursively(pgtos.getIdeBenef());
		
	}
}
