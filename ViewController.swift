//
//  ViewController.swift
//  Sunny
//
//  Created by ben on 28/11/2014.
//  Copyright (c) 2014 Ben Chamla. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var CityTextField: UITextField!
    
    
    
    @IBAction func WeatherButton(sender: AnyObject) {
        
        self.view.endEditing(true)
        
        var urlString = "http://www.weather-forecast.com/locations/" + CityTextField.text.stringByReplacingOccurrencesOfString(" ", withString: "") + "/forecasts/latest"
        
        
        var url = NSURL(string: urlString)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!){(data, responce, error) in
            
            var urlContent = NSString(data: data, encoding: NSUTF8StringEncoding)
            
            let FixedURLContent: String = urlContent as String
            
            if (urlContent!.containsString("<span class=\"phrase\">")){
            
            
            var contentArray = FixedURLContent.componentsSeparatedByString("<span class=\"phrase\">")
            
            var newContentArray = contentArray[1].componentsSeparatedByString("</span>")
            
            var  weatherForcast = newContentArray[0].stringByReplacingOccurrencesOfString("&deg;C", withString: "°") as String
                dispatch_async(dispatch_get_main_queue()){
                
            self.MessageLabel.text = weatherForcast
                }
            
            }else {
            
                dispatch_async(dispatch_get_main_queue()){
            self.MessageLabel.text = "Couldn't find this city - please try again"
                }
            }
 
        }
        
        task.resume()
        
    }
    
    
    @IBOutlet weak var MessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}

