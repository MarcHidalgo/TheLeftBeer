//
//  BeerListStateProvider.swift
//  TheLeftBeer
//
//  Created by Marc Hidalgo on 10/7/21.
//

import UIKit

class BeerListStateProvider: StateProvider {
    
    var initialState: State = .content
    var title: String = "Beers"
    weak var stateSwitch: StateSwich?
    
    func contentViewController() -> UIViewController {
        
        guard let contentViewController: BeerListViewController = UIStoryboard.makeViewController(withId: Constants.ViewController.BeerList) else {
            
            fatalError("Content could not be presented")
        }
        
        contentViewController.delegate = self
        return contentViewController
    }
    
    func errorViewController(error: Error?) -> UIViewController? {
        
        guard let errorViewController: ErrorViewController = UIStoryboard.makeViewController(withId: Constants.ViewController.Error) else {
            
            print("Error could not be presented")
            return UIViewController.init()
        }
        
        errorViewController.delegate = self
        errorViewController.error = error
        return errorViewController
    }
    
    func emptyViewController() -> UIViewController? {
        
        guard let emptyViewController: EmptyViewController = UIStoryboard.makeViewController(withId: Constants.ViewController.Empty) else {
            
            print("Empty could not be presented")
            return UIViewController.init()
        }
        
        return emptyViewController
    }

}

extension BeerListStateProvider: BeerListViewControllerDelegate {
    
    func didFailFetching(error: Error?) {
        
        stateSwitch?.switchTo(state: .error, error: error)
    }
    
    func didReceiveNoData() {
        
        stateSwitch?.switchTo(state: .empty, error: nil)
    }
}

extension BeerListStateProvider: ErrorBeerListViewControllerDelegate {
    
    func didRetry() {
        
        stateSwitch?.switchTo(state: .content, error: nil)
    }
}
