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
        
        let link = Config.host + "/api/projects"
        server.sendGETRequest(link: link, completionhandler: {data in
            self.parseProjectData(result: data)
            })
        
        
 
    }
    
    func parseProjectData(result : String){
        
        let data = result.data(using: .utf8)!
        do {
            if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>]
            {
                project.DeleteAllProject()
                
                for event in jsonArray {
                    
                    let name = event["name"] as! String
                    let longitude = event["longitude"] as! String
                    let id = event["id"] as! Int
                    let latitude = event["latitude"] as! String
                    let addressNumber = event["addressnumber"] as! String
                    let area = event["addressarea"] as! String
                    let ward = event["ward"] as! String
                    let district = event["district"] as! String
                    let city = event["city"] as! String
                    let street = event["street"] as! String
                    
                    project.AddProject(name, id, longitude, latitude, addressNumber, street, area, ward, district, city)
                }
                
                DispatchQueue.main.async{
                    self.cIndicator.stopIndicator()
                    self.getProjects()
                }
                
            } else {
                print("bad json")
            }
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    func getProjects(){
        self.projects = self.project.GetProjects()
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "project_map" {
            let vc = segue.destination as! MapViewController
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
        cell.textLabel?.textColor = sharedActions.hexStringToUIColor(hex: "#696969")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedIndex = indexPath.row
        performSegue(withIdentifier: "project_map", sender: self)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }

    
}
