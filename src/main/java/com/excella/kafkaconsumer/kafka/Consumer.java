package com.excella.kafkaconsumer.kafka;

import com.excella.kafkaconsumer.fraud.FraudModel;
import com.excella.kafkaconsumer.fraud.FraudRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.kafka.support.KafkaHeaders;
import org.springframework.messaging.handler.annotation.Header;
import org.springframework.messaging.handler.annotation.Payload;

import java.sql.Timestamp;

public class Consumer {

    private final Logger logger = LoggerFactory.getLogger(getClass());
    @Autowired
    private ObjectMapper jsonMapper;

    @Autowired
    private FraudRepository fraudRepository;

    @KafkaListener(topics = { "POSSIBLE_FRAUD" }, containerFactory = "kafkaListenerContainerFactory")
    public void listen(@Payload(required = false) String message, @Header(KafkaHeaders.RECEIVED_TOPIC) String topic,
                       @Header(KafkaHeaders.RECEIVED_MESSAGE_KEY) String key) throws Exception {

        if (!isNullOrEmpty(message)) {

            FraudModel model = jsonMapper.readValue(message, FraudModel.class);

            logger.info("topic='{}'", topic);
            logger.info("received key='{}'", key);
            model.setCreatedAt(new Timestamp(System.currentTimeMillis()));
            fraudRepository.save(model);
        }
    }

    public static boolean isNullOrEmpty(String str) {
        if(str != null && !str.isEmpty())
            return false;
        return true;
    }

}
