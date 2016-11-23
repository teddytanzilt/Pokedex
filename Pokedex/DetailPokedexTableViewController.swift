//
//  DetailPokedexTableViewController.swift
//  Pokedex
//
//  Created by Yohannes Wijaya on 11/19/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import UIKit
import SafariServices

class DetailPokedexTableViewController: UITableViewController {
    
    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var evolutionsLabel: UILabel!
    @IBOutlet weak var toggleFavoriteLabel: UILabel!

    
    // MARK: - Stored Properties
    
    var pokemon: Pokemon?
    
    let favorites = "Favorites"
    
    enum Favorite: String {
        case Added = "Add to Favorite"
        case Removed = "Remove from Favorite"
    }
    
    // MARK: - NSCoding Methods

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.hidesBottomBarWhenPushed = true
    }
    
    // MARK: - UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let validPokemon = self.pokemon else {
            assertionFailure("No pokemon exists.")
            return
        }
        
        self.title = validPokemon.name
        
        self.setToggleFavoriteLabel()
        
        let shareActionBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(DetailPokedexTableViewController.shareActionButtonTapped))
        let characterReferenceBookmarkBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(self.characterReferenceBookmarkButtonTapped))
        self.navigationItem.rightBarButtonItems = [shareActionBarButtonItem, characterReferenceBookmarkBarButtonItem]
        
        self.characterImageView.image = UIImage(named: "\(validPokemon.name)")
        self.nameLabel.text = validPokemon.name
        self.typeLabel.text = validPokemon.type
        self.summaryLabel.text = validPokemon.summary
        self.evolutionsLabel.text = validPokemon.evolutions.count > 1 ? "\(validPokemon.name) > " + validPokemon.evolutions.joined(separator: " > ") : "\(validPokemon.name)"
    }
    
    // MARK: - UITableViewDelegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row == 5, let validPokemonName = self.pokemon?.name else { return }
        
        self.tableView.deselectRow(at: indexPath, animated: false)
            
        let standardUserDefaults = UserDefaults.standard
        var pulledFavorites = standardUserDefaults.object(forKey: self.favorites) as? [String] ?? [String]()
        
        if let validIndex = pulledFavorites.index(of: validPokemonName) {
            pulledFavorites.remove(at: validIndex)
        }
        else {
            pulledFavorites.append(validPokemonName)
        }
        
        standardUserDefaults.set(pulledFavorites, forKey: self.favorites)
        self.setToggleFavoriteLabel()
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 3 {
            return UITableViewAutomaticDimension
        }
        else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    // MARK: - Local Methods
    
    func characterReferenceBookmarkButtonTapped() {
        guard let validPokemonName = self.pokemon?.name, let validURL = URL(string: "http://pokemondb.net/pokedex/\(validPokemonName)") else {
            assertionFailure("Invalid URL detected.")
            return
        }
        let safariViewController = SFSafariViewController(url: validURL)
        self.present(safariViewController, animated: true, completion: nil)
    }
    
    func shareActionButtonTapped() {
        let activityViewController = UIActivityViewController(activityItems: [self.summaryLabel, self.characterImageView.image!], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    fileprivate func setToggleFavoriteLabel() {
        let standardUserDefaults = UserDefaults.standard
        let pulledFavorites = standardUserDefaults.object(forKey: self.favorites) as? [String] ?? [String]()
        guard let validPokemonName = self.pokemon?.name else { return }
        self.toggleFavoriteLabel.text = pulledFavorites.contains(validPokemonName) ? Favorite.Removed.rawValue : Favorite.Added.rawValue
    }
}
