//
//  ProjectListTableViewController.swift
//  loca
//
//  Created by Toan Nguyen on 5/25/19.
//  Copyright © 2019 LocaLoca. All rights reserved.
//

import UIKit

class ProjectListTableViewController: UITableViewController {

    
    var projects = [Project]()
    let sharedActions = SharedActions()
    let server = Server()
    let project = ProjectData()
    let cIndicator = CustomIndicator()
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cIndicator.addIndicator(view: self, alpha: 1.0)
        cIndicator.startIndicator(timeout: 10.0)
        getProjectsFromServer()
        
    }
    
    func getProjectsFromServer(){
        //LocaProjectAPI.getProjectList(handler: {data in self.dataParsing(data: data) })
        project.AddProject("Can 1", 1,"106.720196", "10.730591", "Phu My Hung", "Dao Tan", "Phu My Hung", "Phuong 7", "Quan 7", "Ho Chi Minh")
        getProjects()
        cIndicator.stopIndicator()
    }
    
    func dataParsing(data: Data){
        do {
            let result = try JSONDecoder().decode(projectStruct.self, from: data)
            project.DeleteAllProject()
            project.AddProject(result.name, result.id, result.longitude, result.lattitude, result.addressNumber!, result.street!, result.area!, result.ward!, result.district!, result.city!)
            getProjects()
        } catch (let error) {
            print(error.localizedDescription)
        }
    }
    
    func getProjects(){
        self.projects = self.project.GetProjects()
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "project_mapNavi" {
            let vc = segue.destination as! MapNavigationViewController
            vc.project = self.projects[selectedIndex]
        }
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
        
        cell.textLabel?.text = projects[indexPath.row].name
        //cell.textLabel?.text = "Data"
        cell.textLabel?.textColor = sharedActions.hexStringToUIColor(hex: "#696969")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedIndex = indexPath.row
        performSegue(withIdentifier: "project_mapNavi", sender: self)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }

    
}
