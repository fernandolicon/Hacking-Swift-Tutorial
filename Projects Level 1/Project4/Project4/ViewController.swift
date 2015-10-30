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
        
        let url = NSURL(string: "https://www.hackingwithswift.com")!
        let urlRequest = NSURLRequest(URL: url)
        webView.loadRequest(urlRequest)
        webView.allowsBackForwardNavigationGestures = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

