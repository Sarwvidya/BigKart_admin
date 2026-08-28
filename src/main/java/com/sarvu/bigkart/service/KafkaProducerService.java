package com.sarvu.bigkart.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;

@Service
public class KafkaProducerService {

    private static final String TOPIC = "increment-topic";
    private int counter = 0;

    @Autowired
    private KafkaTemplate<String, String> kafkaTemplate;

    public void incrementAndSend() {
        System.out.println("Increment button pressed");
        counter++;
        kafkaTemplate.send(TOPIC, String.valueOf(counter));
        System.out.println("Sent message to Kafka topic " + TOPIC + ": " + counter);
    }
}
