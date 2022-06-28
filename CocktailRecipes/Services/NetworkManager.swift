//
//  NetworkManager.swift
//  CocktailRecipes
//
//  Created by Nikolai Maksimov on 28.06.2022.
//

import Foundation


class NetworkManager {
    
    let shared = NetworkManager()
    private init() {}
    
    static func fetchData(_ completion: @escaping (Drink) -> ()) {
        
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let drink = try JSONDecoder().decode(Drink.self, from: data)
                completion(drink)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}


