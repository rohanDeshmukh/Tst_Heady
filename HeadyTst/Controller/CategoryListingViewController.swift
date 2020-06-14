//
//  CategoryListingViewController.swift
//  HeadyTst
//
//  Created by Rohan Deshmukh on 14/06/20.
//  Copyright © 2020 RohanDeshmukh. All rights reserved.
//

import UIKit

class CategoryListingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tbtProductList: UITableView!
    @IBOutlet weak var tblSubCategories: UITableView!
    
    var mainCateId:Int = 0
    var categoryName:String = ""
    
    var arrSubCate:Array<Any> = []
    var arrProducts:Array<Any> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = categoryName
        
        // Do any additional setup after loading the view.
        arrSubCate  = DBManager.sharedInstance.getSubCategoriesForCategory(categoryId: mainCateId)
        arrProducts = DBManager.sharedInstance.getProductsForCategory(categoryId: mainCateId)
        
        self.tbtProductList.register(UINib(nibName:"CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
        
        self.tblSubCategories.register(UINib(nibName:"CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arrSubCate.count > 0 && tableView == tblSubCategories {
            return self.arrSubCate.count
        }else if(self.arrProducts.count > 0 && tableView == tbtProductList){
            return self.arrProducts.count
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == tblSubCategories {
            return "Sub Category"
        }else {
            return "Product List"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:CategoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell") as! CategoryTableViewCell
        if tableView == tblSubCategories {
            if self.arrSubCate.count > 0{
                cell.setCategoryData(category: self.arrSubCate[indexPath.row] as! Category)
            }else {
                cell.lblCategoryDisplay.text = "No sub-category to display"
                cell.selectionStyle = .none
            }
        }
        else {
            if self.arrProducts.count > 0{
                cell.setProductData(categoryProd: self.arrProducts[indexPath.row] as! CategoryProduct)
            }else {
                cell.lblCategoryDisplay.text = "No product to display"
                cell.selectionStyle = .none
            }
        }
        
        return cell as UITableViewCell;
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if tableView == tblSubCategories {
            if self.arrSubCate.count > 0 {
                let category:Category = self.arrSubCate[indexPath.row] as! Category
                let cateListVc = storyBoard.instantiateViewController(withIdentifier: "CategoryListingViewController") as! CategoryListingViewController
                cateListVc.mainCateId = category.id
                self.navigationController?.pushViewController(cateListVc, animated:true)
            }
        }else {
            if self.arrProducts.count > 0 {
                let product:CategoryProduct = self.arrProducts[indexPath.row] as! CategoryProduct
                let cateListVc = storyBoard.instantiateViewController(withIdentifier: "ProductViewController") as! ProductViewController
                cateListVc.productId = product.id
                self.navigationController?.pushViewController(cateListVc, animated:true)
            }
        }
        
    }
}
