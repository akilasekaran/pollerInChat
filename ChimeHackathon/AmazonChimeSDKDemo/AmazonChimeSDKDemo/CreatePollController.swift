//
//  CreatePoll.swift
//  AmazonChimeSDKDemo
//
//  Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
//  SPDX-License-Identifier: Apache-2.0
//

import Foundation
import AmazonChimeSDK
import AVFoundation
import Toast
import UIKit

class CreatePollController: UIViewController,UITextFieldDelegate {
    @IBOutlet var createView: UIScrollView!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var questionView: UITextView!
    @IBOutlet var option1: UITextField!
    @IBOutlet var option2: UITextField!
    @IBOutlet var option3: UITextField!
    @IBOutlet var option4: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.questionView.becomeFirstResponder()
    }
    
    func jsonToData(json: Any) -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil;
    }
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        let url = URL(string: "https://shubham99.pythonanywhere.com/create_poll")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("text/plain", forHTTPHeaderField: "Content-Type")
            
            let jsonObject: NSMutableDictionary = NSMutableDictionary()
        jsonObject.setValue(self.questionView.text, forKey:"question")
        jsonObject.setValue([self.option1.text,self.option2.text,self.option3.text,self.option4.text], forKey:"options")
            
            
            let jsonData: Data
            jsonData = self.jsonToData(json:jsonObject)!
            
            request.httpBody = jsonData

            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("error: \(error)")
                    self.dismiss(animated:true, completion: nil)
                } else {
                    if let response = response as? HTTPURLResponse {
                        print("statusCode: \(response.statusCode)")
                    }
                    if let data = data, let dataString = String(data: data, encoding: .utf8) {
                        print("data: \(dataString)")
                    }
                    DispatchQueue.main.async(execute: {
                      self.dismiss(animated:true, completion: nil)
                    })
                }
            }
            task.resume()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.option4 || textField == self.option4 {
            self.createView.contentOffset = CGPoint(x:0,y:textField.frame.origin.y - 40)
        }
        return true;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.option1 {
            self.option2.becomeFirstResponder()
        }else if textField == self.option2 {
            self.option3.becomeFirstResponder()
        }else if textField == self.option3 {
            self.option4.becomeFirstResponder()
        }else if textField == self.option4 {
            self.createView.contentOffset = CGPoint(x:0, y:0)
            textField.resignFirstResponder()
        }
        return true;
    }
    
//    // Prepare URL
//    let url = URL(string: "https://jsonplaceholder.typicode.com/todos")
//    guard let requestUrl = url else { fatalError() }
//    // Prepare URL Request Object
//    var request = URLRequest(url: requestUrl)
//    request.httpMethod = "POST"
//
//    // HTTP Request Parameters which will be sent in HTTP Request Body
//    let postString = "userId=300&title=My urgent task&completed=false";
//    // Set HTTP Request Body
//    request.httpBody = postString.data(using: String.Encoding.utf8);
//    // Perform HTTP Request
//    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//
//            // Check for Error
//            if let error = error {
//                print("Error took place \(error)")
//                return
//            }
//
//            // Convert HTTP Response Data to a String
//            if let data = data, let dataString = String(data: data, encoding: .utf8) {
//                print("Response data string:\n \(dataString)")
//            }
//    }
//    task.resume()
}
