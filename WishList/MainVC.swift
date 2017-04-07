//
//  ViewController.swift
//  WishList
//
//  Created by Kuala on 2017-04-06.
//  Copyright © 2017 Litroom. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController ,UITableViewDelegate,UITableViewDataSource,NSFetchedResultsControllerDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    var controller : NSFetchedResultsController<Item>!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate=self
        tableView.dataSource=self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    func attemptFetch(){
        let fetchRequest:NSFetchRequest<Item>=Item.fetchRequest()
        let dateSort=NSSortDescriptor(key: "created", ascending: false)
        fetchRequest.sortDescriptors=[dateSort]
        controller=NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        do{
            try controller.performFetch()
        }catch{
            let error = error as NSError
            print("\(error)")
        }
    }
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch(type)
        {
        case.insert:
            if let index=newIndexPath{
                tableView.insertRows(at: [index], with: .fade)
            }
            break
        case.delete:
            if let index=indexPath{
                tableView.deleteRows(at: [index], with: .fade)
            }
            break
        case.update:
            if let index=indexPath{
                let cell=tableView.cellForRow(at: index) as! ItemCell
            }
            break
        case.move:
            if let index=indexPath{
                tableView.deleteRows(at: [index], with: .fade)
            }
            if let index=newIndexPath{
                tableView.insertRows(at: [index], with: .fade)
            }
            break
        }
    }

}

