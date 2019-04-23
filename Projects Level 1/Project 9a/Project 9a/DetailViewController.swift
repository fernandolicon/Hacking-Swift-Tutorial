//
//  DetailViewController.swift
//  Project 1
//
//  Created by Luis Fernando Mata on 25/10/15.
//  Copyright © 2015 Luis Fernando Mata. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailImageView: UIImageView!
    
    var detailItem: String? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        
        title = detailItem
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let imageName = detailItem{
            if let imageView = self.detailImageView {
                imageView.image = UIImage(named: imageName)
            }
        }
        
    }
    
}

