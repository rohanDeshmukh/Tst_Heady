//
//  ApiHelper.swift
//  HeadyTst
//
//  Created by Rohan Deshmukh on 12/06/20.
//  Copyright © 2020 RohanDeshmukh. All rights reserved.
//

import UIKit
import Alamofire
import Realm
import RealmSwift

class ApiHelper: NSObject {
    
    static let sharedApiHelper = ApiHelper()
    
    private override init(){}

    func fetchResultData(callback: @escaping (Bool) -> Void){
    Alamofire.request("https://stark-spire-93433.herokuapp.com/json").responseData(completionHandler: {response in
        
            print(Realm.Configuration.defaultConfiguration.fileURL!)

            if let results:ResultBaseParser = JSONDecoder().decodeResponse(from: response){
                let realm = try! Realm()
                try! realm.write {
                    realm.add(results.categories!, update: Realm.UpdatePolicy.all)
                    realm.add(results.rankings!, update: Realm.UpdatePolicy.all)
                }
            }
        })
    }
}

extension JSONDecoder {
    func decodeResponse<T: Decodable>(from response: DataResponse<Data>) -> T? {
        guard response.error == nil, let responseData = response.data else {
           return nil
        }
        do {
            let item = try decode(T.self, from: responseData)
            return item
        } catch {
            print(error)
            return nil
        }
    }
}
