//
//  User.swift
//  loca
//
//  Created by Toan Nguyen on 5/29/19.
//  Copyright © 2019 LocaLoca. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class UserData {
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var userArray :[User] = []
    var user : User?
    
    public func AddUser(_ name: String, _ id: Int, _ password : String, _ role : String, _ isPremium : Bool) {
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
        newUser.setValue(name, forKey: "name")
        newUser.setValue(id, forKey: "id")
        newUser.setValue(password, forKey: "password")
        newUser.setValue(role, forKey: "role")
        newUser.setValue(isPremium, forKey: "isPremium")
        
        do {
            try context.save()
        }
        catch {
            print(error)
        }
        
    }
    
    public func UpdateUser(_ user: User) {
        self.user = user
        do {
            try context.save()
        }
        catch {
            print(error)
        }
    }
    
    public func DeleteUser(_ id: String){
        do{
            
            try userArray = context.fetch(User.fetchRequest())
            for user in userArray as [NSManagedObject] {
                
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
    
    public func GetUser() -> [User]{
        do{
            try userArray = context.fetch(User.fetchRequest())
        }
        catch{
            print(error)
        }
        return userArray
        
    }
    
    public func DeleteAllUser(){
        do{
            
            try userArray = context.fetch(User.fetchRequest())
            for user in userArray as [NSManagedObject] {
                
                context.delete(user)
            }
            try context.save()
        }
        catch{
            print(error)
        }
    }
    
    struct userStruct : Codable {
        var name : String
        var id : Int
        var isPremium : Bool?
        var account : String?
        var role : String?
        var password : String?
    }
}
