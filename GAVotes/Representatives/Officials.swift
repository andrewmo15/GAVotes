//
//  Officials.swift
//  GAVotes
//
//  Created by Andrew Mo on 10/4/20.
//

import Foundation

class Officials {
    
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
