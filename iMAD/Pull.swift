//
//  Pull.swift
//  Mad
//
//  Created by hendi on 12/03/17.
//  Copyright © 2017 cuca. All rights reserved.
//

import Foundation
import Gloss
import CoreData

extension Date {
    
    static func dateFromString(_ originalString:String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        if let date = dateFormatter.date(from: originalString) {
            return date
        }
        
        return nil
    }
    
}


struct Pull: Decodable {
    
    let title: String?
    let body: String?
    let author: PullOwner?
    let dateString: String? // ex. 2017-02-27T22:13:28Z
    let date: Date?
    
    init?(json: JSON) {
        
        self.title = "title" <~~ json
        self.body = "body" <~~ json
        self.author = "user" <~~ json
        self.dateString = "created_at" <~~ json
        
        self.date = Date.dateFromString(dateString!)
    }
    
    func save() {
        
        if let context = CoreDataManager.sharedInstance.backgroundManagedObjectContext {
            
            if !alreadyExists(inContext: context) {
                
                let entity =  NSEntityDescription.entity(forEntityName: "PullRequest", in: context)
                let pull = NSManagedObject(entity: entity!, insertInto: context)
                
                pull.setValue(self.title, forKey: "title")
                pull.setValue(self.body, forKey: "body")
                pull.setValue(self.author?.name, forKey: "authorName")
                pull.setValue(self.author?.photoURL, forKey: "authorPhotoURL")
                pull.setValue(self.date, forKey: "date")

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
        
        let request: NSFetchRequest<PullRequest>
        if #available(iOS 10.0, OSX 10.12, *) {
            request = PullRequest.fetchRequest()
        } else {
            request = NSFetchRequest(entityName: "PullRequest")
        }
        let predicate = NSPredicate(format: "title == %@", self.title!)
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


