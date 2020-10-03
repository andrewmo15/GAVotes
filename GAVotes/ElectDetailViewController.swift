//
//  ElectDetailViewController.swift
//  GAVotes
//
//  Created by Andrew Mo on 10/2/20.
//

import UIKit

class ElectDetailViewController: UIViewController {
    
    var currentElection: Elections?
    
    private let name: UILabel = {
        let name = UILabel()
        name.font = .systemFont(ofSize: 30)
        name.textAlignment = .center
        name.textColor = .black
        name.numberOfLines = 2
        return name
    }()
    
    private let date: UILabel = {
        let date = UILabel()
        date.font = .systemFont(ofSize: 20)
        date.textAlignment = .center
        date.textColor = .black
        date.numberOfLines = 2
        return date
    }()
    
    private let pollingLocation: UILabel = {
        let pollingLocation = UILabel()
        pollingLocation.font = .systemFont(ofSize: 20)
        pollingLocation.textAlignment = .center
        pollingLocation.textColor = .black
        pollingLocation.numberOfLines = 2
        return pollingLocation
    }()
    
    private let earlyVoting: UILabel = {
        let earlyVoting = UILabel()
        earlyVoting.font = .systemFont(ofSize: 15)
        earlyVoting.textColor = .black
        earlyVoting.numberOfLines = 2
        return earlyVoting
    }()
    
    private let absentee: UILabel = {
        let absentee = UILabel()
        absentee.font = .systemFont(ofSize: 15)
        absentee.textColor = .black
        absentee.numberOfLines = 2
        return absentee
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = currentElection!.name
        date.text = currentElection!.date
        view.addSubview(name)
        view.addSubview(date)
        view.addSubview(pollingLocation)
        view.addSubview(earlyVoting)
        view.addSubview(absentee)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        name.frame = CGRect(x: 30, y: 200, width: view.frame.width - 60, height: 60)
        date.frame = CGRect(x: 30, y: 260, width: view.frame.width - 60, height: 60)
        pollingLocation.frame = CGRect(x: 30, y: 320, width: view.frame.width - 60, height: 60)
        earlyVoting.frame = CGRect(x: 30, y: 380, width: view.frame.width - 60, height: 60)
        absentee.frame = CGRect(x: 30, y: 440, width: view.frame.width - 60, height: 60)
    }
}
