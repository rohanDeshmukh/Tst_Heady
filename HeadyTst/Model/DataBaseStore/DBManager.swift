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
    
    private var realm:Realm
    
    static let sharedInstance = DBManager()
        
    private override init() {
        
        realm = try! Realm()
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
   func objects<T: Object>(_ type: T.Type, predicate: NSPredicate? = nil) -> Results<T>? {
        if !isRealmAccessible() { return nil }

        realm.refresh()

        return predicate == nil ? realm.objects(type) : realm.objects(type).filter(predicate!)
    }

    func object<T: Object>(_ type: T.Type, key: String) -> T? {
        if !isRealmAccessible() { return nil }

        realm.refresh()

        return realm.object(ofType: type, forPrimaryKey: key)
    }

    func add<T: Object>(_ data: [T], update: Bool = true) {
        if !isRealmAccessible() { return }

        realm.refresh()

        if realm.isInWriteTransaction {
            realm.add(data, update: .modified)
        } else {
            try? realm.write {
                realm.add(data, update: .all)
            }
        }
    }

    func add<T: Object>(_ data: T, update: Bool = true) {
        add([data], update: update)
    }

    func runTransaction(action: () -> Void) {
        if !isRealmAccessible() { return }

        realm.refresh()

        try? realm.write {
            action()
        }
    }

    func delete<T: Object>(_ data: [T]) {
        realm.refresh()
        try? realm.write { realm.delete(data) }
    }

    func delete<T: Object>(_ data: T) {
        delete([data])
    }

    func clearAllData() {
        if !isRealmAccessible() { return }

        realm.refresh()
        try? realm.write { realm.deleteAll() }
    }
}

extension DBManager {
    func isRealmAccessible() -> Bool {
        do { _ = try Realm() } catch {
            print("Realm is not accessible")
            return false
        }
        return true
    }

    func configureRealm() {
        let config = RLMRealmConfiguration.default()
        config.deleteRealmIfMigrationNeeded = true
        RLMRealmConfiguration.setDefault(config)
    }
}
