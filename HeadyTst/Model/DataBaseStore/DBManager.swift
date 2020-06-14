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
        let allCategories = realm.objects(Category.self).sorted(byKeyPath: "id", ascending: true)
        return Array(allCategories)
    }
}
