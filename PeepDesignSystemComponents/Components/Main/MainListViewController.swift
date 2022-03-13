//
//  MainListViewController.swift
//  CEAUIKitComponents
//
//  Created by Rhullian Damião on 09/06/21.
//

import UIKit
import PeepDesignSystem

class MainListViewController: UITableViewController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        title = "4PeeP Design System"
        self.removeBlackBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MainListComponents.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = MainListComponents.allCases[indexPath.row].sectionTitle
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = MainListComponents.allCases[indexPath.row].viewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
