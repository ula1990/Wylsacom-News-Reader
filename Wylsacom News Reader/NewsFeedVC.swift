//
//  NewsFeedVC.swift
//  Wylsacom News Reader
//
//  Created by Ulad Daratsiuk-Demchuk on 2018-01-15.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit
import WebKit
import MessageUI

class NewsFeedVC: UIViewController, MFMailComposeViewControllerDelegate, WKNavigationDelegate {
    
    
    
    var url = URL(string: "https://wylsa.com/category/news/")
    var menuShowing = false
    var labelShowing = false
    var actualUrl : String!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var leadingConstForMenu: NSLayoutConstraint!
    @IBOutlet weak var poopButtonOut: UIButton!
    @IBOutlet weak var noInetLbl: UILabel!
    @IBOutlet weak var shareButton: RoundButton!
    @IBOutlet weak var loadingDataLbl: UILabel!
    
    @IBOutlet weak var loadinConst: NSLayoutConstraint!
    
    
    
    
    
    
    @IBAction func menuButton(_ sender: Any) {
        if (menuShowing){
            leadingConstForMenu.constant = -160
            animationForMenu()
            shareButton.isHidden = false
        }else{
             leadingConstForMenu.constant = 0
            animationForMenu()
            shareButton.isHidden = true
        }
        
       menuShowing = !menuShowing
        
    }
    
    @IBAction func shareButton(_ sender: Any) {
        
        shareActualUrl()
     
        
    }
    
    
    func shareActualUrl(){
        actualUrl =   webView.url?.absoluteString
        let activityVC = UIActivityViewController(activityItems: ["Здесь интересная новость " +  actualUrl ], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
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
        mailComposerVC.setToRecipients(["uladzislau.daratsiuk@gmail.com"])
        mailComposerVC.setSubject("Hi Developer ")
        mailComposerVC.setMessageBody("Hi Developer,", isHTML: false)
        
        return mailComposerVC
    }
    
    func showMailError(){
        
        let sendMailErrorAlert = UIAlertController (title: "Could not send email", message: "Your device could not send email", preferredStyle: .alert)
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
    
    @IBAction func newsButton(_ sender: Any) {

        checkInetConnection()
        goToUrl(link: "https://wylsa.com/category/news" , title: "Новости")
    }
    
    
    @IBAction func articleButton(_ sender: Any) {
        
         checkInetConnection()
        goToUrl(link: "https://wylsa.com/category/articles/", title: "Статьи")
        
    }
    
    
    @IBAction func reviewArtButton(_ sender: Any) {
         checkInetConnection()
        goToUrl(link: "https://wylsa.com/category/reviews/", title: "Обзоры")
        
    }
    
    @IBAction func videosButton(_ sender: Any) {
         checkInetConnection()
        goToUrl(link: "https://wylsa.com/category/video/", title: "Видео")
    }
    
    
    @IBAction func cesButton(_ sender: Any) {
         checkInetConnection()
        goToUrl(link: "https://wylsa.com/tag/wylsaces2018/", title: "CES 2018")
    }
    
    @IBAction func learnMacButtton(_ sender: Any) {
         checkInetConnection()
        goToUrl(link: "https://wylsa.com/tag/%D1%83%D1%87%D0%B8%D0%BC-macos/", title: "Учимся macOS")
    }
    
    
    @IBAction func iphoneButton(_ sender: Any) {
         checkInetConnection()
        goToUrl(link: "https://wylsa.com/tag/iphone-x/", title: "Iphone X")
        
    }
    
    @IBAction func aboutProjectButton(_ sender: Any) {
         checkInetConnection()
        goToUrl(link: "https://wylsa.com/about/", title: "О проекте")
    }
    
    @IBAction func commercialButton(_ sender: Any) {
        hideMenu()
         self.performSegue(withIdentifier: "commercial", sender: navigationController)
    }
    
    
    @IBAction func aboutButton(_ sender: Any) {
        hideMenu()
        self.performSegue(withIdentifier: "about", sender: navigationController)
    }
    
    
    
    
    func goToUrl(link: String , title: String){
        url = URL(string: link)
        webView.load(URLRequest(url: url!))
        leadingConstForMenu.constant = -160
        animationForMenu()
        shareButton.isHidden = false
        self.navigationController?.navigationBar.alpha = 0.9
        UIView.animate(withDuration: 0.4, animations: {
            self.navigationController?.navigationBar.topItem?.title = title
            self.navigationController?.navigationBar.alpha = 1
        })
        
    }
    
    
    @IBAction func refreshInetConnection(_ sender: Any) {
        
        refreshInet()
        
    }
    
    
    
    //FUNCTION TO REFRESH INTERNET CONNECTION
    
    func refreshInet(){
        
        if currentReachabilityStatus == .notReachable{
            poopButtonOut.isHidden = false
            noInetLbl.isHidden = false
            shareButton.isHidden = true
        }else{
            poopButtonOut.isHidden = true
            noInetLbl.isHidden = true
            webView.load(URLRequest(url: url!))
            shareButton.isHidden = false
        }
        
    }
    
    
    
    
    //CHECKING INTERNET CONNECTION
    
    func checkInetConnection(){
        if  currentReachabilityStatus == .notReachable {
            poopButtonOut.isHidden = false
            noInetLbl.isHidden = false
            shareButton.isHidden = true
        }else{
            loadingData()
        }
    }
    
    
    //ADDITIONAL ANIMATION
    
    func animationForMenu(){
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    
    
    //HIDE MENU
    func hideMenu(){
        
        if (menuShowing){
            leadingConstForMenu.constant = -160
            animationForMenu()
            shareButton.isHidden = false
        }else{
            leadingConstForMenu.constant = 0
            animationForMenu()
            shareButton.isHidden = true
        }
        
        menuShowing = !menuShowing
        
    }
    
   func loadingData(){
    loadingDataLbl.isHidden = false
    UIApplication.shared.beginIgnoringInteractionEvents()
    Timer.scheduledTimer(withTimeInterval: 5, repeats: false){(timer) in
        UIApplication.shared.endIgnoringInteractionEvents()
       self.loadingDataLbl.isHidden = true
    }
    
        }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        webView.load(URLRequest(url: url!))
      
        //CONFIGURE SHADOWS FOR MENU
        menuView.layer.shadowOpacity = 1
        menuView.layer.shadowRadius = 6
        
        //CHECK INTERNET INTERNET CONNECTION
        poopButtonOut.isHidden = true
        noInetLbl.isHidden = true
        loadingDataLbl.isHidden = true
        checkInetConnection()
        
        
        
        //SHADOW OF NAVIGATION BAR
        navigationController?.navigationBar.shadowImage = UIImage()

       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    


}
