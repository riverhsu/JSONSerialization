//
//  ViewController.swift
//  NSURL
//
//  Created by Sgmedical on 2016/12/5.
//  Copyright © 2016年 Sgmedical. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let todoEndpoint: String = "https://jsonplaceholder.typicode.com/todos/1"
        guard let url = URL(string: todoEndpoint) else {
            print("Error: can't create URL")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        // ----- you could set up session with configuration or with shared session
        // 1. build up session with default configuration
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // 2. build up shared session
        //let session = URLSession.shared
        
        //make the request
        let task  = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            
            // check for any errors
            guard error == nil else {
                print("error calling GET on url")
                print(error!)
                return
            }
            
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            // parse the result as JSON, since that's what the API provides
            do {
                guard let todo = try JSONSerialization.jsonObject(with: responseData, options:[]) as? [String: AnyObject] else {
                    print("error trying to convert data to JSON")
                    return
                }
                
                //now we have the todo, let's just print it to prove we can access it
                print("The todo is " + todo.description)
                
                //the todo object is a dictionary
                //so we just access the title using the "title" key
                //so check for a title and print it if we have one
                
                guard let todoTitle = todo["title"] as? String else{
                    print("Could not get todo title from JSON")
                    return
                }
                
                print("The title is " + todoTitle)
            } catch {
                print("Error trying to convert data to JSON")
                return
            }
        })
        task.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

