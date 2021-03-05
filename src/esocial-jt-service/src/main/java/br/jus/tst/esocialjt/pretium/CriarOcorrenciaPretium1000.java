package br.jus.tst.esocialjt.pretium;

import javax.persistence.EntityManager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.jus.tst.esocial.dominio.empregador.IdeEmpregador;
import br.jus.tst.esocial.dominio.empregador.InfoCadastro;
import br.jus.tst.esocial.dominio.empregador.InfoEmpregador;
import br.jus.tst.esocial.dominio.periodo.IdePeriodo;
import br.jus.tst.esocial.ocorrencia.OcorrenciaDTO;
import br.jus.tst.esocial.ocorrencia.TipoOcorrencia;
import br.jus.tst.esocial.ocorrencia.dados.InformacoesEmpregador;
import br.jus.tst.esocialjt.pretium.model.EmpresaEsocialResumo;
import br.jus.tst.esocialjt.pretium.model.EventoParaEnviarResumo;

@Service
public class CriarOcorrenciaPretium1000 implements CriarOcorrenciaPretium {
	
	@Autowired
	private EntityManager em;
	
	@Override
	public OcorrenciaDTO gerarOcorrencia(Long _eventosParaEnviarId) throws Exception {
		EventoParaEnviarResumo eventoParaEnviarResumo  = em.find(EventoParaEnviarResumo.class, _eventosParaEnviarId);
		EmpresaEsocialResumo empresaEsocial = em.find(EmpresaEsocialResumo.class, eventoParaEnviarResumo.getRegistroId());
		
		OcorrenciaDTO ocorrencia = new OcorrenciaDTO();
		ocorrencia.setTipoOcorrencia(TipoOcorrencia.INFORMACOES_EMPREGADOR);
		ocorrencia.setReferencia(empresaEsocial.getNrInsc());
		ocorrencia.setOperacao(eventoParaEnviarResumo.getOperacao());
		ocorrencia.setDataOcorrencia(eventoParaEnviarResumo.getDataAlteracao());
		
		IdePeriodo idePeriodo = new IdePeriodo();
		idePeriodo.setIniValid(empresaEsocial.getIniValid());
		
		InfoEmpregador infoEmpregador = new InfoEmpregador();
		infoEmpregador.setIdePeriodo(idePeriodo);
		
		InfoCadastro infoCadastro = new InfoCadastro();
		infoCadastro.setNmRazao(empresaEsocial.getRazaoSocial());
		infoCadastro.setClassTrib(empresaEsocial.getClassTrib());
		infoCadastro.setNatJurid(empresaEsocial.getNatJurid());
		infoCadastro.setIndCoop(empresaEsocial.getIndCoop().getBytes()[0]);
		infoCadastro.setIndDesFolha(empresaEsocial.getIndDesFolha().getBytes()[0]);
		infoCadastro.setIndOpcCP(empresaEsocial.getIndOpcCP());
		infoCadastro.setIndOptRegEletron(empresaEsocial.getIndoptRegEletron().getBytes()[0]);
		infoCadastro.setIndEntEd(empresaEsocial.getIndEntEd());
		infoCadastro.setIndEtt(empresaEsocial.getIndEtt());
		infoCadastro.setNrRegEtt(empresaEsocial.getNrRegEtt());
		
		/**
		 * Informações complementares - Empresas isentas -
		 * Dados da isenção.
		 */
		infoCadastro.setDadosIsencao(null);
		
		infoCadastro.setContato(null);
		infoCadastro.setInfoOP(null);
		infoCadastro.setInfoOrgInternacional(null);
		infoCadastro.setSoftwareHouse(null);
		infoCadastro.setInfoComplementares(null);
		
		
		
		InformacoesEmpregador empregador = new InformacoesEmpregador();
		
		
		IdeEmpregador ideEmpregador = new IdeEmpregador() ;
		ideEmpregador.setTpInsc((byte) 1);
		ideEmpregador.setNrInsc(empresaEsocial.getNrInsc().substring(1, 8));

		ocorrencia.getDadosOcorrencia().setIdeEmpregador(ideEmpregador);
		
		
		
		//DadosOcorrencia dados = new DadosOcorrencia(ideEmpregador);
		
		
		return null;
	}

}
