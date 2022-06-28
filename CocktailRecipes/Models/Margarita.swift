//
//  Margarita.swift
//  CocktailRecipes
//
//  Created by Nikolai Maksimov on 28.06.2022.
//

import Foundation

struct Margarita: Decodable {
    let strDrink: String?
    let strCategory: String?
    let strDrinkThumb: String?
}

struct Drink: Decodable {
    let drinks: [Margarita]
}
