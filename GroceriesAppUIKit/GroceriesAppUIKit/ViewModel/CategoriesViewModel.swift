//
//  CategoriesViewModel.swift
//  GroceriesAppUIKit
//
//  Created by USER on 7/12/24.
//

import UIKit

struct CategoriesViewModel {
    let categoriesList: [CategoryCardModel] =
    [
        .init(title: "Frash Fruits & Vegetable", image: Images.Category.fruitsVegs, color: UIColor.Cards.fruitVeg, borderColor: UIColor.Cards.fruitVeg),
        .init(title: "Beverages", image: Images.Category.beverages, color: UIColor.Cards.beverage, borderColor: UIColor.Cards.beverage),
        .init(title: "Bakery and Snacks", image: Images.Category.bakery, color: UIColor.Cards.bakery, borderColor: UIColor.Cards.bakery),
        .init(title: "Cooking Oil & Ghee", image: Images.Category.oils, color: UIColor.Cards.oils, borderColor: UIColor.Cards.oils),
        .init(title: "Dairy & Eggs", image: Images.Category.dairyEggs, color: UIColor.Cards.dairyEggs, borderColor: UIColor.Cards.dairyEggs),
        .init(title: "Meat & Fish", image: Images.Category.meatFish, color: UIColor.Cards.meatFish, borderColor: UIColor.Cards.meatFish),
        .init(title: "Cooking Oil & Ghee", image: Images.Category.oils, color: UIColor.Cards.oils, borderColor: UIColor.Cards.oils),
        .init(title: "Dairy & Eggs", image: Images.Category.dairyEggs, color: UIColor.Cards.dairyEggs, borderColor: UIColor.Cards.dairyEggs),
        .init(title: "Meat & Fish", image: Images.Category.meatFish, color: UIColor.Cards.meatFish, borderColor: UIColor.Cards.meatFish),
        .init(title: "Beverages", image: Images.Category.beverages, color: UIColor.Cards.beverage, borderColor: UIColor.Cards.beverage)
    ]
    
    private(set) var filteredCategoriesList: [CategoryCardModel] = []
    
    init() {
        filteredCategoriesList = categoriesList
    }
    
    mutating func filterCategories(with query: String) {
        if query.isEmpty {
            filteredCategoriesList = categoriesList
        } else {
            filteredCategoriesList = categoriesList.filter { $0.title.lowercased().contains(query.lowercased()) }
        }
    }
}
