//
//  AboutVC.swift
//  Wylsacom News Reader
//
//  Created by Ulad Daratsiuk-Demchuk on 2018-01-15.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit
import MessageUI

class AboutVC: UIViewController, MFMailComposeViewControllerDelegate {
    
    
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    
    
    
    @IBAction func eamilBut(_ sender: Any) {
        
        
    }
    
    @IBAction func facebookBut(_ sender: Any) {
        
        
    }
    
    @IBAction func twitterBut(_ sender: Any) {
        
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
