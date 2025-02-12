package com.gestionAutomotrices.gestionEmpresarial.entity;

import java.time.LocalDateTime;


import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "notificacionesPendientes",schema = "dba")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class NotificacionesPendientes {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(name = "tipoNotificacion",length = 50)
	private String tipoNotificacion;

	@Column(name = "estado",length = 20)
	private String estado;
	
	@Column
	@Temporal(TemporalType.TIMESTAMP)
	private LocalDateTime fechaCreacion;
	
	@OneToOne
	@JoinColumn(name = "ventaId",referencedColumnName = "nroTransaccion")
	private Venta venta;
}
