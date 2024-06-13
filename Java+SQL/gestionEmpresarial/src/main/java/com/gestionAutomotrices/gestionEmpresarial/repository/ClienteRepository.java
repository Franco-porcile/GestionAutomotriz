package com.gestionAutomotrices.gestionEmpresarial.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.gestionAutomotrices.gestionEmpresarial.entity.Cliente;

public interface ClienteRepository extends JpaRepository<Cliente, Integer>{

}
