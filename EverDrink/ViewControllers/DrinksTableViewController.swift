//
//  DrinksTableViewController.swift
//  EverDrink
//
//  Created by Данил Прокопенко on 16.09.2022.
//

import UIKit

class DrinksTableViewController: UITableViewController {

    //MARK: - IBOutlets
    @IBOutlet var searchBar: UISearchBar!
    
    //MARK: - Private Properties
    private var drinks: [Drink] = []
    private var filteredDrinks: [Drink] = []
    private var prefix: String?
    
    //MARK: - VC Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshControl()
        setUI()
        getData()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        filteredDrinks = drinks
        
    }
    
    //MARK: - Appearance
    
    private func setUI() {
        navigationItem.title = "Cocktails"
        navigationItem.largeTitleDisplayMode = .always
        self.tableView.keyboardDismissMode = .onDrag
    }
    

    // MARK: - TableView DataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredDrinks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "drinkCell", for: indexPath) as? DrinkCell else {return UITableViewCell()}
        let drink = filteredDrinks[indexPath.row]
        cell.configure(with: drink)
        cell.layer.cornerRadius = 20

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        300
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let drink = filteredDrinks[indexPath.row]
        performSegue(withIdentifier: "goToDrink", sender: drink)
    }

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let drinkVC = segue.destination as? DrinkViewController else {return}
        drinkVC.drink = sender as? Drink
        
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        guard let cell = tableView.cellForRow(at: indexPath) as? DrinkCell else {return}
        drinkVC.drinkImageVariable = cell.drinkImage.image
    }
    
    
    //MARK: - Networking and RefreshControl
    @objc private func getData() {
        NetworkManager.shared.fetchWithAlamofire(Link.apiLink.rawValue, prefix: prefix ?? "") { result in
            switch result {
                
            case .success(let drinks):
                self.drinks = drinks.drinks
                self.filteredDrinks = self.drinks
                self.tableView.reloadData()
                if self.refreshControl != nil {
                    self.refreshControl?.endRefreshing()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Reload Data")
        filteredDrinks = []
        refreshControl?.addTarget(self, action: #selector(getData), for: .valueChanged)
    }
}


//MARK: - SearchBar Delegate
extension DrinksTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var filteredDrinksArray: [Drink] = []

        if searchText.isEmpty {
            filteredDrinks = drinks
            searchBar.perform(
                #selector(self.resignFirstResponder),
                with: nil,
                afterDelay: 0.1
            )
        } else {
            filteredDrinks.forEach { drink in
                if drink.strDrink.lowercased().contains(searchText.lowercased()) {
                    self.prefix = searchText.lowercased()
                    getData()
                    filteredDrinksArray.append(drink)
                    filteredDrinks = filteredDrinksArray
                }
            }
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredDrinks = []
        getData()
        tableView.reloadData()
    }
    
    
}

