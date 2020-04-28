//
//  AnswerViewController.swift
//  AmazonChimeSDKDemo
//
//  Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
//  SPDX-License-Identifier: Apache-2.0
//

import Foundation
import UIKit

class AnswerViewController: UIViewController {
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answer1: UIButton!
    @IBOutlet var answer2: UIButton!
    @IBOutlet var answer3: UIButton!
    @IBOutlet var answer4: UIButton!
    
    var a1:String!
    var a2:String!
    var a3:String!
    var a4:String!
    var q:String!
    
    var vote1:String!
    var vote2:String!
    var vote3:String!
    var vote4:String!
    
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.answer1.setTitle(self.a1, for: .normal)
        self.answer2.setTitle(self.a2, for: .normal)
        self.answer3.setTitle(self.a3, for: .normal)
        self.answer4.setTitle(self.a4, for: .normal)
        self.questionLabel.text = self.q
    }
    
    @IBAction func answer1Clicked(_ sender: UIButton) {
        self.answerClicked(answer: (self.answer1.titleLabel?.text)!)
    }
    
    @IBAction func answer2Clicked(_ sender: UIButton) {
        self.answerClicked(answer: (self.answer2.titleLabel?.text)!)
    }
    
    @IBAction func answer3Clicked(_ sender: UIButton) {
        self.answerClicked(answer: (self.answer3.titleLabel?.text)!)
    }
    
    @IBAction func answer4Clicked(_ sender: UIButton) {
        self.answerClicked(answer: (self.answer4.titleLabel?.text)!)
    }
    
    func answerClicked(answer:String) {
        let url = URL(string: "https://shubham99.pythonanywhere.com/vote")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("text/plain", forHTTPHeaderField: "Content-Type")
            
            let jsonObject: NSMutableDictionary = NSMutableDictionary()
        jsonObject.setValue(answer, forKey:"member")
            
            
            let jsonData: Data
            jsonData = self.jsonToData(json:jsonObject)!
            request.httpBody = jsonData
            var jsonData1 = Data()
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("error: \(error)")
                    self.dismiss(animated:true, completion: nil)
                } else {
                    if let response = response as? HTTPURLResponse {
                        print("statusCode: \(response.statusCode)")
                    }
                    if let jsonData = data, let dataString = String(data: jsonData, encoding: .utf8) {
                        print("data: \(dataString)")
                        jsonData1 = jsonData
                    }
            
                    DispatchQueue.main.async(execute: {
                      self.dismiss(animated:true, completion: nil)
                    })
                }
            }
            task.resume()
    }
    func jsonToData(json: Any) -> Data? {
           do {
               return try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
           } catch let myJSONError {
               print(myJSONError)
           }
           return nil;
       }
}
