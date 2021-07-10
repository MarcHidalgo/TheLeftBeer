//
//  BeerListViewController.swift
//  TheLeftBeer
//
//  Created by Marc Hidalgo on 10/7/21.
//

import UIKit
import SwiftUI

protocol BeerListViewControllerDelegate: AnyObject {
    
    func didFailFetching(error:Error?)
    func didReceiveNoData()
}

final class BeerListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    private let refreshControl = UIRefreshControl()
   
    weak var delegate: BeerListViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUpRefreshCollection()
    }

}

extension BeerListViewController : UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
 
        let detailsView = DetailBeerSwiftUIView()
        
        let host = UIHostingController(rootView: detailsView)
        navigationController?.pushViewController(host, animated: true)
        
    }
}

extension BeerListViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CollectionViewCell.BeerCell, for: indexPath) as? BeerListCollectionViewCell
            else {
            
            return UICollectionViewCell.init()
        }

        configureCell(cell: cell, indexPath: indexPath)

        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
       

    }
    
}

extension BeerListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width/2 - 20 , height: 300)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)

    }
}

extension BeerListViewController{
    
    private func notifyAfterQuery(error:Error?) {
        
        switch StateSettings.shared.state {
        
            case .empty: self.delegate?.didReceiveNoData()
                
            case .error: self.delegate?.didFailFetching(error: error)
                   
            default: break
        }
    }
    
    private func configureCell(cell: BeerListCollectionViewCell, indexPath: IndexPath) {
        
        
    }
    
    func setUpRefreshCollection() {
        
        refreshControl.addTarget(self, action:#selector(didPullToRefresh(_:)), for: .valueChanged)
            collectionView.alwaysBounceVertical = true
            collectionView.refreshControl = refreshControl
        
    }
    
    @objc
    private func didPullToRefresh(_ sender: Any) {
        
        refreshControl.beginRefreshing()
        refreshControl.endRefreshing()
       
    }
}
