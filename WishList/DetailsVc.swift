//
//  DetailsVc.swift
//  WishList
//
//  Created by Kuala on 2017-04-07.
//  Copyright © 2017 Litroom. All rights reserved.
//

import UIKit
import CoreData

class DetailsVc: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var storePcker: UIPickerView!
    
    @IBOutlet weak var thumbImage: UIImageView!
    
    @IBOutlet weak var detailsField: CustomTextField!
    @IBOutlet weak var priceField: CustomTextField!
    
    var stores=[Store]()
    
    var itemToEdit:Item?
    
    var imagePicker:UIImagePickerController!
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        storePcker.dataSource=self
        storePcker.delegate=self
        
        imagePicker=UIImagePickerController()
        imagePicker.delegate=self
        
        //setupStores()
        fetchStores()
        
        if itemToEdit != nil{
            loadItem(item:itemToEdit!)
        }
    }
    func loadItem(item:Item){
        titleField.text=item.title
        priceField.text="\(item.price)"
        detailsField.text=item.details
        if let store = item.store
        {
            for i in 0..<stores.count
            {
                if stores[i].name == store.name
                {
                    storePcker.selectRow(i, inComponent: 0, animated: false)
                    break
                }
            }
        }
        thumbImage.image=item.image?.data as? UIImage
        
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let store = stores[row]
        return store.name
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return stores.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        // update when seelcted
    }

    
    func setupStores()
    {
        let store=Store(context: context)
        store.name="antropologies"
        let store1=Store(context: context)
        store1.name="apple store"
        let store2=Store(context: context)
        store2.name="nordostrom"
        
        ad.saveContext()
    }
    func fetchStores(){
        let fetchRequest:NSFetchRequest<Store>=NSFetchRequest(entityName: "Store")
        do{
            self.stores=try context.fetch(fetchRequest)
            self.storePcker.reloadAllComponents()
            
        }catch{
            
        }
    }
    
    @IBAction func savePressed(_ sender: Any) {
        var item:Item!
        
        if itemToEdit == nil{
            item=Item(context: context)
        }else{
            item = itemToEdit
        }
        
        if let title=titleField.text{
            item.title=title
        }
        
        if let details=detailsField.text{
            item.details=details
        }
        
        if let price=priceField.text{
            item.price=(price as NSString).doubleValue
        }
        item.store=stores[storePcker.selectedRow(inComponent: 0)]
        
        if let img=thumbImage.image{
            var image=Image(context: context)
            image.data=img
            item.image=image
        }
        ad.saveContext()
        
          //self.dismiss(animated: true, completion: nil)
         _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func deletePressed(_ sender: UIBarButtonItem) {
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        //self.dismiss(animated: true, completion: nil)
         _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func changeImagePressed(_ sender: Any) {
        present(imagePicker, animated: true,completion:  nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image=info[UIImagePickerControllerOriginalImage] as? UIImage{
            thumbImage.image=image
            
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
