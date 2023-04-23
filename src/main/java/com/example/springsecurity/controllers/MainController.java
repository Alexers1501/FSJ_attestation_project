package com.example.springsecurity.controllers;


import com.example.springsecurity.enums.Status;
import com.example.springsecurity.models.*;
import com.example.springsecurity.repositories.ProductRepository;
import com.example.springsecurity.security.PersonDetails;
import com.example.springsecurity.services.*;
import com.example.springsecurity.util.PersonValidator;
import jakarta.validation.Valid;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Controller
public class MainController {

    private final CategoryService categoryService;

    private final ProductRepository productRepository;

    private final PersonValidator personValidator;
    private final PersonService personService;

    private final ProductService productService;

    private final CartService cartService;

    private final OrderService orderService;

    public MainController(CategoryService categoryService, ProductRepository productRepository, PersonValidator personValidator, PersonService personService, ProductService productService, CartService cartService, OrderService orderService) {
        this.categoryService = categoryService;
        this.productRepository = productRepository;
        this.personValidator = personValidator;
        this.personService = personService;
        this.productService = productService;
        this.cartService = cartService;
        this.orderService = orderService;
    }

    @GetMapping("/personal_account")
    public String index(Model model){
        // получаем объект аутентификации -> с помощью SpringContextHolder обращаемся к конексту и на нем вызываем метод аутентификации. Из сессии теукущего пользователя получаем объект, который был положен в данную сессию после аутентификации пользователя
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        PersonDetails personDetails = (PersonDetails) authentication.getPrincipal();
        String role = personDetails.getPerson().getRole();
        if (role.equals("ROLE_ADMIN")){
            return "redirect:/admin";
        }
        model.addAttribute("products", productService.getAllProduct());
        model.addAttribute("categories", categoryService.getAllCategory());
        return "/user/index";
    }

    @GetMapping("/registration")
    public String registration(@ModelAttribute("person") Person person){
        return "registration";
    }

    @PostMapping("/registration")
    public String resultRegistration(@ModelAttribute("person") @Valid Person person, BindingResult bindingResult){
        personValidator.validate(person, bindingResult);
    if (bindingResult.hasErrors()){
        return "registration";
    }
    personService.register(person);
    return "redirect:/personal_account";
    }
    

    @GetMapping("/personal_account/product/info/{id}")
    public String infoProduct(@PathVariable("id") int id, Model model){
        model.addAttribute("product", productService.getProductById(id));
        return "/user/infoProduct";
    }

    @PostMapping("/personal_account/product/search")
    public String productSearch(@RequestParam("search") String search, @RequestParam("ot") String ot, @RequestParam("do") String Do, @RequestParam(value = "price", required = false, defaultValue = "") String price, @RequestParam(value = "contract", required = false, defaultValue = "") String contract, Model model){
        model.addAttribute("products", productService.getAllProduct());

        List<Category> categories = categoryService.getAllCategory();
        model.addAttribute("categories", categories);

        if(!ot.isEmpty() && !Do.isEmpty()){
            if(!price.isEmpty()){
                if(price.equals("sorted_by_ascending_price")){
                    if(!contract.isEmpty()){
                        for (Category category : categories){
                            if(contract.equals(category.getDbName())){
                                model.addAttribute("search_product", productRepository.findByTitleAndCategoryOrderByPriceAsc(search.toLowerCase(), Float.parseFloat(ot), Float.parseFloat(Do), category.getId()));
                            }
                        }
                    }
                    else{
                        model.addAttribute("search_product", productRepository.findByTitleOrderByPriceAsc(search.toLowerCase(), Float.parseFloat(ot), Float.parseFloat(Do)));
                    }
                }
                else if (price.equals("sorted_by_descending_price")){
                    if(!contract.isEmpty()){
                        for (Category category : categories){
                            if(contract.equals(category.getDbName())){
                                model.addAttribute("search_product", productRepository.findByTitleAndCategoryOrderByPriceAsc(search.toLowerCase(), Float.parseFloat(ot), Float.parseFloat(Do), category.getId()));
                            }
                        }
                    }
                    else{
                        model.addAttribute("search_product", productRepository.findByTitleOrderByPriceDesc(search.toLowerCase(), Float.parseFloat(ot), Float.parseFloat(Do)));
                    }
                }
            }
            else {
                model.addAttribute("search_product", productRepository.findByTitleAndPriceGreaterThanEqualAndPriceLessThanEqual(search.toLowerCase(), Float.parseFloat(ot), Float.parseFloat(Do)));
            }
        }
        else{
            model.addAttribute("search_product", productRepository.findByTitleContainingIgnoreCase(search));
        }

        model.addAttribute("value_search", search);
        model.addAttribute("value_price_ot", ot);
        model.addAttribute("value_price_do", Do);
        return "/user/index";
    }

