package com.gestionAutomotrices.gestionEmpresarial.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gestionAutomotrices.gestionEmpresarial.repository.VentaRepository;

@Service
public class VentaService {

	@Autowired
	private VentaRepository ventaRepo;
	
	@Transactional
	public void ingresarVenta(String nombre,String apellido,String dni,String telefono,int idAuto,int modelo,int marca,int idEmpleado) {
		ventaRepo.ingresarVenta(nombre, apellido, dni, telefono, idAuto, modelo, marca, idEmpleado);
	}

	@Transactional
	public void aceptarVenta(int idTransaccion, int idEmpleado) {
		ventaRepo.aceptarVenta(idTransaccion,idEmpleado);
		
	}
	@Transactional
	public void rechazarVenta(int idTransaccion, int idEmpleado) {
		ventaRepo.rechazarVenta(idTransaccion,idEmpleado);
		
	}
}
