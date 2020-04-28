//
//  VotesViewController.swift
//  AmazonChimeSDKDemo
//
//  Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
//  SPDX-License-Identifier: Apache-2.0
//

import Foundation
import UIKit

class VotesViewController:UIViewController {
    
    var a1:String?
    var a2:String?
    var a3:String?
    var a4:String?
    var vote1:Int?
    var vote2:Int?
    var vote3:Int?
    var vote4:Int?
    var q:String?
    
    
    @IBOutlet var answer1: UILabel!
    @IBOutlet var answer2: UILabel!
    @IBOutlet var answer3: UILabel!
    @IBOutlet var answer4: UILabel!
    
    @IBOutlet var count1: UILabel!
    @IBOutlet var count2: UILabel!
    @IBOutlet var count3: UILabel!
    @IBOutlet var count4: UILabel!
    
    @IBOutlet var question: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.answer1.text = self.a1
        self.answer2.text = self.a2
        self.answer3.text = self.a3
        self.answer4.text = self.a4
        self.question.text = "Question : \(self.q)"
        
        self.count1.frame.size.width = CGFloat(self.vote1! * 80)
        self.count2.frame.size.width = CGFloat(self.vote2! * 80)
        self.count3.frame.size.width = CGFloat(self.vote3! * 80)
        self.count4.frame.size.width = CGFloat(self.vote4! * 80)
        
        self.count1.text = "Count : \(self.vote1!)"
        self.count2.text = "Count : \(self.vote2!)"
        self.count3.text = "Count : \(self.vote3!)"
        self.count4.text = "Count : \(self.vote4!)"
        
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        DispatchQueue.main.async(execute: {
          self.dismiss(animated:true, completion: nil)
        })
    }
    
    
}
