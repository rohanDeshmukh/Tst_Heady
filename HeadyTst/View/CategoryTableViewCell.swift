//
//  CategoryCellTableViewCell.swift
//  HeadyTst
//
//  Created by Rohan Deshmukh on 14/06/20.
//  Copyright © 2020 RohanDeshmukh. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCategoryDisplay: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setCategoryData(category: Category) {
        let cateName = category.name
        if cateName != nil {
            self.lblCategoryDisplay.text = cateName
        }else {
            self.lblCategoryDisplay.text = "Not there"
        }
    }
    
    public func setProductData(categoryProd: CategoryProduct) {
        let catePName = categoryProd.name
        if catePName != nil {
            self.lblCategoryDisplay.text = catePName
        }else {
            self.lblCategoryDisplay.text = "Not there"
        }
    }
    
    public func setVariantData(variantObj: Variant) {
        let catePName = "Color:\(variantObj.color ?? "NA") Size:\(variantObj.size ?? 0) Price:\(variantObj.price ?? 0)"
        self.lblCategoryDisplay.text = catePName
    }
}
