//
//  ErrorViewController.swift
//  TheLeftBeer
//
//  Created by Marc Hidalgo on 10/7/21.
//

import UIKit

protocol ErrorBeerListViewControllerDelegate: AnyObject {
    
    func didRetry()
}

class ErrorViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var retryButton: UIButton!
    
    weak var delegate: ErrorBeerListViewControllerDelegate?
    
    var error:Error?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setErrorLabel(error: error)
       
    }
    
    @IBAction func retryButtonTapped(_ sender: UIButton) {
        
        StateSettings.shared.didRetry = true
        delegate?.didRetry()
        
    }
}

extension ErrorViewController {
    
    func setErrorLabel(error:Error?) {
        
        guard let error = self.error else {
            self.errorLabel.text = "Error"
            return
        }
        self.errorLabel.text = error.localizedDescription
        
    }
    
}
