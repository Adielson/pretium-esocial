package br.jus.tst.esocialjt.pretium.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import br.jus.tst.esocial.ocorrencia.Operacao;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Entity
@Table(name = "vw_empresa_esocial", schema = "esocial")
@lombok.Getter
@lombok.Setter
@ToString
@EqualsAndHashCode
public class EventoParaEnviarResumo implements Serializable, Cloneable {


	private static final long serialVersionUID = 1L;

	@Id
	private Long id;

	@Column(name = "data_alteracao")
	@Temporal(TemporalType.TIMESTAMP)
	private Date dataAlteracao;
	
	@Column(name = "est_tipo_id")
	private Integer estTipoId;
	
	@Column(name = "enviado")
	private Boolean enviado;

	@Column(name = "registro_id")
	private Integer registroId;

	@Column(name = "operacao")
	@Enumerated(EnumType.STRING)
	private Operacao operacao;

	public EventoParaEnviarResumo clone() {
		try {
			return (EventoParaEnviarResumo) super.clone();
		} catch (CloneNotSupportedException e) {
			return this;
		}
	}
}
