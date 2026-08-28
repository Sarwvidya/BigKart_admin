package com.sarvu.bigkart.controller;

import com.sarvu.bigkart.service.KafkaProducerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class AdminController {

    @Autowired
    private KafkaProducerService kafkaProducerService;

    @GetMapping("/")
    public String showIndexPage() {
        return "index";
    }

    @GetMapping("/kafka-test")
    public String showKafkaPage() {
        return "admin-kafka";
    }

    @PostMapping("/increment")
    @ResponseBody
    public String incrementCounter() {
        kafkaProducerService.incrementAndSend();
        return "Success";
    }
}
