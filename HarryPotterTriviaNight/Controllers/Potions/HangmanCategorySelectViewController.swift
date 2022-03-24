//
//  HangmanCategorySelectViewController.swift
//  HarryPotterTriviaNight
//
//  Created by HaroldDavidson on 3/22/22.
//  Copyright © 2022 HaroldDavidson. All rights reserved.
//

import UIKit

class HangmanCategorySelectViewController: UIViewController {
    private let categories = ["Characters", "Spells", "Locations", "Death Eaters", "Order Members", "Potions", "Magical Beasts"]
    private let table = UITableView()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    // MARK: - Setting Up the Views
    private func setupViews() {
        table.delegate = self
        table.dataSource = self
        view.addSubview(table)
        table.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }

}

extension HangmanCategorySelectViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(categories[indexPath.row])"
        print(categories[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PotionsClassViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}
