//
//  BeerListCollectionViewCell.swift
//  TheLeftBeer
//
//  Created by Marc Hidalgo on 10/7/21.
//

import UIKit

class BeerListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var beerName: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }
    
    override func awakeFromNib() {
        
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowRadius = 4
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.4        
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 10
        
        self.backView.layer.masksToBounds = false
        self.backView.layer.cornerRadius = 10
        
        self.imageView.layer.masksToBounds = false
        self.imageView.layer.cornerRadius = 10
        
        
    }
}
