package com.kendev.service;

import com.kendev.entity.Category;
import com.kendev.persistence.CategoryRepository;
import jakarta.inject.Inject;
import jakarta.inject.Singleton;

@Singleton
public class CategoryService {
    @Inject
    CategoryRepository categoryRepository;

    public Iterable<Category> getAll() {
        return categoryRepository.findAll();
    }

    public Category saveOrupdateCategory(Category category) {
        Category categorySaved = null;
        if (category.getId()!=null &&   categoryRepository.existsById(category.getId())) {
            categorySaved= categoryRepository.update(category);
        } else {
            categorySaved = categoryRepository.save(category);
        }
        return categorySaved;
    }

    public void deleteCategory(Long categoryId) {
        categoryRepository.deleteById(categoryId);
    }
}
