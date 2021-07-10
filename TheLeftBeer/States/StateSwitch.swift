//
//  StateSwitch.swift
//  TheLeftBeer
//
//  Created by Marc Hidalgo on 9/7/21.
//

import Foundation

protocol StateSwich: AnyObject {
    
    func switchTo(state: State, error:Error?)
}
