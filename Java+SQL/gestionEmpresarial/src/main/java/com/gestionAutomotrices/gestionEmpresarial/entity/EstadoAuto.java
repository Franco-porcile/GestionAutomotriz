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
@Table(name = "estadoAuto", schema = "dba")
@Data
@NoArgsConstructor
@Builder
@AllArgsConstructor
public class EstadoAuto {

	@Id
	@GeneratedValue(strategy =GenerationType.IDENTITY)
	private int id;

	@Column(name = "nombre" ,nullable = false, length = 20)
	private String nombre;
}
