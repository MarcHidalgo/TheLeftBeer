//
//  StateProvider.swift
//  TheLeftBeer
//
//  Created by Marc Hidalgo on 9/7/21.
//
import UIKit

protocol StateProvider: AnyObject {
    
    var initialState: State { get }
    var title: String { get }
    var stateSwitch: StateSwich? { get set }
    
    func contentViewController() -> UIViewController
    func errorViewController(error: Error?) -> UIViewController?
    func emptyViewController() -> UIViewController?
    
}
