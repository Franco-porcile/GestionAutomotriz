package com.gestionAutomotrices.gestionEmpresarial.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gestionAutomotrices.gestionEmpresarial.entity.Empleado;
import com.gestionAutomotrices.gestionEmpresarial.repository.EmpleadoRepository;

@Service
public class EmpleadoService {

	@Autowired
	private EmpleadoRepository empleadoRepo;
	
	@Autowired
	private VentaService ventaService;
	
	@Transactional
	public void ingresarVentaEmpleado(String nombre,String apellido,String dni,String telefono,int idAuto,int modelo,int marca,int idEmpleado) {
		Optional<Empleado> optionalEmpleado =empleadoRepo.findById(idEmpleado);
		if(optionalEmpleado.isPresent()) {
			Empleado empleado = optionalEmpleado.get();
			if(empleado.getPermiso().getNombre().equals("vendedor")) {
				ventaService.ingresarVenta(nombre, apellido, dni, telefono, idAuto, modelo, marca, idEmpleado);
			}
		}
		else
			System.out.println("Empleado no encontrado");
	}
	
	@Transactional
	public void aceptarVentaEmpleado(int idTransaccion, int idEmpleado) {
		Optional<Empleado> optionalEmpleado = empleadoRepo.findById(idEmpleado);
		if(optionalEmpleado.isPresent()) {
			Empleado empleado = optionalEmpleado.get();
			if(empleado.getPermiso().getNombre().equals("finanzas")) {
				ventaService.aceptarVenta(idTransaccion,idEmpleado);
			}
		}
	}
	@Transactional
	public void rechazarVentaEmpleado(int idTransaccion, int idEmpleado) {
		Optional<Empleado> optionalEmpleado = empleadoRepo.findById(idEmpleado);
		if(optionalEmpleado.isPresent()) {
			Empleado empleado = optionalEmpleado.get();
			if(empleado.getPermiso().getNombre().equals("finanzas")) {
				ventaService.rechazarVenta(idTransaccion,idEmpleado);
			}
		}
	}
	
	@Transactional
	public void pedirCambioDeposito(int idPedido,int idAuto,int idDeposito) {
		Optional<Empleado> optionalEmpleado = empleadoRepo.findById(idPedido);
		if(optionalEmpleado.isPresent()) {
			Empleado empleado = optionalEmpleado.get();
			if(empleado.getPermiso().getNombre().equals("gerente")) {
				empleadoRepo.pedirCambioDeposito(idPedido, idAuto, idDeposito);
			}
		}
	}

	@Transactional
	public void aceptarCambioDeposito(int idEmpleado,int idAuto) {
		Optional<Empleado> optionalEmpleado = empleadoRepo.findById(idEmpleado);
		if(optionalEmpleado.isPresent()) {
			Empleado empleado = optionalEmpleado.get();
			if(empleado.getPermiso().getNombre().equals("deposito")) {
				empleadoRepo.aceptarCambioDeposito(idEmpleado, idAuto);
			}
		}
	}
	
	@Transactional
	public void recibirCambioDeposito(int idEmpleado,int idAuto) {
		Optional<Empleado> optionalEmpleado = empleadoRepo.findById(idEmpleado);
		if(optionalEmpleado.isPresent()) {
			Empleado empleado = optionalEmpleado.get();
			if(empleado.getPermiso().getNombre().equals("deposito")) {
				empleadoRepo.recibirCambioDeposito(idEmpleado, idAuto);
			}
		}
	}
}
