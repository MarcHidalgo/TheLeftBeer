//
//  UIStoryboard+Extension.swift
//  TheLeftBeer
//
//  Created by Marc Hidalgo on 10/7/21.
//

import UIKit

extension UIStoryboard {
    
    static func makeViewController<T>(withId id: String) -> T? {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: id) as? T
    }
}
