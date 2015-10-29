//
//  DetailViewController.swift
//  Project 1
//
//  Created by Luis Fernando Mata on 25/10/15.
//  Copyright © 2015 Luis Fernando Mata. All rights reserved.
//

import UIKit
import Social

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailImageView: UIImageView!
    
    
    var detailItem: String? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let imageName = detailItem{
            if let imageView = self.detailImageView {
                imageView.image = UIImage(named: imageName)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        title = detailItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: "shareTapped")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func shareTapped(){
        //Share to default media
        let viewController = UIActivityViewController(activityItems: [detailImageView.image!], applicationActivities: [])
        presentViewController(viewController, animated: true, completion: nil)
        
        /*
        //Share to Facebook
        //let vc = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        //Share to Twitter
        let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        vc.setInitialText("Look at this great picture!")
        vc.addImage(detailImageView.image!)
        vc.addURL(NSURL(string: "http://www.photolib.noaa.gov/nssl"))
        presentViewController(vc, animated: true, completion: nil)
        */
    }
    
    
}

