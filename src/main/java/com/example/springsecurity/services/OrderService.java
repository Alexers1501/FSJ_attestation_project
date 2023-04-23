package com.example.springsecurity.services;

import com.example.springsecurity.models.Order;
import com.example.springsecurity.models.Person;
import com.example.springsecurity.repositories.OrderRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class OrderService {

    private final OrderRepository orderRepository;

    public OrderService(OrderRepository orderRepository) {
        this.orderRepository = orderRepository;
    }

    public void save(Order newOrder) {
        orderRepository.save(newOrder);
    }

    public List<Order> findByPerson(Person person) {
        return orderRepository.findByPerson(person);
    }

    public Order findById(int id){
        Optional<Order> order = orderRepository.findById(id);
        return order.orElse(null);
    }

    public List<Order> findAll() {
        return orderRepository.findAll();
    }

    @Transactional
    public void updateOrder(int id, Order order){
        order.setId(id);
        orderRepository.save(order);

    }

    @Transactional
    public void deleteById(int id){
        orderRepository.deleteById(id);
    }

    public List<Order> findByLastSymbols(String symbols){
        return orderRepository.findByNumberByLastFourSymbols(symbols);
    }
}
