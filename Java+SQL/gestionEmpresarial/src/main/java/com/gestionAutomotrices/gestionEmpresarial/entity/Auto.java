package com.gestionAutomotrices.gestionEmpresarial.entity;

import java.util.Date;

import org.hibernate.annotations.CreationTimestamp;

import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinColumns;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name="auto",schema="dba")
@Data
@NoArgsConstructor
@Builder
@AllArgsConstructor
public class Auto {
	
	@EmbeddedId
	private AutoId autoId;
	
	@Column(name="anioFabricacion")
	@Temporal(TemporalType.DATE)
	private Date anioFabricacion;

	@Column(name="fechaDepositado")
	@CreationTimestamp
	private Date fechaDepositado;
	
	@ManyToOne
	@JoinColumn(name="idDeposito",referencedColumnName = "id")
	private Deposito deposito;
	
	@ManyToOne
	@JoinColumn(name="estado",referencedColumnName = "id")
	private EstadoAuto estado;
    
	@ManyToOne
	@MapsId("ModeloId")
    @JoinColumns({
        @JoinColumn(name = "modeloId", referencedColumnName = "id", insertable = false, updatable = false),
        @JoinColumn(name = "marcaId", referencedColumnName = "marcaId", insertable = false, updatable = false)
    })
    private Modelo modelo;
}
