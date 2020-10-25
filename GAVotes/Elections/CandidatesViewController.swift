//
//  CandidatesViewController.swift
//  GAVotes
//
//  Created by Andrew Mo on 10/24/20.
//

import UIKit

class CandidatesViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    var candidates: Candidates?
    
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
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Louis George Cafe Bold", size: 35)!, NSAttributedString.Key.foregroundColor: UIColor.white]
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
}

extension CandidatesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return candidates?.candidates[section]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "candidate", for: indexPath)
        cell.selectionStyle = .none
        cell.backgroundColor = .white
        cell.textLabel?.text = formatName(name: (candidates?.candidates[indexPath.section]![indexPath.row].name)!)
        cell.textLabel?.font = UIFont(name: "Louis George Cafe Bold", size: 22)!
        cell.textLabel?.textColor = .black
        cell.detailTextLabel?.text = formatName(name: (candidates?.candidates[indexPath.section]![indexPath.row].party)!)
        cell.detailTextLabel?.font = UIFont(name: "Louis George Cafe Bold", size: 17)!
        cell.detailTextLabel?.textColor = .black
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return candidates!.candidates.capacity
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return candidates?.offices[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Louis George Cafe Bold", size: 15)!
        header.textLabel?.textColor = .systemPink
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
