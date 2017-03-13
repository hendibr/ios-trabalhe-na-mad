//
//  Repo.swift
//  Mad
//
//  Created by hendi on 12/03/17.
//  Copyright © 2017 cuca. All rights reserved.
//

import Foundation
import Gloss
import CoreData

struct Repo: Decodable {
    
    let name: String?
    let description: String?
    let owner: RepoOwner?
    let forkCount: Int?
    let stars: Int?
    
    init?(json: JSON) {
        
        self.name = "name" <~~ json
        self.description = "description" <~~ json
        self.owner = "owner" <~~ json
        self.forkCount = "forks_count" <~~ json
        self.stars = "stargazers_count" <~~ json
    }
    
    func save() {
        
        if let context = CoreDataManager.sharedInstance.backgroundManagedObjectContext {
            
            
            if !alreadyExists(inContext: context) {
                
                let entity =  NSEntityDescription.entity(forEntityName: "Repository", in: context)
                let repo = NSManagedObject(entity: entity!, insertInto: context)
                
                repo.setValue(self.name, forKey: "name")
                repo.setValue(self.description, forKey: "desc")
                repo.setValue(self.forkCount, forKey: "forkCount")
                repo.setValue(self.stars, forKey: "stars")
                
                repo.setValue(self.owner?.name, forKey: "owner")
                repo.setValue(self.owner?.photoURL, forKey: "photoURL")
                
                do {
                    try context.save()
                    print("saved!")
                } catch let error as NSError  {
                    print("Could not save \(error), \(error.userInfo)")
                }
            }
        }
    }
    
    private func alreadyExists(inContext:NSManagedObjectContext) -> Bool {

        let request: NSFetchRequest<Repository>
        if #available(iOS 10.0, OSX 10.12, *) {
            request = Repository.fetchRequest()
        } else {
            request = NSFetchRequest(entityName: "Repository")
        }
        let predicate = NSPredicate(format: "name == %@", self.name!)
        request.predicate = predicate
        
        do {
            let results = try inContext.fetch(request)
            
            if results.count > 0 {
                return true
            }
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        return false
    }
}

