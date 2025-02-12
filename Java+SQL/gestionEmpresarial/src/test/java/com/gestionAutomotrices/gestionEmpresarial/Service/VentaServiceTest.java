package com.gestionAutomotrices.gestionEmpresarial.Service;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Rollback;
import org.springframework.transaction.annotation.Transactional;

import com.gestionAutomotrices.gestionEmpresarial.entity.Venta;
import com.gestionAutomotrices.gestionEmpresarial.repository.VentaRepository;
import com.gestionAutomotrices.gestionEmpresarial.service.VentaService;

@SpringBootTest
class VentaServiceTest {

    @Autowired
    private VentaService ventaService;

    @Autowired
    private VentaRepository ventaRepo;

    @Test
    @Transactional
    @Rollback
    void ingresarVentaTest() {
        String nombre = "Prueba";
        String apellido = "DesdeJava2";
        String dni = "85236379";
        String telefono = "83236979";
        int idAuto = 2;
        int modelo = 2;
        int marca = 1;
        int idEmpleado = 3;
        ventaService.ingresarVenta(nombre, apellido, dni, telefono, idAuto, modelo, marca, idEmpleado);
        Venta ventaActual = ventaRepo.findAll()
                .stream()
                .filter(cVenta -> cVenta.getCliente().getDni().equals(dni))
                .findFirst()
                .orElse(null);

        assertEquals(dni, ventaActual.getCliente().getDni());
    }

    @Test
    @Transactional
    @Rollback
    void aceptarVentaTest() {
        String dni = "85236379";
        
        int idTransaccion = 6;
        int idEmpleadoFinanzas = 4;
        ventaService.aceptarVenta(idTransaccion, idEmpleadoFinanzas);

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
    void rechazarVentaTest() {
        int idTransaccion = 6;
        int idEmpleadoFinanzas = 4;
        String dni = "85236372";
        ventaService.rechazarVenta(idTransaccion, idEmpleadoFinanzas);

        Venta ventaActual = ventaRepo.findAll()
                .stream()
                .filter(cVenta -> cVenta.getCliente().getDni().equals(dni))
                .findFirst()
                .orElse(null);
        assertEquals(idEmpleadoFinanzas, ventaActual.getEmpleadoFinanzas().getId());
   }
}

