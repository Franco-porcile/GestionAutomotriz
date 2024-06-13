package com.gestionAutomotrices.gestionEmpresarial.Entity;



import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Rollback;
import org.springframework.transaction.annotation.Transactional;

import com.gestionAutomotrices.gestionEmpresarial.entity.Marca;
import com.gestionAutomotrices.gestionEmpresarial.repository.MarcaRepository;

@SpringBootTest
class MarcaTest {

	@Autowired
	private MarcaRepository marcaRepo;
	

	
	@Test
	public void testFindById() {
	       int idExistente = 1;
	       String valorEsperado ="Fiat" ;
	    
	       Marca foundMarca = marcaRepo.findById(idExistente).orElse(null);
	       assertEquals(valorEsperado,foundMarca.getNombre().trim());
	}

	@Test
	@Transactional
	@Rollback
	public void testInsert() {
	       String valorEsperado ="Mustang" ;
	       Marca nuevaMarca= Marca.builder()
	    		   .nombre(valorEsperado)
	    		   .build();
	       Marca savedMarca = marcaRepo.save(nuevaMarca);

	       Marca foundMarca = marcaRepo.findById(savedMarca.getId()).orElse(null);
	       assertEquals(valorEsperado, foundMarca.getNombre());
	}
	

	

}
