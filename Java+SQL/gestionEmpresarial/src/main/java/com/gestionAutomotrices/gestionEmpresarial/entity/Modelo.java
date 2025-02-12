package com.gestionAutomotrices.gestionEmpresarial.entity;

import java.math.BigDecimal;
import java.util.Date;


import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
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
@Table(name="modelo",schema ="dba")
@Data
@NoArgsConstructor
@Builder
@AllArgsConstructor
public class Modelo {

	@EmbeddedId
	private ModeloId modeloId;
	
	@Column(name="nombre",nullable = false,length = 20)
	private String nombre;
	
	@Column(name = "anio")
	@Temporal(TemporalType.DATE)
	private Date anio;
	
	@Column(name="costo",precision = 12,scale = 2)
	private BigDecimal costo;

	@ManyToOne(fetch = FetchType.LAZY)
    @MapsId("marcaId") 
    @JoinColumn(name = "marcaId",referencedColumnName = "id")
    private Marca marca;

}
