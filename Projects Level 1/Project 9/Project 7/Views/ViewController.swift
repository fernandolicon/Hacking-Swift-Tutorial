//
//  ViewController.swift
//  Project 7
//
//  Created by Fernando Mata on 4/10/19.
//  Copyright © 2019 Fernando Mata. All rights reserved.
//

import UIKit

fileprivate let kCellIdentifier = "Cell"
class ViewController: UITableViewController {
    
    @IBOutlet weak var barButton: UIBarButtonItem!
    
    private var petitions = [Petition]()
    private var filteredPetitions = [Petition]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        performSelector(inBackground: #selector(getJSONData), with: nil)
        
        barButton.title = navigationController?.tabBarItem.tag == 0 ? "Filter" : "Credits"
    }
    
    @objc private func getJSONData() {
        let urlString: String
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
            //            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
            //            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    parse(json: data)
                    return
                }
            }
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
    private func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            DispatchQueue.main.async { [weak self] in
                self?.petitions = jsonPetitions.results
                self?.filteredPetitions = jsonPetitions.results
            }
        }
    }
    
    @objc private func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @IBAction func didClickButton(_ sender: Any) {
        navigationController?.tabBarItem.tag == 0 ? filterData() : showCredits()
    }
    
    private func filterData() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addTextField { (textField) in
            textField.placeholder = "Enter keyword"
        }
        
        let submitAction = UIAlertAction(title: "Filter", style: UIAlertAction.Style.default) { (_) in
            self.searchKeyword(ac.textFields?[0].text)
        }
        ac.addAction(submitAction)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    private func searchKeyword(_ string: String?) {
        guard let string = string, string != "" else {
            filteredPetitions = petitions
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            guard let `self` = self else { return }
            let newFilteredPetitions = self.petitions.filter({ $0.title.contains(string) || $0.body.contains(string) })
            DispatchQueue.main.async { [weak self] in
                self?.filteredPetitions = newFilteredPetitions
            }
        }
        
    }
    
    private func showCredits() {
        let ac = UIAlertController(title: "Credits", message: "This data comes from the We The People API of the Whitehouse.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    //MARK: - Table view methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier, for: indexPath)
        let petition = filteredPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = DetailViewController()
        vc.detailItem = filteredPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)    
    }
}

