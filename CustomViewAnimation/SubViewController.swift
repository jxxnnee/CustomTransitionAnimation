//
//  SubViewController.swift
//  CustomViewAnimation
//
//  Created by OODDY MAC on 2020/07/14.
//  Copyright © 2020 MIN KYUNG JUN. All rights reserved.
//

import UIKit

class SubViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var imageStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.imageView.image = UIImage(named: imageStr)
        self.imageView.isUserInteractionEnabled = true
        self.imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapGesture)))
    }
    
    
    @objc func tapGesture() {
        dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
