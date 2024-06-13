package com.gestionAutomotrices.gestionEmpresarial.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.gestionAutomotrices.gestionEmpresarial.entity.Modelo;
import com.gestionAutomotrices.gestionEmpresarial.entity.ModeloId;

public interface ModeloRepository extends JpaRepository<Modelo,ModeloId>{

}
