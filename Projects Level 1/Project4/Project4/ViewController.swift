//
//  ViewController.swift
//  Project4
//
//  Created by Luis Fernando Mata on 29/10/15.
//  Copyright © 2015 Luis Fernando Mata. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    var webView : WKWebView!

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Navigationbar configuration
        let barButton = UIBarButtonItem(title: "Open", style: .Plain, target: self, action: "openTapped")
        navigationItem.rightBarButtonItem = barButton
        
        //WK Configuration
        let url = NSURL(string: "https://www.hackingwithswift.com")!
        let urlRequest = NSURLRequest(URL: url)
        webView.loadRequest(urlRequest)
        webView.allowsBackForwardNavigationGestures = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK WKNavigation Delegate methods
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        title = webView.title
    }
    
    //MARK: Action methods
    
    func openTapped(){
        let alertController = UIAlertController(title: "Open page...", message: nil, preferredStyle: .ActionSheet)
        var alertAction = UIAlertAction(title: "apple.com", style: .Default, handler: openPage)
        alertController.addAction(alertAction)
        alertAction = UIAlertAction(title: "hackingwithswift.com", style: .Default, handler: openPage)
        alertController.addAction(alertAction)
        alertAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(alertAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func openPage(action: UIAlertAction!){
        let url = NSURL(string: "https://" + action.title!)!
        let urlRequest = NSURLRequest(URL: url)
        webView.loadRequest(urlRequest)
    }

}

