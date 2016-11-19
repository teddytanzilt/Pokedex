//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Yohannes Wijaya on 11/19/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    // MARK: - Stored Properties
    
    var pokedex = [Pokemon]()
    
    // MARK: - UIViewController Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Pokedex"
        
        self.pokedex.append(Pokemon(name: "Pidgey",
                                    type: "Normal / Flying",
                                    summary: "Pidgey is pure XP gold",
                                    evolutions: ["Pidgeotto", "Pidgeot"]))
        self.pokedex.append(Pokemon(name: "Spearow",
                                    type: "Normal / Flying",
                                    summary: "Spearow is super angry",
                                    evolutions: ["Fearow"]))
        self.pokedex.append(Pokemon(name: "Jynx",
                                    type: "Psychic",
                                    summary: "Jynx will cast a spell on you",
                                    evolutions: []))
    }

    // MARK: - UITableViewDataSource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokedex.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath)
        let pokemon = self.pokedex[indexPath.row]
        cell.imageView?.image = UIImage(named: "\(pokemon.name)-Thumb")
        cell.textLabel?.text = pokemon.name
        cell.detailTextLabel?.text = pokemon.type
        return cell
    }
}
