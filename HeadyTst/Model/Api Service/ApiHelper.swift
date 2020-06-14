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
        
        Alamofire.request(ecommApiUrl).responseData(completionHandler: {response in
//            debugPrint(response)
            if let results:ResultBaseParser = JSONDecoder().decodeResponse(from: response){          DBManager.sharedInstance.saveParseResultFromApi(results: results)
                callback(true)
            }
            else {
                print("Api: Does not consist of data.")
                callback(false)
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
