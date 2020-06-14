//
//  DBManager.swift
//  HeadyTst
//
//  Created by Rohan Deshmukh on 12/06/20.
//  Copyright © 2020 RohanDeshmukh. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class DBManager: NSObject {

    static let sharedInstance = DBManager()
    var allCategories:Results<Category>? = nil
    
    private override init() {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    func saveParseResultFromApi(results:ResultBaseParser) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(results.categories!, update: Realm.UpdatePolicy.all)
            realm.add(results.rankings!, update: Realm.UpdatePolicy.all)
        }
    }
    
    func getAllCategories() -> Array<Any> {
        let realm = try! Realm()
        self.allCategories = realm.objects(Category.self).sorted(byKeyPath: "id", ascending: true)
        return Array(self.allCategories!)
    }
    
    func getSubCategoriesForCategory(categoryId: Int) -> Array<Any>{
        let realm = try! Realm()
        let subCate = realm.object(ofType: Category.self, forPrimaryKey: categoryId)?.childCategories
        var subCateArr:Results<Category>? = nil
        if let subCateData = subCate {
            subCateArr = self.allCategories?.filter("id IN %@", subCateData)
        }
        return Array(subCateArr!)
    }
    
    func getProductsForCategory(categoryId: Int) -> Array<Any>{
        let realm = try! Realm()
        let subCate = realm.object(ofType: Category.self, forPrimaryKey: categoryId)?.products
        return Array(subCate!)
    }
    
    func getSpecificProductDetails (productId: Int) -> Array<Any> {
        let realm = try! Realm()
        // IT should be sort by date added for ecom app
        let prodDetails = realm.objects(CategoryProduct.self).sorted(byKeyPath: "id", ascending: true)
        return Array(prodDetails)
    }
    
    
}
