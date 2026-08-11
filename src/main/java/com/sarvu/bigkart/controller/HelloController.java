package com.sarvu.bigkart.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import java.util.List;

@RestController
public class HelloController {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @GetMapping("/hello")
    public String hello() {
        return "Hello from Bigkart!";
    }

    @GetMapping("/ramtest")
    public List<String> getRamName() {
        return jdbcTemplate.queryForList("SELECT name FROM temp", String.class);
    }
}
