package com.example.springsecurity.controllers;

import com.example.springsecurity.enums.Role;
import com.example.springsecurity.models.Category;
import com.example.springsecurity.models.Image;
import com.example.springsecurity.models.Person;
import com.example.springsecurity.models.Product;
import com.example.springsecurity.services.CategoryService;
import com.example.springsecurity.services.OrderService;
import com.example.springsecurity.services.PersonService;
import com.example.springsecurity.services.ProductService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

@Controller
public class AdminController {

    private final PersonService personService;

    private final OrderService orderService;

    private final ProductService productService;

    @Value("${upload.path}")
    private String uploadPath;

    private CategoryService categoryService;

    public AdminController(PersonService personService, OrderService orderService, ProductService productService, CategoryService categoryService) {
        this.personService = personService;
        this.orderService = orderService;
        this.productService = productService;
        this.categoryService = categoryService;
    }

    @GetMapping("/admin")
    public String admin(Model model){

        model.addAttribute("products", productService.getAllProduct());

        return "admin/admin";
    }

    @GetMapping("/admin/product/add")
    public String addProduct(Model model){
        model.addAttribute("product", new Product());
        model.addAttribute("category", categoryService.getAllCategory());
        return "product/addProduct";
    }

    @PostMapping("/admin/product/add")
    public String addProduct(@ModelAttribute("product") @Valid Product product, BindingResult bindingResult,
                             @RequestParam("file_one")MultipartFile file_one,
                             @RequestParam("file_two")MultipartFile file_two,
                             @RequestParam("file_three")MultipartFile file_three,
                             @RequestParam("file_four")MultipartFile file_four,
                             @RequestParam("file_five")MultipartFile file_five,
                             @RequestParam("category") int category, Model model) throws IOException {
        Category category_db = categoryService.findById(category).orElseThrow();
        if(bindingResult.hasErrors()){
            model.addAttribute("category", categoryService.getAllCategory());
            return "/product/addProduct";
        }

        addImageToProduct(product, file_one);
        addImageToProduct(product, file_two);
        addImageToProduct(product, file_three);
        addImageToProduct(product, file_four);
        addImageToProduct(product, file_five);

        productService.saveProduct(product, category_db);
        return "redirect:/admin";
    }

    @GetMapping("/admin/product/delete/{id}")
    public String deleteProduct(@PathVariable("id") int id){
        productService.deleteProduct(id);
        return "redirect:/admin";
    }

    @GetMapping("/admin/product/edit/{id}")
    public String editProduct(Model model, @PathVariable("id") int id){
        model.addAttribute("product", productService.getProductById(id));
        model.addAttribute("category", categoryService.getAllCategory());
        return "product/editProduct";
    }

    @PostMapping("/admin/product/edit/{id}")
    public String editProduct(@ModelAttribute("product") @Valid Product product, Model model,BindingResult bindingResult, @PathVariable("id") int id){
        if (bindingResult.hasErrors()){
            model.addAttribute("category", categoryService.getAllCategory());
            return "product/editProduct";
        }
        productService.updateProduct(id, product);
        return "redirect:/admin";
    }

    @GetMapping("/admin/users/info")
    public String showUsersInfo(Model model){
        model.addAttribute("users", personService.findAll());
        return "admin/infoUsers";

    }
    @GetMapping("/admin/orders/info")
    public String showOrdersInfo(Model model){
        model.addAttribute("orders", orderService.findAll());
        return "admin/infoOrders";

    }

    @GetMapping ("/admin/users/edit/{id}")
    public String editUserInfo(Model model, @PathVariable("id") int id){
        model.addAttribute("person", personService.findById(id));
        model.addAttribute("roles", Role.values());
        return "admin/editUser";
    }
    //данный метод изменяет только роль пользователя
    @PostMapping ("/admin/users/edit/{id}")
    public String editUserInfo(@ModelAttribute("person") Person person, @PathVariable("id") int id){
        Person db_person = personService.findById(id);
        db_person.setRole(person.getRole());
        personService.updatePerson(id, db_person);
        return "redirect:/admin/users/info";
    }

    private void addImageToProduct(Product product, MultipartFile file) throws IOException {
        if(file != null){
            File uploadDir = new File(uploadPath);
            if(!uploadDir.exists()){
                uploadDir.mkdir();
            }
            String uuidFile = UUID.randomUUID().toString();
            String resultFileName = uuidFile + "." + file.getOriginalFilename();
            file.transferTo(new File(uploadPath + "/" + resultFileName));
            Image image = new Image();
            image.setProduct(product);
            image.setFileName(resultFileName);
            product.addImageToProduct(image);
        }
    }
}
