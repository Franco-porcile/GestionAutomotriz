package com.gestionAutomotrices.gestionEmpresarial.Entity;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Rollback;
import org.springframework.transaction.annotation.Transactional;

import com.gestionAutomotrices.gestionEmpresarial.entity.Marca;
import com.gestionAutomotrices.gestionEmpresarial.entity.Modelo;
import com.gestionAutomotrices.gestionEmpresarial.entity.ModeloId;
import com.gestionAutomotrices.gestionEmpresarial.repository.ModeloRepository;

@SpringBootTest
class ModeloTest {

	@Autowired
	private ModeloRepository modeloRepo;

	@Transactional
	@Rollback
	@Test
	public void modeloTest() {
	       ModeloId idExistente = new ModeloId(1,1);
		    
	        Modelo foundMarca = modeloRepo.findById(idExistente).orElse(null);

	        System.out.println(foundMarca.getModeloId()+foundMarca.getNombre()+foundMarca.getMarca());
		fail("Not yet implemented");
	}

}
