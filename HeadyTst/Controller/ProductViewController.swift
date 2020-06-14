//
//  ProductViewController.swift
//  HeadyTst
//
//  Created by Rohan Deshmukh on 14/06/20.
//  Copyright © 2020 RohanDeshmukh. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var productId:Int = 0
    var arrVariant:Array<Any> = []
    
    @IBOutlet weak var lblProductDetail: UILabel!
    
    @IBOutlet weak var tblVariants: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tblVariants.register(UINib(nibName:"CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
        
        // Do any additional setup after loading the view.
        let prodDetails:CategoryProduct = DBManager.sharedInstance.getSpecificProductDetails(productId: productId)
        arrVariant = DBManager.sharedInstance.getVariantsForProduct(productID: productId)

        self.tblVariants.reloadData()
   
        lblProductDetail.text = "ID:\(prodDetails.id)"
        
        self.title = prodDetails.name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arrVariant.count > 0 {
            return self.arrVariant.count
        }else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
          return "Product Variants"
       }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:CategoryTableViewCell = tblVariants.dequeueReusableCell(withIdentifier: "CategoryTableViewCell") as! CategoryTableViewCell
        if self.arrVariant.count > 0{
            cell.setVariantData(variantObj: self.arrVariant[indexPath.row] as! Variant)
        }else {
            cell.lblCategoryDisplay.text = "No Variant to display"
        }
        cell.selectionStyle = .none
        return cell as UITableViewCell;
        
    }
    
}
