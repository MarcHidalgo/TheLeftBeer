//
//  LoadingHandler.swift
//  TheLeftBeer
//
//  Created by Marc Hidalgo on 10/7/21.
//

import UIKit

protocol LoadingHandler where Self: UIViewController {
    func showLoading()
    func hideLoading()
}

extension LoadingHandler {
    
    func showLoading() {
        
        let indicator = makeActivityIndicator()
        view.addSubview(indicator)
        
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
    
    func hideLoading() {
        
        guard let indicator = view.viewWithTag(indicatorViewTag) else {
            return
        }
        
        indicator.removeFromSuperview()
    }
    
    private func makeActivityIndicator() -> UIActivityIndicatorView {
        
        if let indicator = view.viewWithTag(indicatorViewTag) as? UIActivityIndicatorView {
            
            return indicator
        }
    
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.tag = indicatorViewTag
        indicator.startAnimating()
        return indicator
    }
}

private let indicatorViewTag = 14
