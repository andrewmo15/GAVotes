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
        pollingLocation.font = .systemFont(ofSize: 15)
        pollingLocation.textColor = .black
        pollingLocation.numberOfLines = 50
        return pollingLocation
    }()
    
    private let earlyVoting: UILabel = {
        let earlyVoting = UILabel()
        earlyVoting.font = .systemFont(ofSize: 15)
        earlyVoting.textColor = .black
        earlyVoting.numberOfLines = 50
        return earlyVoting
    }()
    
    private let absentee: UILabel = {
        let absentee = UILabel()
        absentee.font = .systemFont(ofSize: 15)
        absentee.textColor = .black
        absentee.numberOfLines = 50
        return absentee
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = currentElection!.name
        date.text = currentElection!.date
        configurePollingLocations()
        view.addSubview(name)
        view.addSubview(date)
        view.addSubview(pollingLocation)
        view.addSubview(earlyVoting)
        view.addSubview(absentee)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        name.frame = CGRect(x: 30, y: 100, width: view.frame.width - 60, height: 60)
        date.frame = CGRect(x: 30, y: 140, width: view.frame.width - 60, height: 60)
        pollingLocation.frame = CGRect(x: 30, y: 180, width: view.frame.width - 60, height: 150)
        earlyVoting.frame = CGRect(x: 30, y: 330, width: view.frame.width - 60, height: 150)
        absentee.frame = CGRect(x: 30, y: 480, width: view.frame.width - 60, height: 400)
    }
    
    private func configurePollingLocations() {
        for num in 0 ..< currentElection!.earlyLocations.count {
            if num == 0 {
                earlyVoting.text = "Early Voting Locations:\n"
                earlyVoting.text! += "  At: \(currentElection!.earlyLocations[num].name)\n  Address: \(currentElection!.earlyLocations[num].address)\n  Start time: \(currentElection!.earlyLocations[num].start)\n  End time: \(currentElection!.earlyLocations[num].end)\n\n"
            } else {
                earlyVoting.text! += "  At: \(currentElection!.earlyLocations[num].name)\n  Address: \(currentElection!.earlyLocations[num].address)\n  Start time: \(currentElection!.earlyLocations[num].start)\n  End time: \(currentElection!.earlyLocations[num].end)\n\n"
            }
        }
        for num in 0 ..< currentElection!.pollingLocations.count {
            if num == 0 {
                pollingLocation.text = "Polling Locations:\n"
                pollingLocation.text! += "  At: \(currentElection!.pollingLocations[num].name)\n  Address: \(currentElection!.pollingLocations[num].address)\n  Start time: \(currentElection!.pollingLocations[num].start)\n  End time: \(currentElection!.pollingLocations[num].end)\n\n"
            } else {
                pollingLocation.text! += "  At: \(currentElection!.pollingLocations[num].name)\n  Address: \(currentElection!.pollingLocations[num].address)\n  Start time: \(currentElection!.pollingLocations[num].start)\n  End time: \(currentElection!.pollingLocations[num].end)\n\n"
            }
        }
        for num in 0 ..< currentElection!.absentee.count {
            if num == 0 {
                absentee.text = "Drop Off Locations:\n"
                absentee.text! += "  At: \(currentElection!.absentee[num].name)\n  Address: \(currentElection!.absentee[num].address)\n  Start time: \(currentElection!.absentee[num].start)\n  End time: \(currentElection!.absentee[num].end)\n\n"
            } else {
                absentee.text! += "  At: \(currentElection!.absentee[num].name)\n  Address: \(currentElection!.absentee[num].address)\n  Start time: \(currentElection!.absentee[num].start)\n  End time: \(currentElection!.absentee[num].end)\n\n"
            }
        }
    }
}
