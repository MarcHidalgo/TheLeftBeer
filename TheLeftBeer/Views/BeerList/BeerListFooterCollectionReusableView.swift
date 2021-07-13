//
//  BeerListFooterCollectionReusableView.swift
//  TheLeftBeer
//
//  Created by Marc Hidalgo on 13/7/21.
//

import UIKit

protocol BeerListFooterCollectionReusableViewDelegate:AnyObject {
    func reloadFooter()
}

class BeerListFooterCollectionReusableView: UICollectionReusableView {
        
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var retryButton: UIButton!
    
    weak var delegate:BeerListFooterCollectionReusableViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }
    @IBAction func retryButtonTapped(_ sender: UIButton) {
        delegate?.reloadFooter()
    }
}
