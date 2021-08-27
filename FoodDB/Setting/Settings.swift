//
//  Settings.swift
//  FoodDB
//
//  Created by Navid Sheikh on 14/08/2021.
//

import Foundation
import UIKit


enum Settings : Int, CustomStringConvertible, CaseIterable {
    var imageSetting :  String{
        switch self {
        
        case .Home:
            return "house"
        case .Liked:
            return "heart"
        case .Settings:
            return "gear"
        case .Help:
            return "questionmark.circle"
        case .About:
            return "info.circle"
        }
    }
    
    var description: String{
        switch self
        {
        case .Home:
            return "Home"
        case .Liked:
            return "Liked"
        case .Settings:
            return "Settings"
        case .Help:
            return "Help"
        case .About:
            return "About"
        }
    }
    
    case Home
    case Liked
    case Settings
    case Help
    case About
    
}


enum SettingsV2 : Int, CustomStringConvertible, CaseIterable {  
  
    
    case Home
    case Help
    case AboutUs
    case Version
    
    var description: String{
        switch self {
        case .Home:
            return "Home"
        
        case .Help:
            return "Help"
        case .AboutUs:
            return "About Us"
        case .Version:
            return "Version 1.0"
        }
    }
    
    
    
    var imageSetting : String {
        switch self {
        case .Home:
            return "house"
        case .Help:
            return "questionmark.circle"
        case .AboutUs:
            return "info.circle"
        case .Version:
            return "clock.arrow.2.circlepath"
        }
    }
    
    
}
