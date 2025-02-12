package com.gestionAutomotrices.gestionEmpresarial.entity;

import java.time.LocalDateTime;


import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinColumns;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "venta",schema = "dba")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Venta {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int nroTransaccion;
	
	@Column(name = "fechaVenta")
	@Temporal(TemporalType.TIMESTAMP)
	private LocalDateTime fechaVenta;
	
	@ManyToOne
	@JoinColumn(name = "finanzasId",referencedColumnName = "id")
	private Empleado empleadoFinanzas;

	@ManyToOne
	@JoinColumn(name = "empleadoId",referencedColumnName = "id")
	private Empleado empleadoVentas;
	
	@ManyToOne
	@JoinColumn(name = "estado",referencedColumnName = "id")
	private EstadoVenta estado;
	
	@OneToOne
	@JoinColumns({
		@JoinColumn(name = "autoId",referencedColumnName = "id"),
		@JoinColumn(name = "autoModeloId",referencedColumnName = "modeloId"),
		@JoinColumn(name = "autoMarcaId",referencedColumnName = "marcaId")
	})
	private Auto auto;
	
	@ManyToOne
	@JoinColumn(name = "clienteId",referencedColumnName = "id")
	private Cliente cliente;
}
