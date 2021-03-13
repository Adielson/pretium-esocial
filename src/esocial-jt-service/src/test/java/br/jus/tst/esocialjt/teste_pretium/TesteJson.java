package br.jus.tst.esocialjt.teste_pretium;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;

public class TesteJson {

	public static void main(String[] args) {
		ObjectMapper objectMapper = new ObjectMapper();
		ObjectNode parentNode = objectMapper.createObjectNode();
		parentNode.put("field1", "value1");
		parentNode.put("field2", "value2");
		parentNode.put("field3", "value3");
		
		
		System.out.println(parentNode);

	}

}
