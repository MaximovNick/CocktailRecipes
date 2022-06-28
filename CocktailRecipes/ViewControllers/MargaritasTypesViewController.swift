//
//  MargaritasTypesViewController.swift
//  CocktailRecipes
//
//  Created by Nikolai Maksimov on 27.06.2022.
//

import UIKit

class MargaritasTypesViewController: UITableViewController {
    
    var margaritas: [Margarita] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 180
        
        
        NetworkManager.fetchData() { drink in
            self.margaritas = drink.drinks
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        margaritas.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "margaritaCell", for: indexPath) as? MargaritaViewCell else { return UITableViewCell() }
        
        let margarita = margaritas[indexPath.row]
        
        cell.configure(with: margarita)
        
        return cell
    }
}
