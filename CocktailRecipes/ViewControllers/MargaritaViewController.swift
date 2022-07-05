//
//  MargaritaViewController.swift
//  CocktailRecipes
//
//  Created by Nikolai Maksimov on 05.07.2022.
//

import UIKit

class MargaritaViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var loadingView: UIView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var loadingLabel: UILabel!
    
    // MARK: - Public Properties
    var margaritas: [Margarita] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        
        getData()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MargaritaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        160
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        margaritas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "margaritaCell", for: indexPath) as? MargaritaViewCell else { return UITableViewCell() }
        
        let margarita = margaritas[indexPath.row]
        
        cell.margaritasNameLabel.text = margarita.strDrink
        cell.margaritasComponentLabel.text = margarita.composition
        
        NetworkManager.shared.fetchImage(from: margarita.strDrinkThumb) { result in
            switch result {
                
            case .success(let data):
                cell.margaritasImage.image = UIImage(data: data)
                
            case .failure(let error):
                print(error)
            }
        }
        return cell
    }
}

// MARK: - Navigation
extension MargaritaViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let detailVC = segue.destination as? MargaritasDetailViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        guard let cell = tableView.cellForRow(at: indexPath) as? MargaritaViewCell else { return }
        
        detailVC.margarita = margaritas[indexPath.row]
        detailVC.margaritasImage = cell.margaritasImage.image
        
    }
}

// MARK: - fetch Data
extension MargaritaViewController {
    private func getData() {
        NetworkManager.shared.fetch(dataType: Drink.self, from: Link.margaritasUrl.rawValue) { result in
            switch result {
                
            case .success(let drink):
                self.margaritas = drink.drinks
                self.tableView.reloadData()
                self.removeLoadingScreen()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - Loading Screen
extension MargaritaViewController {
    private func removeLoadingScreen() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        loadingView.isHidden = true
        loadingLabel.isHidden = true
    }
}
