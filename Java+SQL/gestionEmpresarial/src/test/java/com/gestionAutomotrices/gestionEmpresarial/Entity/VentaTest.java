package com.gestionAutomotrices.gestionEmpresarial.Entity;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.gestionAutomotrices.gestionEmpresarial.entity.Marca;
import com.gestionAutomotrices.gestionEmpresarial.entity.Venta;
import com.gestionAutomotrices.gestionEmpresarial.repository.VentaRepository;

@SpringBootTest
class VentaTest {

	@Autowired
	private VentaRepository ventaRepo;
	
	@Test
	public void VentaTest() {
	       int idExistente = 1;
	    
	       Venta foundMarca = ventaRepo.findById(idExistente).orElse(null);
	      
	       System.out.println(foundMarca.getNroTransaccion());
	       System.out.println(foundMarca.getEmpleadoVentas());
	       System.out.println(foundMarca.getFechaVenta());
	      // assertEquals(valorEsperado,foundMarca.getNombre().trim());
		fail("Not yet implemented");
	}

}
