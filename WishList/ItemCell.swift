//
//  ItemCell.swift
//  WishList
//
//  Created by Kuala on 2017-04-06.
//  Copyright © 2017 Litroom. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var thumbnail: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var detailsLabel: UILabel!
   
    func configureCell( item:Item){
        titleLabel.text=item.title
        detailsLabel.text=item.details
        priceLabel.text="$\(item.price)"
        thumbnail.image=item.image?.data as? UIImage
    }
}
