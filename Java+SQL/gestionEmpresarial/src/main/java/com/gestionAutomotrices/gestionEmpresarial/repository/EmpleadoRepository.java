package com.gestionAutomotrices.gestionEmpresarial.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

import com.gestionAutomotrices.gestionEmpresarial.entity.Empleado;

public interface EmpleadoRepository extends JpaRepository<Empleado,Integer>{

	@Procedure(name = "pedirCambioDeposito",procedureName = "dba.pedirCambioDeposito")
	void pedirCambioDeposito(	@Param("idPedido") int idPedido,
								@Param("idAuto") int idAuto,
								@Param("idDeposito") int idDeposito);
	
	@Procedure(name = "aceptarCambioDeposito",procedureName = "dba.aceptarCambioDeposito")
	void aceptarCambioDeposito(	@Param("idEmpleado") int idEmpleado,
								@Param("idAuto") int idAuto);

	@Procedure(name = "recibirCambioDeposito",procedureName = "dba.recibirCambioDeposito")
	void recibirCambioDeposito(	@Param("idEmpleado") int idEmpleado,
								@Param("idAuto") int idAuto);
	

}
