//
//  ViewController.swift
//  HeadyTst
//
//  Created by Rohan Deshmukh on 10/06/20.
//  Copyright © 2020 RohanDeshmukh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let callApi = ApiHelper()
//        callApi.fetchResultData { (response) in
//
//        }
        ApiHelper.sharedApiHelper.fetchResultData { (response) in
            
        }
        
    
    }


}

