//
//  StartUpViewController.swift
//  TheLeftBeer
//
//  Created by Marc Hidalgo on 9/7/21.
//

import UIKit

class StartUpViewController: UIViewController {

    @IBOutlet weak var nameAppLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        StateSettings.shared.reset()
        StateSettings.shared.stateAfterLoading = .content
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @IBAction func startButtonTapped(_ sender: UIButton) {
        
        let stateProvider = BeerListStateProvider()
        let stateContainerViewController = StateContainerViewController(stateProvider: stateProvider)
        show(stateContainerViewController, sender: self)
    }
}

extension StartUpViewController {
    
    func setUp() {
        
        nameAppLabel.text = "TheLeftBeer"
        startButton.setTitle("Start", for: .normal)
        
        guard let image = UIImage(named: "Beer") else {
            return
        }
        
        logoImageView.image = image
    }
}
