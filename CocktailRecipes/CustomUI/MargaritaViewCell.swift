//
//  MargaritaViewCell.swift
//  CocktailRecipes
//
//  Created by Nikolai Maksimov on 28.06.2022.
//

import UIKit

class MargaritaViewCell: UITableViewCell {
    
    @IBOutlet var margaritaImage: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
}

// MARK: - fetchImage
extension MargaritaViewCell {
    
    func configure(with margarita: Margarita) {
        guard let url = URL(string: margarita.strDrinkThumb ?? "") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            DispatchQueue.main.async {
                self.nameLabel.text = margarita.strDrink
                self.margaritaImage.image = UIImage(data: data)
            }
            
        }.resume()
    }
}
