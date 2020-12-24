//
//  AvailableElectionViewController.swift
//  GAVotes
//
//  Created by Andrew Mo on 10/24/20.
//

import UIKit

class AvailableElectionViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    var available = [Election]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        getData(from: "https://civicinfo.googleapis.com/civicinfo/v2/elections?key=AIzaSyBK0gua620ptoniUbZc3ypO-WWR-BpkdQQ")
        configureNavBar()
    }
    
    private func configureNavBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor(red: 14.0 / 255.0, green: 26.0 / 255.0, blue: 82.0 / 255.0, alpha: 1)
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "LouisGeorgeCafe-Bold", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "LouisGeorgeCafe-Bold", size: 40)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "location"), style: .done, target: self, action: #selector(editAddress))
        self.title = "Upcoming Elections"
    }
    
    @objc private func editAddress() {
        let vc = EditAddressViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    private func getData(from url: String) {
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { [weak self] data, response, error in
            
            guard let strongSelf = self else {
                return
            }
            
            guard let data = data, error == nil else {
                let alert = UIAlertController(title: "Error", message: "Something went wrong", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                strongSelf.present(alert, animated: true, completion: nil)
                return
            }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                    return
                }
                let elections = json["elections"] as! [[String: String]]
                for elect in elections {
                    if elect["id"]! != "2000" {
                        strongSelf.available.append(Election(id: elect["id"]!, name: elect["name"]!, date: elect["electionDay"]!))
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "elect" {
            let vc = segue.destination as! ElectionsViewController
            vc.elect = sender as? Election
        }
    }

}

extension AvailableElectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return available.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "election", for: indexPath)
        cell.backgroundColor = .white
        cell.textLabel?.text = available[indexPath.row].name
        cell.textLabel?.font = UIFont(name: "LouisGeorgeCafe-Bold", size: 20)
        cell.textLabel?.textColor = .black
        cell.detailTextLabel?.text = available[indexPath.row].date
        cell.detailTextLabel?.font = UIFont(name: "LouisGeorgeCafe-Bold", size: 15)
        cell.detailTextLabel?.textColor = .black
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let election = available[indexPath.row]
        performSegue(withIdentifier: "elect", sender: election)
    }
}
