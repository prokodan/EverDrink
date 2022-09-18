//
//  DataManager.swift
//  EverDrink
//
//  Created by Данил Прокопенко on 17.09.2022.
//

import Foundation


class DataManager {
    
    static let shared = DataManager()
    private init() {}
    
        func dictionaryApending() -> [String?: String?] {
            var allIngredients: [String?:String?] = [:]
            var ingredients: [String?] = [
                Drink.strIngredient1,
                Drink.strIngredient2,
               
            ]

            var measures: [String?] = [
                Drink.strMeasure1,
                Drink.strMeasure2,
               
            ]

            allIngredients = Dictionary(uniqueKeysWithValues: zip(ingredients.filter({$0 != ""}), measures))

            return allIngredients
        }
    
}
