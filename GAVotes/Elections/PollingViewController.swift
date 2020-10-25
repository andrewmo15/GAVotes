//
//  PollingViewController.swift
//  GAVotes
//
//  Created by Andrew Mo on 10/24/20.
//

import UIKit

class PollingViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    var polling: [Location]?
    var early: [Location]?
    var absentee: [Location]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        configureNavBar()
    }
    
    private func configureNavBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor(red: 14.0 / 255.0, green: 26.0 / 255.0, blue: 82.0 / 255.0, alpha: 1)
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Louis George Cafe Bold", size: 25)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Louis George Cafe Bold", size: 40)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(done))
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Louis George Cafe Bold", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
    }
    
    @objc private func done() {
        dismiss(animated: true, completion: nil)
    }
    
    private func formatName(name: String) -> String {
        let array = name.split(separator: " ")
        var str = ""
        for word in array {
            str += word.prefix(1) + String(word.suffix(word.count - 1)).lowercased() + " "
        }
        return String(str.prefix(str.count - 1))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewLoc" {
            let vc = segue.destination as! LocationViewController
            vc.location = sender as? Location
        }
    }

}

extension PollingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return polling?.count ?? 0
        case 1:
            return early?.count ?? 0
        case 2:
            return absentee?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "poll", for: indexPath)
        cell.textLabel?.numberOfLines = 2
        cell.textLabel?.font = UIFont(name: "Louis George Cafe Bold", size: 20)!
        cell.detailTextLabel?.font = UIFont(name: "Louis George Cafe", size: 15)!
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = formatName(name: polling![indexPath.row].name)
            cell.detailTextLabel?.text = "\(polling![indexPath.row].start) - \(polling![indexPath.row].end)"
        case 1:
            cell.textLabel?.text = formatName(name: early![indexPath.row].name)
            cell.detailTextLabel?.text = "\(early![indexPath.row].start) - \(early![indexPath.row].end)"
        case 2:
            cell.textLabel?.text = formatName(name: absentee![indexPath.row].name)
            cell.detailTextLabel?.text = "\(absentee![indexPath.row].start) - \(absentee![indexPath.row].end)"
        default:
            break
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Polling Locations"
        case 1:
            return "Early Voting Locations"
        case 2:
            return "Drop Off Locations"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let location = polling![indexPath.row]
            performSegue(withIdentifier: "viewLoc", sender: location)
        case 1:
            let location = early![indexPath.row]
            performSegue(withIdentifier: "viewLoc", sender: location)
        case 2:
            let location = absentee![indexPath.row]
            performSegue(withIdentifier: "viewLoc", sender: location)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Louis George Cafe Bold", size: 15)!
        header.textLabel?.textColor = .systemPink
    }
}
