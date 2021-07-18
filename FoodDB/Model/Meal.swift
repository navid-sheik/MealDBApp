//
//  Meal.swift
//  FoodDB
//
//  Created by Navid Sheikh on 16/07/2021.
//

import Foundation
import UIKit

struct Meal: Decodable{
    var id : String?
    var mealString:  String?
    var category: String?
    var area : String?
    var instructions : String?
    var thumbnail: String?
    var youtube : String?
    var source: String?
    
    
}
