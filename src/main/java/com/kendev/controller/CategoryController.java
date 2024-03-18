package com.kendev.controller;

import com.kendev.entity.Category;
import com.kendev.service.CategoryService;
import io.micronaut.http.MediaType;
import io.micronaut.http.annotation.*;
import jakarta.inject.Inject;

@Controller("/category")
public class CategoryController {
    @Inject
    CategoryService cs;

    @Get("/getAll")
    @Produces(MediaType.APPLICATION_JSON)
    public Iterable<Category> getAll() {
        return cs.getAll();
    }

    @Post("/saveCategory")
    @Produces(MediaType.APPLICATION_JSON)
    public Category saveCategory(@Body Category category) {
        return cs.saveOrupdateCategory(category);
    }
}
