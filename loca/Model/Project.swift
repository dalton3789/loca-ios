//
//  Project.swift
//  loca
//
//  Created by Toan Nguyen on 5/29/19.
//  Copyright © 2019 LocaLoca. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ProjectData {
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var projectArray :[Project] = []
    var project : Project?
    
    
    public func AddProject(_ name: String, _ id: Int, _ longitude : String, _ latitude : String, _ addressNumber : String, _ street : String, _ area : String, _ ward : String, _ district : String,_ city : String) {
        let newProject = NSEntityDescription.insertNewObject(forEntityName: "Project", into: context)
        newProject.setValue(name, forKey: "name")
        newProject.setValue(id, forKey: "id")
        newProject.setValue(longitude, forKey: "longitude")
        newProject.setValue(latitude, forKey: "latitude")
        newProject.setValue(addressNumber, forKey: "addressNumber")
        newProject.setValue(street, forKey: "street")
        newProject.setValue(area, forKey: "area")
        newProject.setValue(ward, forKey: "ward")
        newProject.setValue(district, forKey: "district")
        newProject.setValue(city, forKey: "city")
        
        do {
            try context.save()
        }
        catch {
            print(error)
        }
        
    }
    
    public func GetProjects() -> [Project]{
        do{
            
            try projectArray = context.fetch(Project.fetchRequest())
        }
        catch{
            print(error)
        }
        
        return projectArray
        
    }
    
    
    public func UpdateProject(_ project: Project) {
        self.project = project
        do {
            try context.save()
        }
        catch {
            print(error)
        }
    }
    
    public func DeleteProject(_ id: String){
        do{
            
            try projectArray = context.fetch(Project.fetchRequest())
            for user in projectArray as [NSManagedObject] {
                
                if (String(describing: user.value(forKey: "id")!) == id)
                {
                    
                    context.delete(user)
                }
            }
            try context.save()
        }
        catch{
            print(error)
        }
        
        
    }
    
    public func DeleteAllProject(){
        do{
            
            try projectArray = context.fetch(Project.fetchRequest())
            for project in projectArray as [NSManagedObject] {
                
                
                context.delete(project)
                
            }
            try context.save()
        }
        catch{
            print(error)
        }
        
        
    }
    
    struct projectStruct : Codable {
        var name : String
        var id : Int
        var longitude : String
        var lattitude : String
        var addressNumber : String?
        var street : String?
        var area : String?
        var ward : String?
        var district : String?
        var city : String?
        
    }
    
    
    
}
