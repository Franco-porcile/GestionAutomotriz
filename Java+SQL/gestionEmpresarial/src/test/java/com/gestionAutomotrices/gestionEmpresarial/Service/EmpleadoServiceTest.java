package com.gestionAutomotrices.gestionEmpresarial.Service;

import static org.junit.jupiter.api.Assertions.*;

import java.util.Optional;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Rollback;
import org.springframework.transaction.annotation.Transactional;

import com.gestionAutomotrices.gestionEmpresarial.entity.Empleado;
import com.gestionAutomotrices.gestionEmpresarial.entity.Venta;
import com.gestionAutomotrices.gestionEmpresarial.repository.VentaRepository;
import com.gestionAutomotrices.gestionEmpresarial.service.EmpleadoService;


@SpringBootTest
class EmpleadoServiceTest {

	@Autowired
	private EmpleadoService empleadoService;
	
	@Autowired
	private VentaRepository ventaRepo;
	
	@Test
	@Transactional
	@Rollback
	void ingresarVentaEmpleadoTest() {
        String nombre = "Prueba";
        String apellido = "DesdeJava2";
        String dni = "85236379";
        String telefono = "83236979";
        int idAuto = 2;
        int modelo = 2;
        int marca = 1;
        int idEmpleado = 3;
		empleadoService.ingresarVentaEmpleado(nombre, apellido, dni, telefono, idAuto, modelo, marca, idEmpleado);
		
		Venta ventaActual = null;
		for(Venta cVenta : ventaRepo.findAll()){
			if(cVenta.getCliente().getDni().equals(dni) ) {
				ventaActual = cVenta;
			}
		}
		assertEquals(dni, ventaActual.getCliente().getDni());
	}
	
    @Test
    @Transactional
    @Rollback
    void aceptarVentaEmpleadoTest() {
        String dni = "85236379";   
        int idTransaccion = 6;
        int idEmpleadoFinanzas = 4;
        empleadoService.aceptarVentaEmpleado(idTransaccion, idEmpleadoFinanzas);

        Venta ventaActual = ventaRepo.findAll()
                .stream()
                .filter(cVenta -> cVenta.getCliente().getDni().equals(dni))
                .findFirst()
                .orElse(null);

        assertEquals(idEmpleadoFinanzas, ventaActual.getEmpleadoFinanzas().getId());
    }
    
    @Test
    @Transactional
    @Rollback
    void rechazarVentaEmpleadoTest() {
    	String dni = "85236379";   
    	int idTransaccion = 6;
    	int idEmpleadoFinanzas = 4;
    	empleadoService.rechazarVentaEmpleado(idTransaccion, idEmpleadoFinanzas);;
    	
    	Venta ventaActual = ventaRepo.findAll()
    			.stream()
    			.filter(cVenta -> cVenta.getCliente().getDni().equals(dni))
    			.findFirst()
    			.orElse(null);
    	
    	assertEquals(idEmpleadoFinanzas, ventaActual.getEmpleadoFinanzas().getId());
    }

/*
		
	@Test
	@Transactional
	@Rollback
	void pedirCambioDepositoTest() {
		int idPedido;
		int idAuto;
		int idDeposito;
	}
		
	@Test
	@Transactional
	@Rollback
	void aceptarCambioDepositoTest() {
		int idEmpleado;
		int idAuto;
	}

	@Test
	@Transactional
	@Rollback
	void recibirCambioDepositoTest() {
		int idEmpleado;
		int idAuto;
	}
*/
}