    @GetMapping("/cart/add/{id}")
    public String addProductInCart(@PathVariable("id") int id, Model model){
        Product product = productService.getProductById(id);
        //извлекаем объект аутентифицированного пользователя
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        PersonDetails personDetails = (PersonDetails) authentication.getPrincipal();

        //извлекаем id пользвателя из объекта
        int id_person = personDetails.getPerson().getId();

        Cart cart = new Cart(id_person, product.getId());
        cartService.save(cart);
        return "redirect:/cart";
    }

    @GetMapping("/cart")
    public String cart(Model model){
        //извлекаем объект аутентифицированного пользователя
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        PersonDetails personDetails = (PersonDetails) authentication.getPrincipal();

        //извлекаем id пользвателя из объекта
        int id_person = personDetails.getPerson().getId();

        List<Cart> cartList = cartService.findPersonById(id_person);
        List<Product> productList = new ArrayList<>();

        //получаем продукты из корзины по id товара
        for(Cart cart : cartList){
            productList.add(productService.getProductById(cart.getProductId()));
        }

        //вычисляем тоговую цену
        float price = 0;
        for(Product product: productList){
            price += product.getPrice();
        }
        model.addAttribute("price", price);

        model.addAttribute("cart_product", productList);
        return  "/user/cart";
    }

    //TODO данный метод по сути удалит этот товар у всех рользователей, нужно доделать его
    @GetMapping("/cart/delete/{id}")
    public String deleteProductFromCart(Model model, @PathVariable("id") int id){
        //извлекаем объект аутентифицированного пользователя
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        PersonDetails personDetails = (PersonDetails) authentication.getPrincipal();

        //извлекаем id пользвателя из объекта
        int id_person = personDetails.getPerson().getId();
        List<Cart> cartList = cartService.findPersonById(id_person);
        List<Product> productList = new ArrayList<>();

        //получаем продукты из корзины по id товара
        for(Cart cart : cartList){
            productList.add(productService.getProductById(cart.getProductId()));
        }
        cartService.deleteCartByProductId(id);
        return "redirect:/cart";
    }

    @GetMapping("/order/create")
    public String order(){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        PersonDetails personDetails = (PersonDetails) authentication.getPrincipal();

        //извлекаем id пользвателя из объекта
        int id_person = personDetails.getPerson().getId();

        List<Cart> cartList = cartService.findPersonById(id_person);
        List<Product> productList = new ArrayList<>();

        //получаем продукты из корзины по id товара
        for(Cart cart : cartList){
            productList.add(productService.getProductById(cart.getProductId()));
        }

        //вычисляем тоговую цену
        float price = 0;
        for(Product product: productList){
            price += product.getPrice();
        }

        String uuid = UUID.randomUUID().toString();
        for(Product product : productList){
            Order newOrder = new Order(uuid, product, personDetails.getPerson(), 1, product.getPrice(), Status.Получен);
            orderService.save(newOrder);
            cartService.deleteCartByProductId(product.getId());
        }
        return "redirect:/orders";
    }

    @GetMapping("/orders")
    public String orderUser(Model model){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        PersonDetails personDetails = (PersonDetails) authentication.getPrincipal();

        List<Order> orderList = orderService.findByPerson(personDetails.getPerson());
        model.addAttribute("orders", orderList);
        return "/user/orders";
    }
}
