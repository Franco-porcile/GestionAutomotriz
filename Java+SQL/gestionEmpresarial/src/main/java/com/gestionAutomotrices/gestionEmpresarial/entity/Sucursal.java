package com.gestionAutomotrices.gestionEmpresarial.entity;

import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name ="sucursal",schema ="dba")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Sucursal {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@Column(name ="fechaApertura")
	@Temporal(TemporalType.DATE)
	private Date fechaApertura;
	
	@Column(name ="direccion",length = 50)
	private String direccion;
	
	@Column(name ="nombre",length = 50)
	private String nombre;
	
	@Column(name ="telefono",length = 8)
	private String telefono;	
}
