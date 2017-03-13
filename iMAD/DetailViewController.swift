//
//  DetailViewController.swift
//  iMAD
//
//  Created by hendi on 12/03/17.
//  Copyright © 2017 cuca. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    var managedObjectContext: NSManagedObjectContext? = nil

    var cellsToUpdate = [String : NSIndexPath]()
    var currentPulls : [Pull] = []

    func configureView() {
        // Update the user interface for the detail item.
        if let repo = self.detailItem {

            self.navigationItem.title = repo.name
            
            if currentPulls.count == 0 {
                Network.fetchPullRequests(for: repo.name!, from: repo.owner!) { (pulls, error) in
                    
                    if error == nil {
                        
                        if let pullRequests = pulls {
                            print("found \(pullRequests.count) pull requests")
                            self.currentPulls = pullRequests
//                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }


    var detailItem: Repository? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    // Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PullCell", for: indexPath)
        let pull = self.fetchedResultsController.object(at: indexPath)
        self.configureCell(cell, withPull: pull)
        return cell
    }
    
    func configureCell(_ cell: UITableViewCell, withPull pull: PullRequest) {
        cell.textLabel!.text = pull.authorName
        cell.detailTextLabel!.text = pull.title
        
        print("PULL: \(pull.authorName): \(pull.title)")
        
        if let data = pull.authorPhoto {
            cell.imageView?.image = UIImage(data: data as Data)
        } else {
            
            Network.downloadPhoto(from: pull.authorPhotoURL!, completionHandler: { (data, error) in
                
//                let pullImageNotification = Notification.Name("pullImageNotification_\(pull.title)")
//                let indexPath = self.tableView.indexPath(for: cell)
//                self.cellsToUpdate[pull.title!] = indexPath as NSIndexPath?
//                NotificationCenter.default.addObserver(self, selector: #selector(self.updateCell(_:)), name: pullImageNotification, object: nil)
//
//                
//                
//                DispatchQueue.main.async {
//                    self.tableView.reloadRows(at: [indexPath!], with: .automatic)
//                }
                
                cell.imageView?.image = UIImage(data: data!)
            })
        }
    }
    
    func updateCell(_ notification : NSNotification) {
        
        let array = notification.name.rawValue.components(separatedBy: "_")
        let indexPath = self.cellsToUpdate["\(array[1])"]
        
        NotificationCenter.default.removeObserver(self, name: notification.name, object: nil)
        DispatchQueue.main.async {
            self.tableView.reloadRows(at: [indexPath as! IndexPath], with: .automatic)
        }
        self.cellsToUpdate.removeValue(forKey: "\(array[1])")
    }

    // MARK: - Fetched results controller
    
    var fetchedResultsController: NSFetchedResultsController<PullRequest> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<PullRequest> = PullRequest.fetchRequest()
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "authorName", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "Master")
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }
    var _fetchedResultsController: NSFetchedResultsController<PullRequest>? = nil
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            self.tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            self.tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        default:
            return
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            print("updating cell")
            self.configureCell(tableView.cellForRow(at: indexPath!)!, withPull: anObject as! PullRequest)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }
    
    /*
     // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
     
     func controllerDidChangeContent(controller: NSFetchedResultsController) {
     // In the simplest, most efficient, case, reload the table view.
     self.tableView.reloadData()
     }
     */

}

