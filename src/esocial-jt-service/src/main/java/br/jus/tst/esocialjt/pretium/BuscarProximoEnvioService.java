package br.jus.tst.esocialjt.pretium;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import br.jus.tst.esocial.ocorrencia.OcorrenciaDTO;
import br.jus.tst.esocialjt.dominio.Ocorrencia;
import br.jus.tst.esocialjt.ocorrencia.OcorrenciaMapper;

@Service
public class BuscarProximoEnvioService {
	
	@Autowired
	private EntityManager em;
	
	@Transactional
	public Ocorrencia registrarEventoParaEnvio() throws IOException {
		String sql = "select cast(esocial.gerar_json() as text) as resposta;";
		
		Query q= this.em.createNativeQuery(sql);
		
		Object resposta =  q.getSingleResult();
		
		 ObjectMapper mapper = new ObjectMapper();
		 JsonNode objJson = mapper.readTree(resposta.toString());

		 OcorrenciaDTO ocorrenciaDTO= mapper.treeToValue(objJson, OcorrenciaDTO.class);
		 
		 Ocorrencia ocorrencia = OcorrenciaMapper.INSTANCE.comoOcorrencia(ocorrenciaDTO);
			ocorrencia.setDataRecebimento(
					new Date(LocalDateTime.now().atZone(ZoneId.systemDefault()).toInstant().toEpochMilli()));

		em.persist(ocorrencia);
		 
		return ocorrencia;
		
	}

}
