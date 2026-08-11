# New Project and RDS Connection

This document outlines the steps taken to connect the Bigkart Spring Boot application to an AWS RDS MySQL instance and set up a basic data retrieval endpoint.

## 1. Database Setup via CloudShell (MySQL Client)

Connected to the RDS instance using the following command:

```bash
mysql -h db-bigkart.c9cuu68as97f.ap-south-1.rds.amazonaws.com -P 3306 -u admin -p
```

Once connected, created the database and a temporary table:

```sql
-- Check existing databases
show databases;

-- Create the new database
CREATE DATABASE bigkartDB;

-- Switch to the newly created database
USE bigkartDB;

-- Create a temporary table to test data retrieval
CREATE TABLE temp (
    name VARCHAR(25) PRIMARY KEY
);

-- Insert a test record
INSERT INTO temp (name) VALUES ('ram');
```

## 2. Spring Boot Application Configuration

### `pom.xml` Dependencies
Uncommented the `spring-boot-starter-data-jpa` dependency to enable database connection capabilities:

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-jpa</artifactId>
</dependency>
```

### `application.properties`
Configured the properties file to point to the new `bigkartDB` database on the RDS instance:

```properties
spring.application.name=bigkart

# RDS Connection configuration
spring.datasource.url=jdbc:mysql://db-bigkart.c9cuu68as97f.ap-south-1.rds.amazonaws.com:3306/bigkartDB
spring.datasource.username=admin
spring.datasource.password=12345678
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver

# JPA / Hibernate configuration
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
```

## 3. Controller Implementation

Updated the controller to inject `JdbcTemplate` and created a GET endpoint (`/ram`) to directly retrieve the names from the `temp` table.

```java
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

    @GetMapping("/ram")
    public List<String> getRamName() {
        return jdbcTemplate.queryForList("SELECT name FROM temp", String.class);
    }
}
```
