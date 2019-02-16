package com.excella.kafkaconsumer.fraud;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface FraudRepository extends JpaRepository<FraudModel, Long> {

}
