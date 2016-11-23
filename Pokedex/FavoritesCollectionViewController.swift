//
//  FavoritesCollectionViewController.swift
//  Pokedex
//
//  Created by Yohannes Wijaya on 11/22/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import UIKit

class FavoritesCollectionViewController: UICollectionViewController {

    // MARK: - Stored Properties
    
    var favorites = [String]()
    
    // MARK: - UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Favorites"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let userdefaults = UserDefaults.standard
        self.favorites = userdefaults.object(forKey: "Favorites") as? [String] ?? [String]()
        
        self.collectionView?.reloadData()
    }
    
    // MARK: - UICollectionViewDataSource Methods
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.favorites.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReusableCell", for: indexPath)
        
        if let validImageView = cell.viewWithTag(123) as? UIImageView {
            let pokemon = self.favorites[indexPath.item]
            validImageView.image = UIImage(named: pokemon)
        }
        
        return cell
    }
}
