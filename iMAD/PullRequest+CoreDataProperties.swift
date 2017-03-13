//
//  PullRequest+CoreDataProperties.swift
//  
//
//  Created by hendi on 13/03/17.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension PullRequest {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PullRequest> {
        return NSFetchRequest<PullRequest>(entityName: "PullRequest");
    }

    @NSManaged public var title: String?
    @NSManaged public var body: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var authorName: String?
    @NSManaged public var authorPhotoURL: String?
    @NSManaged public var authorPhoto: NSData?

}
