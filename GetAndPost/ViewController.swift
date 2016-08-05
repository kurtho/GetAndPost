//
//  ViewController.swift
//  GetAndPost
//
//  Created by KurtHo on 2016/8/5.
//  Copyright © 2016年 Kurt. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    @IBAction func get(sender: AnyObject) {
        let urlString: String = "https://httpbin.org/get"
        Alamofire.request(.GET, urlString).responseJSON {
            response in
            if let data = response.result.value {
                let json = JSON(data)
                let target = json["origin"].stringValue
                print(target)
            }
        }
    }

    @IBAction func post(sender: AnyObject) {
        
        let myUrl = NSURL(string: "https://httpbin.org/post")
        
        let request = NSMutableURLRequest(URL:myUrl!)
        
        request.HTTPMethod = "POST";// Compose a query string
        
        let postString = "{“time”: “2016-07-15 12:00:00”}"
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil
            {
                print("error=\(error)")
                return
            }
            
            // You can print out response object
            print("response = \(response)")
            
            // Print out response body
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                        print("responseString = \(responseString)")
            
            //Let's convert response sent from a server side script to a NSDictionary object:
            do {
                let myJSON =  try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
                
                if let parseJSON = myJSON {
                    
                    // Now we can access value of First Name by its key
                    let Value = parseJSON["firstName"] as? String
                    print("Value: \(Value)")
                }
            } catch {
                print(error)
            }
        }
        task.resume()
        
//    source from http://swiftdeveloperblog.com/send-http-post-request-example-using-swift-and-php/
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

