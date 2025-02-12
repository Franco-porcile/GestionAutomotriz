package com.gestionAutomotrices.gestionEmpresarial.entity;

import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name="deposito",schema="dba")
@Data
@NoArgsConstructor
@Builder
@AllArgsConstructor
public class Deposito {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(name="limite")
	private int limite;
	
	@ManyToOne
	@JoinColumn(name = "sucursalId",referencedColumnName = "id")
	private Sucursal sucursal;
	
	@OneToMany(mappedBy = "deposito")
	private List<Auto>auto;
}
