//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Yohannes Wijaya on 11/19/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    // MARK: - UIViewController Methods

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - UITableViewDataSource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10000
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath)
        cell.textLabel?.text = "Row # \(indexPath.row)"
        return cell
    }
}
