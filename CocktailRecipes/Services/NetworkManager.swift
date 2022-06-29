//
//  NetworkManager.swift
//  CocktailRecipes
//
//  Created by Nikolai Maksimov on 28.06.2022.
//

import Foundation
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    // MARK: - fetchData
    func fetchData(_ completion: @escaping (Drink) -> Void) {
        
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
    
    
    // MARK: - fetchImage
    func fetchImage(with margarita: Margarita, completion: @escaping (_ data: Data) -> ()) {
        guard let url = URL(string: margarita.strDrinkThumb ?? "") else { return }
        
        URLSession.shared.downloadTask(with: url) { localUrl, _, error in
            guard let localUrl = localUrl else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let data = try Data(contentsOf: localUrl)
                completion(data)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}


