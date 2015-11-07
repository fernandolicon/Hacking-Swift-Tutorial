//
//  RootViewController.swift
//  Project4
//
//  Created by Luis Fernando Mata on 3/11/15.
//  Copyright © 2015 Luis Fernando Mata. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var tableView: UITableView!
    let websites = ["apple.com", "hackingswift.com"]
    var selectedWebsite : String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("websiteCell") as UITableViewCell!
        //We will make this so cell adjusts to title length
        cell.textLabel?.text = websites[indexPath.row]
        
        return cell
    }
    
    // MARK:  Table view delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        selectedWebsite = websites[indexPath.row]
        performSegueWithIdentifier("showWebsite", sender: self)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showWebsite"{
            let nextViewController = segue.destinationViewController as! ViewController
            nextViewController.website = selectedWebsite
        }
    }

}
