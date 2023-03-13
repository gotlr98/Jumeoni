//
//  FirstViewController.swift
//  Tutorial_GoogleLogin
//
//  Created by HaeSik Jang on 2023/03/13.
//

import Foundation
import UIKit



class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func backToFirstVC(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
