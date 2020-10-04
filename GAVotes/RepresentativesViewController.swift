//
//  AddressViewController.swift
//  GAVotes
//
//  Created by Andrew Mo on 10/1/20.
//

import UIKit

class RepresentativesViewController: UIViewController {
    
    private var federal = [Officials]()
    private var state = [Officials]()
    private var county = [Officials]()
    private var other = [Officials]()
    @IBOutlet weak var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = formatURL()
        getData(from: url)
        table.delegate = self
        table.dataSource = self
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(showAddress))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let url = formatURL()
        getData(from: url)
        table.delegate = self
        table.dataSource = self
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(showAddress))
    }
    
    @objc private func showAddress() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "editAddress")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    private func formatURL() -> String {
        var url = "https://civicinfo.googleapis.com/civicinfo/v2/representatives?address="
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
                let alert = UIAlertController(title: "Error", message: "Something went wrong!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                strongSelf.present(alert, animated: true, completion: nil)
                return
            }
            
            strongSelf.federal.removeAll()
            strongSelf.state.removeAll()
            strongSelf.county.removeAll()
            strongSelf.other.removeAll()
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                    return
                }
                let array = (json["offices"] as? [[String: Any]])!
                for dict in array {
                    let title = dict["name"] as? String ?? "Not available"
                    let levels = (dict["levels"] as? [String] ?? ["Not available"])[0]
                    for indices in dict["officialIndices"] as! [Int] {
                        switch (levels) {
                        case "country":
                            strongSelf.federal.append(Officials(json: json, index: indices, title: title))
                            break
                        case "administrativeArea1":
                            strongSelf.state.append(Officials(json: json, index: indices, title: title))
                            break
                        case "administrativeArea2":
                            strongSelf.county.append(Officials(json: json, index: indices, title: title))
                            break
                        default:
                            strongSelf.other.append(Officials(json: json, index: indices, title: title))
                            break
                        }
                    }
                }
                DispatchQueue.main.async {
                    strongSelf.table.reloadData()
                }
            } catch let jsonErr {
                let alert = UIAlertController(title: "Error serializing json", message: jsonErr.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                strongSelf.present(alert, animated: true, completion: nil)
            }
        }).resume()
    }
    
    func getPic(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show" {
            let vc = segue.destination as! RepDetailViewController
            vc.currentOfficial = sender as? Officials
        }
    }

}

extension RepresentativesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return federal.count
        case 1:
            return state.count
        case 2:
            return county.count
        case 3:
            return other.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "represent", for: indexPath)
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = federal[indexPath.row].name
            cell.detailTextLabel?.text = federal[indexPath.row].title
        case 1:
            cell.textLabel?.text = state[indexPath.row].name
            cell.detailTextLabel?.text = state[indexPath.row].title
        case 2:
            cell.textLabel?.text = county[indexPath.row].name
            cell.detailTextLabel?.text = county[indexPath.row].title
        case 3:
            cell.textLabel?.text = other[indexPath.row].name
            cell.detailTextLabel?.text = other[indexPath.row].title
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let person = federal[indexPath.row]
            performSegue(withIdentifier: "show", sender: person)
        case 1:
            let person = state[indexPath.row]
            performSegue(withIdentifier: "show", sender: person)
        case 2:
            let person = county[indexPath.row]
            performSegue(withIdentifier: "show", sender: person)
        case 3:
            let person = other[indexPath.row]
            performSegue(withIdentifier: "show", sender: person)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Federal"
        case 1:
            return "State"
        case 2:
            return "County"
        case 3:
            return "Other"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

struct Officials {
    
    let name: String
    let title: String
    let party: String
    let photoURL: String
    let phone: String
    let index: Int
    let address: String
    let emails: String
    let channels: [[String: String]]
    
    init (json: [String: Any], index: Int, title: String) {
        self.index = index
        self.title = title
        self.name = (((json["officials"] as? [Any])![index] as? [String: Any])!["name"] as? String) ?? "Not Available"
        self.party = (((json["officials"] as? [Any])![index] as? [String: Any])!["party"] as? String) ?? "Not Available"
        self.photoURL = (((json["officials"] as? [Any])![index] as? [String: Any])!["photoUrl"] as? String) ?? "https://www.birchgrovedental.co.uk/wp-content/uploads/2016/01/empty-person.jpg"
        self.phone = (((json["officials"] as? [Any])![index] as? [String: Any])!["phones"] as? [String])?[0] ?? "Not Available"
        let line = (((json["officials"] as? [Any])![index] as? [String: Any])!["address"] as? [[String: String]])?[0]["line1"] ?? "Current"
        let city = (((json["officials"] as? [Any])![index] as? [String: Any])!["address"] as? [[String: String]])?[0]["city"] ?? "Address"
        let state = (((json["officials"] as? [Any])![index] as? [String: Any])!["address"] as? [[String: String]])?[0]["state"] ?? "Not"
        let zip = (((json["officials"] as? [Any])![index] as? [String: Any])!["address"] as? [[String: String]])?[0]["zip"] ?? "Available"
        self.address = "\(line) \(city), \(state) \(zip)"
        self.channels = (((json["officials"] as? [Any])![index] as? [String: Any])!["channels"] as? [[String: String]]) ?? [["type": "Not Available"]]
        self.emails = (((json["officials"] as? [Any])![index] as? [String: Any])!["emails"] as? [String])?[0] ?? "Not Available"
    }
}
