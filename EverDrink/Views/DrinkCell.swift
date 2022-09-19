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
    
    private var imageURL: URL? {
        didSet {
            drinkImage.image = nil
            updateImage()
        }
    }
    
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
        
        imageURL = URL(string: drink.strDrinkThumb)
        
        
    }
    
    
    private func updateImage() {
        guard let imageURL = imageURL else {return}
        getImage(from: imageURL) { result in
            switch result {
            case .success(let image):
                if imageURL == self.imageURL {
                    self.drinkImage.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getImage(from url: URL, completion: @escaping(Result<UIImage, Error>) -> Void) {
        
        if let cacheImage = ImageCache.shared.object(forKey: url.lastPathComponent as NSString) {
            completion(.success(cacheImage))
            return
        }
        
        NetworkManager.shared.fetchImageWithAlamofire(url) { result in
            switch result {
                
            case .success(let imageData):
                guard let image = UIImage(data: imageData) else {return}
                ImageCache.shared.setObject(image, forKey: url.lastPathComponent as NSString)
                completion(.success(image))
//                self.drinkImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
