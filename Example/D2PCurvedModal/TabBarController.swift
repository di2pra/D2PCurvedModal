//
//  TabBarController.swift
//  D2PCurvedModal_Example
//
//  Created by Pradheep Rajendirane on 18/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tabBar.tintColor = UIColor(red:0.99, green:0.28, blue:0.25, alpha:1.0) // #FD4741
        self.tabBar.barTintColor = .white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
