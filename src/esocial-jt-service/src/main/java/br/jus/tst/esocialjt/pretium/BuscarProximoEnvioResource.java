package br.jus.tst.esocialjt.pretium;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/proximo-envio-resource")
public class BuscarProximoEnvioResource {
	
	@Autowired
	private BuscarProximoEnvioService buscarProximoEnvio;
	
	@GetMapping(produces = "application/json;charset=UTF-8")
	public Object registrarEventoParaEnvio() throws IOException {
		
		Object resposta = buscarProximoEnvio.registrarEventoParaEnvio();
		return resposta;
		
	}

}
