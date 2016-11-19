//
//  DetailPokedexTableViewController.swift
//  Pokedex
//
//  Created by Yohannes Wijaya on 11/19/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import UIKit

class DetailPokedexTableViewController: UITableViewController {
    
    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var evolutionsLabel: UILabel!
    
    // MARK: - Stored Properties
    
    var pokemon: Pokemon?

    // MARK: - UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let validPokemon = self.pokemon else {
            assertionFailure("No pokemon exists.")
            return
        }
        
        self.characterImageView.image = UIImage(named: "\(validPokemon.name)")
        self.nameLabel.text = validPokemon.name
        self.typeLabel.text = validPokemon.type
        self.summaryLabel.text = validPokemon.summary
        self.evolutionsLabel.text = validPokemon.evolutions.count > 1 ? "\(validPokemon.name) > " + validPokemon.evolutions.joined(separator: " > ") : "\(validPokemon.name)"
    }

}
