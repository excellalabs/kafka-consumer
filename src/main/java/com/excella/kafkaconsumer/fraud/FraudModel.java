package com.excella.kafkaconsumer.fraud;


import com.fasterxml.jackson.annotation.JsonIgnore;
import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonProperty;
import org.springframework.data.annotation.CreatedDate;

import java.util.Date;

@Entity
@Table(name = "possible_frauds")
public class FraudModel {

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Long id;

    @JsonProperty("NAME")
    @Column(name="name")
    private String name;

    @JsonProperty("CREDIT_CARD")
    @Column(name = "credit_card")
    private String creditCard;

    @JsonProperty("TOTAL_AMOUNT")
    @Column(name = "total_amount")
    private double totalAmount;

    @JsonProperty("TRANSACTION_COUNT")
    @Column(name = "transaction_count")
    private int transactionCount;

    @JsonIgnore
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_at", nullable = false, updatable = false)
    @CreatedDate
    private Date createdAt;

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
}
