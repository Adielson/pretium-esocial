package br.jus.tst.esocialjt.pretium.model;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import lombok.EqualsAndHashCode;
import lombok.ToString;

@Entity
@Table(name = "vw_empresa_esocial", schema = "esocial")
@lombok.Getter
@lombok.Setter
@ToString
@EqualsAndHashCode
public class EmpresaEsocialResumo implements Serializable, Cloneable {


	private static final long serialVersionUID = 1L;

	@Id
	private Long id;

	@Column(name = "razao_social")
	private String razaoSocial;
	
	@Column(name = "tp_insc")
	private String tpInsc;

	@Column(name = "nr_insc")
	private String nrInsc;

	@Column(name = "ini_valid")
	private String iniValid;

	@Column(name = "fim_valid")
	private String fimValid;

	@Column(name = "class_trib")
	private String classTrib;
	
	@Column(name = "nat_juridica")
	private String natJurid;

	
	@Column(name = "ind_coop")
	private String indCoop;

	@Column(name = "ind_constr")
	private String indConstr;

	@Column(name = "ind_des_folha")
	private String indDesFolha;

	/**
	Indicativo da opção pelo produtor rural pela forma de
	tributação da contribuição previdenciária, nos termos
	do art. 25, § 13, da Lei 8.212/1991 e do art. 25, § 7°, da
	Lei 8.870/1994. O não preenchimento deste campo por
	parte do produtor rural implica opção pela
	comercialização da sua produção.
	Valores válidos:
	1 - Sobre a comercialização da sua produção
	2 - Sobre a folha de pagamento
	Validação: Não preencher se classTrib for diferente de
	[07, 21].
	*/
	@Transient
	private Byte indOpcCP = null;
	
	@Column(name = "ind_opt_reg_eletron")
	private String indoptRegEletron;
	
	@Column(name = "ind_ent_ed")
	private String indEntEd;
	
	@Column(name = "ind_ett")
	private String indEtt;
	
	@Column(name = "nr_reg_ett")
	private String nrRegEtt;
	

	@Column(name = "cnpj_efr")
	private String cnpjEfr;

	@Column(name = "cnae_prep")
	private String cnaePrep;

	@Column(name = "aliq_rat")
	private BigDecimal aliqRat;

	@Column(name = "fap")
	private BigDecimal fap;

	@Column(name = "proc_adm_jud_fap_tp_proc")
	private String procAdmJudFapTpProc;

	@Column(name = "proc_adm_jud_fap_nr_proc")
	private String procAdmJudFapNrProc;

	@Column(name = "proc_adm_jud_fap_cod_susp")
	private String procAdmJudFapCodSusp;

	@Column(name = "proc_adm_jud_rat_tp_proc")
	private String procAdmJudRatTpProc;

	@Column(name = "proc_adm_jud_rat_nr_proc")
	private String procAdmJudRatNrProc;

	@Column(name = "proc_adm_jud_rat_cod_susp")
	private String procAdmJudRatCodSusp;

	@Column(name = "info_apr_nr_proc_jud")
	private String infoAprNrProcJud;

	@Column(name = "info_ent_educ_nr_insc")
	private String infoEntEducNrInsc;

	@Column(name = "info_pcd_nr_proc_jud")
	private String infoPcdNrProcJud;

	public EmpresaEsocialResumo clone() {
		try {
			return (EmpresaEsocialResumo) super.clone();
		} catch (CloneNotSupportedException e) {
			return this;
		}
	}
}
