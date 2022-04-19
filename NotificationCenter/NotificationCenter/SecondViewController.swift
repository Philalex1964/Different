//
//  SecondViewController.swift
//  NotificationCenter
//
//  Created by Aleksandar Filipov on 4/19/22.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func facebookAction(_ sender: Any) {
     
             NotificationCenter.default.post(name: .facebook, object: nil)
     
             dismiss(animated: true)
     
        }
     
       @IBAction func twitterAction(_ sender: Any) {
     
            NotificationCenter.default.post(name: .twitter, object: nil)
     
           dismiss(animated: true)
     
        }

}
