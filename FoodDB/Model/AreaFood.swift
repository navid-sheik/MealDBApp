//
//  Area.swift
//  FoodDB
//
//  Created by Navid Sheikh on 23/07/2021.
//

import Foundation
import UIKit


struct AreaFoodList : Decodable{
    var meals : [AreaFood]?
}

struct AreaFood: Decodable{
    var strArea : String?
}

