//
//  StateContainerViewController.swift
//  TheLeftBeer
//
//  Created by Marc Hidalgo on 9/7/21.
//

import UIKit

enum State: Int {
    
    case content
    case error
    case empty
}

class StateContainerViewController: UIViewController, StateSwich {
   
    private let stateProvider: StateProvider
    private var currentState: State?
    
    init(stateProvider: StateProvider) {
        
        self.stateProvider = stateProvider
        
        super.init(nibName: nil, bundle: nil)
        
        self.stateProvider.stateSwitch = self
        self.title = self.stateProvider.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        switchTo(state: stateProvider.initialState, error: nil)
    }
    
    func switchTo(state: State, error: Error? = nil) {
        
        guard currentState != state else {
            return
        }
        
        currentState = state

        switch state {
        
        case .content: removePreviousChildAndAdd(viewController: stateProvider.contentViewController())
        case .error: removePreviousChildAndAdd(viewController: stateProvider.errorViewController(error: error))
        case .empty: removePreviousChildAndAdd(viewController: stateProvider.emptyViewController())
        }
    }

}
