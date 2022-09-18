//
//  DrinkCell.swift
//  EverDrink
//
//  Created by Данил Прокопенко on 16.09.2022.
//

import UIKit

class DrinkCell: UITableViewCell {

    @IBOutlet var labelDrink: UILabel!
    @IBOutlet var categoryDrink: UILabel!
    @IBOutlet var glassDrink: UILabel!
    @IBOutlet var alcoholicDrink: UILabel!
    @IBOutlet var drinkImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        drinkImage.layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func configure(with drink: Drink) {
        
        labelDrink.text = drink.strDrink
        categoryDrink.text = drink.strCategory
        glassDrink.text = drink.strGlass
        alcoholicDrink.text = drink.strAlcoholic
        
        
        NetworkManager.shared.fetchImageWithAlamofire(drink.strDrinkThumb) { result in
            switch result {
                
            case .success(let imageData):
                self.drinkImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
        
        
        
    }
}
