package com.gestionAutomotrices.gestionEmpresarial.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "cliente",schema = "dba")
@Data
@NoArgsConstructor
@Builder
@AllArgsConstructor
public class Cliente {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(name = "nombre",length = 20,nullable = false)
	private String nombre;
	
	@Column(name = "apellido",length = 20,nullable = false)
	private String apellido;

	@Column(name = "dni",length = 8,nullable = false)
	private String dni;

	@Column(name = "telefono",length = 8,nullable = false)
	private String telefono;

	
}
