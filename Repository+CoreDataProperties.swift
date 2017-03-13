//
//  Repository+CoreDataProperties.swift
//  
//
//  Created by hendi on 13/03/17.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Repository {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Repository> {
        return NSFetchRequest<Repository>(entityName: "Repository");
    }

    @NSManaged public var desc: String?
    @NSManaged public var forkCount: Int32
    @NSManaged public var name: String?
    @NSManaged public var owner: String?
    @NSManaged public var photoURL: String?
    @NSManaged public var stars: Int16
    @NSManaged public var photo: NSData?

}
