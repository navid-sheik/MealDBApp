//
//  Ingridient.swift
//  FoodDB
//
//  Created by Navid Sheikh on 27/07/2021.
//

import Foundation
import UIKit



struct ListIngredients: Decodable{
    var meals : [Ingredient]?
}
struct  Ingredient: Decodable {
    var idIngredient: String?
    var strIngredient: String?

    var strDescription: String?
    
}
