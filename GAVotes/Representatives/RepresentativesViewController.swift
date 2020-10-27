//
//  AddressViewController.swift
//  GAVotes
//
//  Created by Andrew Mo on 10/1/20.
//

import UIKit

class RepresentativesViewController: UIViewController, UISearchBarDelegate {
    
    public var data = [Officials]()
    private var dataFiltered = [Officials]()
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var search: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        dataFiltered = data
        configureNavBar()
        configureSearch()
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
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    private func configureSearch() {
        search.barTintColor = .white
        search.tintColor = .link
        search.searchTextField.textColor = .black
        search.searchTextField.font = UIFont(name: "LouisGeorgeCafe-Bold", size: 17)!
        search.placeholder = "Search for a representative"
        search.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dataFiltered.removeAll()
        if searchText == "" {
            dataFiltered = data
        }
        for person in data {
            if person.name.lowercased().contains(searchText.lowercased()) {
                dataFiltered.append(person)
            }
        }
        table.reloadData()
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataFiltered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "represent", for: indexPath)
        cell.backgroundColor = .white
        cell.textLabel?.text = dataFiltered[indexPath.row].name
        cell.textLabel?.font = UIFont(name: "LouisGeorgeCafe-Bold", size: 20)!
        cell.textLabel?.textColor = .black
        cell.detailTextLabel?.font = UIFont(name: "LouisGeorgeCafe", size: 15)!
        cell.detailTextLabel?.text = dataFiltered[indexPath.row].title
        cell.detailTextLabel?.textColor = .black
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = dataFiltered[indexPath.row]
        performSegue(withIdentifier: "show", sender: person)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
