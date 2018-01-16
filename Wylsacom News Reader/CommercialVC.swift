//
//  CommercialVC.swift
//  Wylsacom News Reader
//
//  Created by Ulad Daratsiuk-Demchuk on 2018-01-16.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit
import MessageUI

class CommercialVC: UIViewController, MFMailComposeViewControllerDelegate  {
    
    @IBOutlet weak var mediaTextLbl: UILabel!
    @IBOutlet weak var priceTextLbl: UILabel!
    @IBOutlet weak var commercialEmailLbl: UILabel!
    @IBOutlet weak var mediaButOut: UIButton!
    @IBOutlet weak var priceButOut: UIButton!
    @IBOutlet weak var emailButOut: UIButton!
    
    
    
    @IBAction func mediakitLinkBut(_ sender: Any) {
        openButtonUrl(urlStr: "http://bit.ly/2ikwuUP")
        
    }
    
    @IBAction func priceLinkBut(_ sender: Any) {
        
        openButtonUrl(urlStr: "http://bit.ly/2xmVap6")
    }
    
    
    @IBAction func emailButton(_ sender: Any) {
        
        let mailComposeViewController = configureMailController()
        if MFMailComposeViewController.canSendMail(){
            self.present(mailComposeViewController, animated: true, completion: nil)
        }else{
            showMailError()}
    }
    
    
    //CONFIGURE EMAIL
    func configureMailController()-> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["adwylsa@gmail.com"])
        mailComposerVC.setSubject("Коммерческий запрос ")
        mailComposerVC.setMessageBody("Добрый день, Wylsacom Media", isHTML: false)
        
        return mailComposerVC
    }
    
    func showMailError(){
        
        let sendMailErrorAlert = UIAlertController (title: "Не могу выслать email", message: "Ваше устройство не может выслать email", preferredStyle: .alert)
        let dismiss = UIAlertAction(title:"OK",style: .default, handler: nil)
        sendMailErrorAlert.addAction(dismiss)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
        
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil )
    }
    
    
    
    
    
    func openButtonUrl(urlStr:String!) {
        if let url = NSURL(string:urlStr) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mediaTextLbl.alpha = 0
        self.mediaButOut.alpha = 0
        self.priceTextLbl.alpha = 0
        self.priceButOut.alpha = 0
        self.commercialEmailLbl.alpha = 0
        self.emailButOut.alpha = 0
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.mediaTextLbl.alpha = 1
        }, completion: {(true) in
            UIView.animate(withDuration: 0.3, animations: {
                self.mediaButOut.alpha = 1
            }, completion: {(true) in
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.priceTextLbl.alpha = 1
                }
                    , completion: {(true) in
                        UIView.animate(withDuration: 0.3, animations: {
                            self.priceButOut.alpha = 1
                        }, completion: {(true) in
                        UIView.animate(withDuration: 0.3, animations: {
                            self.commercialEmailLbl.alpha = 1
                        }, completion: {(true   ) in
                            UIView.animate(withDuration: 0.3, animations: {
                                self.emailButOut.alpha = 1
                            }, completion: {(true) in} )
                        })
                        })
                })
            })
        })
        
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
