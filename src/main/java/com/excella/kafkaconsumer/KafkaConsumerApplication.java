package com.excella.kafkaconsumer;

import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.slf4j.Logger;

@SpringBootApplication
public class KafkaConsumerApplication {

	private static Logger logger = LoggerFactory.getLogger(KafkaConsumerApplication.class);

	public static void main(String[] args) {

		SpringApplication springApplication = new SpringApplication(KafkaConsumerApplication.class);

		springApplication.run(args);

		logger.info("Kafka Consumer App is ready!");
	}
}
