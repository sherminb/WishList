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
        //generateData()
        attemptFetch()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        configureCell(cell: cell,indexPath:indexPath)
        
        return cell
    }
    func configureCell(cell:ItemCell,indexPath:IndexPath){
        let item=controller.object(at: indexPath)
        cell.configureCell(item: item)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections=controller.sections{
            return sections[section].numberOfObjects
        }
        return 0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections=controller.sections{
            return sections.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func attemptFetch(){
        let fetchRequest:NSFetchRequest<Item>=Item.fetchRequest()
        let dateSort=NSSortDescriptor(key: "created", ascending: false)
        fetchRequest.sortDescriptors=[dateSort]
        controller=NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate=self
        
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
                configureCell(cell: cell, indexPath: index)
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
    func generateData(){
        let item=Item(context: context)
        item.title="iphone 7"
        item.price=600
        item.details="it's about time"
        
        let item2=Item(context:context)
        item2.title="MB shoes"
        item2.price=1000
        item2.details="One day i will own these beauties!"
        
        ad.saveContext()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let objects=controller.fetchedObjects, objects.count>0{
            let item = objects[indexPath.row]
            performSegue(withIdentifier: "DetailsVCEdit", sender: item)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsVCEdit"{
            if let dest=segue.destination as? DetailsVc{
                if let item=sender as? Item{
                    dest.itemToEdit=item
                }
            }
        }
    }

}

