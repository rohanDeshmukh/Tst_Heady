//
//  CategoryViewController.swift
//  HeadyTst
//
//  Created by Rohan Deshmukh on 14/06/20.
//  Copyright © 2020 RohanDeshmukh. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var arrCate:Array<Any> = []
        
    @IBOutlet weak var tblCategory: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Category"
        
        // Do any additional setup after loading the view.
        self.callEcomResultApi()
        
        self.tblCategory.register(UINib(nibName:"CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
        
    }
    
    func callEcomResultApi() {
        ApiHelper.sharedApiHelper.fetchResultData{ (response) in
                if response {
                    self.arrCate = DBManager.sharedInstance.getAllCategories()
                    self.tblCategory.reloadData()
                }else {
                    let alert = UIAlertController(title: "Ecom App", message: "Oops! it seems there is no data to display.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
            }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arrCate.count > 0 {
            return self.arrCate.count
        }else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:CategoryTableViewCell = tblCategory.dequeueReusableCell(withIdentifier: "CategoryTableViewCell") as! CategoryTableViewCell
        if self.arrCate.count > 0{
            cell.setCategoryData(category: self.arrCate[indexPath.row] as! Category)
        }else {
            cell.lblCategoryDisplay.text = "No category to display"
        }
        return cell as UITableViewCell;
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category:Category = self.arrCate[indexPath.row] as! Category
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let cateListVc = storyBoard.instantiateViewController(withIdentifier: "CategoryListingViewController") as! CategoryListingViewController
        cateListVc.mainCateId = category.id
        cateListVc.categoryName = category.name!
        self.navigationController?.pushViewController(cateListVc, animated:true)
    }
}
