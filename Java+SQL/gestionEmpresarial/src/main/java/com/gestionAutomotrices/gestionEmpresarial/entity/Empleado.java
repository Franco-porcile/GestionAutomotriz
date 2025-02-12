package com.gestionAutomotrices.gestionEmpresarial.entity;

import java.util.Date;


import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "empleado",schema = "dba")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Empleado {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(name = "nombre",length = 20)
	private String nombre;

	@Column(name = "apellido",length = 20)
	private String apellido;

	@Column(name="fechaIngreso")
	@Temporal(TemporalType.DATE)
	private Date fechaIngreso;

	@Column(name = "fechaNacimiento")
	@Temporal(TemporalType.DATE)
	private Date fechaNacimiento;
	
	@Column(name = "dni",length = 8)
	private String dni;
	
	@Column(name = "telefono",length = 8)
	private String telefono;
	
	@ManyToOne
	@JoinColumn(name = "sucursalId",referencedColumnName = "id")
	private Sucursal sucursal;
	
	@ManyToOne
	@JoinColumn(name = "permisoId",referencedColumnName = "id")
	private Permiso permiso;
}
