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
@Table
@Data
@NoArgsConstructor
@Builder
@AllArgsConstructor
public class CambioDeposito {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(name = "fechaPedido")
	@Temporal(TemporalType.TIMESTAMP)
	private LocalDateTime fechaPedido;

	@Column(name = "fechaAceptado")
	@Temporal(TemporalType.TIMESTAMP)
	private LocalDateTime fechaAceptado;
	
	@Column(name = "fechaRecibido")
	@Temporal(TemporalType.TIMESTAMP)
	private LocalDateTime fechaRecibido;
	
	@OneToOne
	@JoinColumns({
		@JoinColumn(name = "autoId",referencedColumnName = "id"),
		@JoinColumn(name = "autoModeloId",referencedColumnName = "modeloId"),
		@JoinColumn(name = "autoMarcaId",referencedColumnName = "marcaId")
	})
	private Auto auto;
	
	@ManyToOne
	@JoinColumn(name = "deposito", referencedColumnName = "id")
	private Deposito deposito;
	
	@ManyToOne
	@JoinColumn(name = "idEmpleadoPideTransaccion",referencedColumnName = "id")
	private Empleado empleadoPideTransaccion;
	
	@ManyToOne
	@JoinColumn(name = "idEmpleadoAcepto",referencedColumnName = "id")
	private Empleado empleadoAcepto;
	
	@ManyToOne
	@JoinColumn(name = "idEmpleadoRecibio",referencedColumnName = "id")
	private Empleado empleadoRecibio;
}
