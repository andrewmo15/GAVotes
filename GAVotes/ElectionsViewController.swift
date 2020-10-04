//
//  ElectionsViewController.swift
//  GAVotes
//
//  Created by Andrew Mo on 10/2/20.
//

import UIKit

class ElectionsViewController: UIViewController {
    
    var elections = [Elections]()
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        let url = formatURL()
        getData(from: url)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(showAddress))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        table.delegate = self
        table.dataSource = self
        let url = formatURL()
        getData(from: url)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(showAddress))
    }
    
    @objc private func showAddress() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "editAddress")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    private func formatURL() -> String {
        var url = "https://civicinfo.googleapis.com/civicinfo/v2/voterinfo?address="
        var array = UserDefaults.standard.string(forKey: "Address")?.split(separator: " ")
        for i in 0 ..< array!.count {
            if i == 0 {
                url += array![i]
            } else {
                url += "%20\(array![i])"
            }
        }
        url += "%2C"
        array = UserDefaults.standard.string(forKey: "City")?.split(separator: " ")
        for i in 0 ..< array!.count {
            url += "%20\(array![i])"
        }
        return url + "%2C%20\(UserDefaults.standard.string(forKey: "State")!)%2C%20\(UserDefaults.standard.string(forKey: "Zipcode")!)&key=AIzaSyBK0gua620ptoniUbZc3ypO-WWR-BpkdQQ"
    }
    
    private func getData(from url: String) {
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { [weak self] data, response, error in
            
            guard let strongSelf = self else {
                return
            }
            
            guard let data = data, error == nil else {
                print("Something went wrong")
                return
            }
            
            strongSelf.elections.removeAll()
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                    return
                }
                
                strongSelf.elections.append(Elections(json: json))
                
                DispatchQueue.main.async {
                    strongSelf.table.reloadData()
                }
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            
        }).resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show2" {
            let vc = segue.destination as! ElectDetailViewController
            vc.currentElection = sender as? Elections
        }
    }
}

extension ElectionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elections.capacity
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "elect", for: indexPath)
        cell.textLabel?.text = elections[indexPath.row].name
        cell.detailTextLabel?.text = elections[indexPath.row].date
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let elect = elections[indexPath.row]
        performSegue(withIdentifier: "show2", sender: elect)
    }
}

struct Elections {
    
    let name: String
    let date: String
    let pollingLocations: [Location]
    let earlyLocations: [Location]
    let absentee: [Location]
    
    init (json: [String: Any]) {
        self.name = (json["election"] as? [String: String])!["name"] ?? "Not available"
        self.date = (json["election"] as? [String: String])!["electionDay"] ?? "Not available"
        var array = json["pollingLocations"] as! [[String: Any]]
        var temp = [Location]()
        for i in 0 ..< array.count {
            let dict = array[i]["address"] as! [String: String]
            let myaddress = "\(dict["line1"]!) \(dict["city"]!) \(dict["state"]!) \(dict["zip"]!)"
            let myhours = array[i]["pollingHours"] as? String ?? "Not available"
            let startDate = array[i]["startDate"] as? String ?? "Not available"
            let endDate = array[i]["endDate"] as? String ?? "Not available"
            let myname = dict["locationName"]!
            let thing = Location(name: myname, address: myaddress, hours: myhours, start: startDate, end: endDate)
            temp.append(thing)
        }
        self.pollingLocations = temp
        
        array = json["dropOffLocations"] as! [[String: Any]]
        var temp2 = [Location]()
        for i in 0 ..< array.count {
            let dict = array[i]["address"] as! [String: String]
            let myaddress = "\(dict["line1"]!) \(dict["city"]!) \(dict["state"]!) \(dict["zip"]!)"
            let myhours = array[i]["pollingHours"] as? String ?? "Not available"
            let startDate = array[i]["startDate"] as? String ?? "Not available"
            let endDate = array[i]["endDate"] as? String ?? "Not available"
            let myname = dict["locationName"]!
            let thing = Location(name: myname, address: myaddress, hours: myhours, start: startDate, end: endDate)
            temp2.append(thing)
        }
        self.absentee = temp2
        
        array = json["earlyVoteSites"] as! [[String: Any]]
        var temp3 = [Location]()
        for i in 0 ..< array.count {
            let dict = array[i]["address"] as! [String: String]
            let myaddress = "\(dict["line1"]!) \(dict["city"]!) \(dict["state"]!) \(dict["zip"]!)"
            let myhours = array[i]["pollingHours"] as? String ?? "Not available"
            let startDate = array[i]["startDate"] as? String ?? "Not available"
            let endDate = array[i]["endDate"] as? String ?? "Not available"
            let myname = dict["locationName"]!
            let thing = Location(name: myname, address: myaddress, hours: myhours, start: startDate, end: endDate)
            temp3.append(thing)
        }
        self.earlyLocations = temp3
    }
}

struct Location {
    let name: String
    let address: String
    let hours: String
    let start: String
    let end: String
    
    init(name: String, address: String, hours: String, start: String, end: String) {
        self.name = name
        self.address = address
        self.hours = hours
        self.start = start
        self.end = end
    }
}
