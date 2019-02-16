package com.excella.kafkaconsumer.kafka;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.kafka.support.KafkaHeaders;
import org.springframework.messaging.handler.annotation.Header;
import org.springframework.messaging.handler.annotation.Payload;

public class Consumer {
    private final Logger logger = LoggerFactory.getLogger(getClass());

    @KafkaListener(topics = { "POSSIBLE_FRAUD" }, containerFactory = "kafkaListenerContainerFactory")
    public void listen(@Payload(required = false) String message, @Header(KafkaHeaders.RECEIVED_TOPIC) String topic,
                       @Header(KafkaHeaders.RECEIVED_MESSAGE_KEY) String key) throws Exception {

        if (!isNullOrEmpty(message)) {
            logger.info("topic='{}'", topic);
            logger.info("received message='{}'", message);
            logger.info("received key='{}'", key);
        }
    }

    public static boolean isNullOrEmpty(String str) {
        if(str != null && !str.isEmpty())
            return false;
        return true;
    }

}
