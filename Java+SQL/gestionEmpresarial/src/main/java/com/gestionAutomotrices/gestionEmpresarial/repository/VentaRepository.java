package com.gestionAutomotrices.gestionEmpresarial.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

import com.gestionAutomotrices.gestionEmpresarial.entity.Venta;

public interface VentaRepository extends JpaRepository<Venta,Integer>{

	@Procedure(name="ingresarVenta",procedureName = "dba.ingresarVenta")
	void ingresarVenta(	@Param("nombre") String nombre,
						@Param("apellido") String apellido,
						@Param("dni") String dni,
						@Param("telefono") String telefono,
						@Param("idAuto") int idAuto,
						@Param("modelo") int modelo,
						@Param("marca") int marca,
						@Param("idEmpleado") int idEmpleado);

	@Procedure(name = "aceptarVenta",procedureName = "venta.aceptarVenta")
	void aceptarVenta(	@Param("idTransaccion") int idTransaccion, 
						@Param("idEmpleado") int idEmpleado);
	
	@Procedure(name = "rechazarVenta",procedureName = "venta.rechazarVenta")
	void rechazarVenta(	@Param("idTransaccion") int idTransaccion, 
						@Param("idEmpleado") int idEmpleado);
	
}
