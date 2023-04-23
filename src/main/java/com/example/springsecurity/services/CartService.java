package com.example.springsecurity.services;

import com.example.springsecurity.models.Cart;
import com.example.springsecurity.repositories.CartRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CartService {

    private final CartRepository cartRepository;

    public CartService(CartRepository cartRepository) {
        this.cartRepository = cartRepository;
    }

    public void save(Cart cart) {
        cartRepository.save(cart);
    }

    public List<Cart> findPersonById(int idPerson) {
        return cartRepository.findByPersonId(idPerson);
    }

    public void deleteCartByProductId(int id) {
        cartRepository.deleteCartByProductId(id);
    }
}
