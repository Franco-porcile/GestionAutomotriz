package com.gestionAutomotrices.gestionEmpresarial.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.gestionAutomotrices.gestionEmpresarial.entity.Auto;
import com.gestionAutomotrices.gestionEmpresarial.entity.AutoId;

public interface AutoRepository extends JpaRepository<Auto,AutoId>{

	
}
