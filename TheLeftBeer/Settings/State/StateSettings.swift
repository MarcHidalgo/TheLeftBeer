//
//  StateSettings.swift
//  TheLeftBeer
//
//  Created by Marc Hidalgo on 10/7/21.
//

import Foundation

final class StateSettings {
    
    static let shared = StateSettings()
    
    var stateAfterLoading: State = .content
    var didRetry: Bool = false
    
    var state: State {
    
        return stateAfterLoading
        
    }
    
    func reset() {
        didRetry = false
    }
}
