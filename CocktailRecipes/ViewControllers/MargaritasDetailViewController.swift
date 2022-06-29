//
//  MargaritasDetailViewController.swift
//  CocktailRecipes
//
//  Created by Nikolai Maksimov on 27.06.2022.
//

import UIKit

class MargaritasDetailViewController: UIViewController {

    @IBOutlet var margaritasImageView: UIImageView!
    
    @IBOutlet var margaritasNameLabel: UILabel!
    
    @IBOutlet var margaritasInstructionLabel: UILabel!
    
    
    var margarita: Margarita!
    var margaritasImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        margaritasImageView.image = margaritasImage
        margaritasNameLabel.text = margarita.strDrink
        margaritasInstructionLabel.text = margarita.strInstructions
       
    }
}
