package com.gestionAutomotrices.gestionEmpresarial.Entity;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Rollback;
import org.springframework.transaction.annotation.Transactional;

import com.gestionAutomotrices.gestionEmpresarial.entity.Empleado;
import com.gestionAutomotrices.gestionEmpresarial.entity.Marca;
import com.gestionAutomotrices.gestionEmpresarial.repository.EmpleadoRepository;
import com.gestionAutomotrices.gestionEmpresarial.repository.PermisoRepository;
import com.gestionAutomotrices.gestionEmpresarial.repository.SucursalRepository;

@SpringBootTest
class EmpleadoTest {

	@Autowired
	private EmpleadoRepository empleadoRepo;

	@Test
	@Transactional
	@Rollback
	public void test() {
	       int idExistente = 4;

		    
	        Empleado foundMarca = empleadoRepo.findById(idExistente).orElse(null);

	        System.out.println(foundMarca.getApellido());
		fail("Not yet implemented");
	}

}
