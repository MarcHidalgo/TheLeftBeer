//
//  BeerListViewController.swift
//  TheLeftBeer
//
//  Created by Marc Hidalgo on 10/7/21.
//

import UIKit
import SwiftUI
import Nuke

protocol BeerListViewControllerDelegate: AnyObject {
    
    func didFailFetching(error:Error?)
    func didReceiveNoData()
}

final class BeerListViewController: UIViewController, LoadingHandler {
    
    @IBOutlet weak var collectionView: UICollectionView!

    private let refreshControl = UIRefreshControl()
    weak var delegate: BeerListViewControllerDelegate?
    let beerService = BeerService()
    
    private let pipeline = ImagePipeline {
        
           $0.imageCache = nil
           $0.isProgressiveDecodingEnabled = true
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchData()
        setUpRefreshCollection()
    }

}

extension BeerListViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let beer = self.beerService.beers[indexPath.row]
        
        var imageToShow:UIImage? = nil
        
        if let image = self.beerService.beerImages[beer.id] {
            imageToShow = image
        }
        
        let detailsView = DetailBeerSwiftUIView(beer: beer, image: imageToShow)
        
        let host = UIHostingController(rootView: detailsView)
        navigationController?.pushViewController(host, animated: true)
        
    }
}

extension BeerListViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return beerService.beers.count
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
       
        if indexPath.row == self.beerService.beers.count - 1 {
            
            let itemsCount = self.beerService.beers.count
            
            if !beerService.isfetchingData && beerService.fetchMore{
                
                beerService.isfetchingData = true
                
                BeerService().get(self.beerService.page, queue: .main) { [weak self] beersResult in
                         
                        guard let self = self else { return }
                        do {
                            let beers = try beersResult.get()
                            
                            if !beers.isEmpty {
                                self.beerService.beers.append(contentsOf: beers)
                            
                                self.beerService.isfetchingData = false
                                self.beerService.page += 1
                            
                                let newCount = itemsCount + (beers.count-1)
                                let indexPaths = Array(itemsCount...newCount).map { IndexPath(item: $0, section: 0) }
                                
                                DispatchQueue.main.async {

                                    self.collectionView.insertItems(at: indexPaths)
                                }
                            }else{
                                self.beerService.fetchMore = false
                            }
  
                        } catch let error {
                    
                            print(error)
                    
                        }
                    }
                }
            }

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
    
    private func fetchData() {
        
        if !self.refreshControl.isRefreshing{
            showLoading()
        }
         
        BeerService().get(1, queue: .main) { [weak self] beersResult in
            
            guard let self = self else { return }
            do {
                self.beerService.beers = try beersResult.get()
                
                StateSettings.shared.stateAfterLoading = .content
                  
                self.hideLoading()
                
                if self.refreshControl.isRefreshing{
                    self.refreshControl.endRefreshing()
                }

                self.notifyAfterQuery(error: nil)
                
                DispatchQueue.main.async {
                    
                    self.collectionView.reloadData()
                }
            
                
            } catch let error {
                
                switch error {
                
                case Constants.URLTaskError.emptyResponse:
                    
                    StateSettings.shared.stateAfterLoading = .empty
                    
                default:
                    
                    StateSettings.shared.stateAfterLoading = .error
                    
                }
                self.hideLoading()
                
                if self.refreshControl.isRefreshing{
                    self.refreshControl.endRefreshing()
                }
                
                self.notifyAfterQuery(error: error)
            }
        }
    }
    
    private func notifyAfterQuery(error:Error?) {
        
        switch StateSettings.shared.state {
        
            case .empty: self.delegate?.didReceiveNoData()
                
            case .error: self.delegate?.didFailFetching(error: error)
                   
            default: break
        }
    }
    
    private func configureCell(cell: BeerListCollectionViewCell, indexPath: IndexPath) {
        
        let beer = self.beerService.beers[indexPath.row]
        cell.beerName.text = beer.name
        
        var options = ImageLoadingOptions()
        options.pipeline = pipeline
        options.transition = .fadeIn(duration: 0.25)
        
        if self.beerService.beerImages[beer.id] == nil, let imageURL =  beer.imageUrl , let url = URL(string: imageURL){

            loadImage(with: url, options: options, into: cell.imageView) { [weak self] response in
                
                guard let self = self else {
                  return
                }
           
                switch response {
                
                    case .failure: break

                    case let .success(imageResponse): self.beerService.beerImages[beer.id] = imageResponse.image
                  
                }
            }
        }else{
            
            guard let image = self.beerService.beerImages[beer.id] else {
                return
            }
            cell.imageView.image = image
        }
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
