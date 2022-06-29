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
        
        NetworkManager.shared.fetchData() { drink in
            self.margaritas = drink.drinks
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let detailVC = segue.destination as? MargaritasDetailViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        guard let cell = tableView.cellForRow(at: indexPath) as? MargaritaViewCell else { return }
        
        detailVC.margarita = margaritas[indexPath.row]
        detailVC.margaritasImage = cell.margaritasImage.image
        
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        margaritas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "margaritaCell", for: indexPath) as? MargaritaViewCell else { return UITableViewCell() }
        
        let margarita = margaritas[indexPath.row]
        
        cell.margaritasNameLabel.text = margarita.strDrink
        cell.margaritasComponentLabel.text = margarita.composition
        
        NetworkManager.shared.fetchImage(with: margarita) { data in
            DispatchQueue.main.async {
                cell.margaritasImage.image = UIImage(data: data)
            }
        }
        return cell
    }
}
