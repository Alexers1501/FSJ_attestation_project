package com.example.springsecurity.controllers;

import com.example.springsecurity.models.Category;
import com.example.springsecurity.repositories.ProductRepository;
import com.example.springsecurity.services.CategoryService;
import com.example.springsecurity.services.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/product")
public class ProductController {
    //заменить потом методы из репозитория на методы из сервиса
    private final ProductRepository productRepository;
    private final ProductService productService;

    private final CategoryService categoryService;

    public ProductController(ProductRepository productRepository, ProductService productService, CategoryService categoryService) {
        this.productRepository = productRepository;
        this.productService = productService;
        this.categoryService = categoryService;
    }

    @GetMapping("")
    public String getAllProduct(Model model){
        model.addAttribute("products", productService.getAllProduct());
        model.addAttribute("categories", categoryService.getAllCategory());
        return "/product/product";
    }

    @GetMapping("/info/{id}")
    public String infoProduct(@PathVariable("id") int id, Model model){
        model.addAttribute("product", productService.getProductById(id));
        return "/product/infoProduct";
    }

    @PostMapping("/search")
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
        return "/product/product";
    }
}
