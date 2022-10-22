//
//  DrinkViewController.swift
//  EverDrink
//
//  Created by Данил Прокопенко on 17.09.2022.
//

import UIKit

class DrinkViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var imageView: UIView!
    @IBOutlet var drinkView: UIView!
    @IBOutlet var descriptionView: UIView!
    
    @IBOutlet var drinkImage: UIImageView!
    @IBOutlet var drinkCategory: UILabel!
    @IBOutlet var drinkGlass: UILabel!
    @IBOutlet var drinkAlcoholic: UILabel!
    @IBOutlet var drinkInstructions: UILabel!
    
    //MARK: - Public Properties
    var drink: Drink!
    var drinkImageVariable: UIImage!
    var ingredientsMeasuresDict: [String?:String?] = ["":""]

    //MARK: - VC Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupUI()
        
    }
    
    //MARK: - Private Methods
    private func setupUI() {
        ingredientsMeasuresDict = drink.dictionaryApending()

        navigationItem.title = drink.strDrink
        imageView.layer.cornerRadius = 20
        drinkView.layer.cornerRadius = 20
        descriptionView.layer.cornerRadius = 20
        drinkImage.layer.cornerRadius = 20
        
        drinkImage.image = drinkImageVariable
        drinkCategory.text = drink.strCategory
        drinkGlass.text = drink.strGlass
        drinkAlcoholic.text = drink.strAlcoholic
        drinkInstructions.text = drink.strInstructions
    }
}
    //MARK: - TableView DataSource, Delegate Methods
extension DrinkViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ingredientsMeasuresDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let ingredient = Array(ingredientsMeasuresDict.keys)[indexPath.row]
        let measure = Array(ingredientsMeasuresDict.values)[indexPath.row]
        content.text = ingredient
        content.secondaryText = measure
        content.image = UIImage(systemName: "chevron.forward")
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
    
    
  
