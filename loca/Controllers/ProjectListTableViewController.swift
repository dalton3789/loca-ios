//
//  ProjectListTableViewController.swift
//  loca
//
//  Created by Toan Nguyen on 5/25/19.
//  Copyright © 2019 LocaLoca. All rights reserved.
//

import UIKit

class ProjectListTableViewController: UITableViewController {

    
    let projects = ["Phú Gia", "Thảo Điền"]
    let sharedActions = SharedActions()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.projects.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "project", for: indexPath)

        cell.textLabel?.text = projects[indexPath.row]
        cell.textLabel?.textColor = sharedActions.hexStringToUIColor(hex: "#696969")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "project_map", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }

    
}
