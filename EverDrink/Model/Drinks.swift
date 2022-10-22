//
//  Drinks.swift
//  EverDrink
//
//  Created by Данил Прокопенко on 16.09.2022.
//

import Foundation


struct Drinks: Codable {
    
    let drinks: [Drink]
    
    
    init(drinksData: [String:Any]) {
        let data = drinksData["drinks"] as? [[String: Any]] ?? []
        self.drinks = data.compactMap {Drink(drinkData: $0)}
    }
    static func getDrinks(from value: Any) -> Drinks? {
        guard let data = value as? [String:Any] else {return nil}
        return Drinks(drinksData: data)
    }
}

struct Drink: Codable {
    
    let strDrink: String
    let strCategory: String
    let strGlass: String
    let strAlcoholic: String
    let strDrinkThumb: String
    
    let strInstructions: String?
    let strIBA: String?
    
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    
    init(drinkData: [String: Any]) {
        strDrink = drinkData["strDrink"] as? String ?? ""
        strCategory = drinkData["strCategory"] as? String ?? ""
        strGlass = drinkData["strGlass"] as? String ?? ""
        strAlcoholic = drinkData["strAlcoholic"] as? String ?? ""
        strDrinkThumb = drinkData["strDrinkThumb"] as? String ?? ""
        strInstructions = drinkData["strInstructions"] as? String ?? ""
        strIBA = drinkData["strIBA"] as? String ?? ""
        
        strIngredient1 = drinkData["strIngredient1"] as? String ?? ""
        strIngredient2 = drinkData["strIngredient2"] as? String ?? ""
        strIngredient3 = drinkData["strIngredient3"] as? String ?? ""
        strIngredient4 = drinkData["strIngredient4"] as? String ?? ""
        strIngredient5 = drinkData["strIngredient5"] as? String ?? ""
        strIngredient6 = drinkData["strIngredient6"] as? String ?? ""
        strIngredient7 = drinkData["strIngredient7"] as? String ?? ""
        strIngredient8 = drinkData["strIngredient8"] as? String ?? ""
        strIngredient9 = drinkData["strIngredient9"] as? String ?? ""
        strIngredient10 = drinkData["strIngredient10"] as? String ?? ""
        
        strMeasure1 = drinkData["strMeasure1"] as? String ?? "-"
        strMeasure2 = drinkData["strMeasure2"] as? String ?? "-"
        strMeasure3 = drinkData["strMeasure3"] as? String ?? "-"
        strMeasure4 = drinkData["strMeasure4"] as? String ?? "-"
        strMeasure5 = drinkData["strMeasure5"] as? String ?? "-"
        strMeasure6 = drinkData["strMeasure6"] as? String ?? "-"
        strMeasure7 = drinkData["strMeasure7"] as? String ?? "-"
        strMeasure8 = drinkData["strMeasure8"] as? String ?? "-"
        strMeasure9 = drinkData["strMeasure9"] as? String ?? "-"
        strMeasure10 = drinkData["strMeasure10"] as? String ?? "-"
    }
    
    
}


extension Drink {
    
    func dictionaryApending() -> [String?: String?] {
        var allIngredients: [String?:String?] = [:]
        var ingredients: [String?] = [
            strIngredient1,
            strIngredient2,
            strIngredient3,
            strIngredient4,
            strIngredient5,
            strIngredient6,
            strIngredient7,
            strIngredient8,
            strIngredient9,
            strIngredient10
        ]

        var measures: [String?] = [
        strMeasure1,
        strMeasure2,
        strMeasure3,
        strMeasure4,
        strMeasure5,
        strMeasure6,
        strMeasure7,
        strMeasure8,
        strMeasure9,
        strMeasure10
        ]

        allIngredients = Dictionary(uniqueKeysWithValues: zip(ingredients.filter({$0 != ""}), measures))

        return allIngredients
    }
}
