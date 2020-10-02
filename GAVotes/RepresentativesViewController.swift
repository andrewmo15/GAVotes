//
//  AddressViewController.swift
//  GAVotes
//
//  Created by Andrew Mo on 10/1/20.
//

import UIKit

class RepresentativesViewController: UIViewController {
    
    private var representatives = [Officials]()
    @IBOutlet weak var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = formatURL()
        getData(from: url)
        table.delegate = self
        table.dataSource = self
        view.backgroundColor = .white
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
                print("Something went wrong")
                return
            }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                    return
                }
                let array = (json["offices"] as? [[String: Any]])!
                for dict in array {
                    let title = dict["name"] as! String
                    for indices in dict["officialIndices"] as! [Int] {
                        strongSelf.representatives.append(Officials(json: json, index: indices, title: title))
                    }
                }
                DispatchQueue.main.async {
                    strongSelf.table.reloadData()
                }
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
        }).resume()
    }

}

extension RepresentativesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return representatives.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "represent", for: indexPath)
        cell.textLabel?.text = representatives[indexPath.row].name
        cell.detailTextLabel?.text = representatives[indexPath.row].title
        return cell
    }
}

struct Officials {
    
    let name: String
    let title: String
    let party: String
    let photoURL: String?
    let phone: [String]
    let index: Int
    let address: [[String: String]]?
    let channels: [[String: String]]?
    
    init (json: [String: Any], index: Int, title: String) {
        self.index = index
        self.title = title
        self.name = (((json["officials"] as? [Any])![index] as? [String: Any])!["name"] as? String)!
        self.party = (((json["officials"] as? [Any])![index] as? [String: Any])!["party"] as? String)!
        self.photoURL = (((json["officials"] as? [Any])![index] as? [String: Any])!["photoUrl"] as? String)
        self.phone = (((json["officials"] as? [Any])![index] as? [String: Any])!["phones"] as? [String])!
        self.address = (((json["officials"] as? [Any])![index] as? [String: Any])!["address"] as? [[String: String]])
        self.channels = (((json["officials"] as? [Any])![index] as? [String: Any])!["channels"] as? [[String: String]])
    }
}
