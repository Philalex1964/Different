//
//  ViewController.swift
//  NotificationCenter
//
//  Created by Aleksandar Filipov on 4/19/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button: UIButton!
    @IBOutlet var label: UILabel!
    @IBOutlet var imageview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(facebook(notification:)), name: .facebook, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(twitter(notification:)), name: .twitter, object: nil)
    }
    
    @objc func facebook(notification: Notification) {
        label.text = "Facebook"
        
        imageview.image = UIImage(systemName: "face.smiling")
    }

    @objc func twitter(notification: Notification) {
        label.text = "Twitter"
        
        imageview.image = UIImage(systemName: "face.smiling.fill")
    }
    
    @IBAction func secondView(_ sender: Any) {
     
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") else { return }
        
        navigationController?.present(vc, animated: true)
        }
}

extension Notification.Name{
    
    static let facebook = Notification.Name("Facebook")
    
    static let twitter = Notification.Name("Twitter")
}

