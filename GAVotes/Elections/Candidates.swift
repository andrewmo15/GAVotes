//
//  Candidates.swift
//  GAVotes
//
//  Created by Andrew Mo on 10/24/20.
//

import Foundation

struct Person {
    let name: String
    let party: String
}

class Candidates {
    
    var candidates: [Int: [Person]]
    var offices: [Int: String]
    
    init (json: [String: Any]) {
        let contests = json["contests"] as? [[String: Any]] ?? []
        self.candidates = [Int: [Person]]()
        self.offices = [Int: String]()
        var i = 0
        if contests.capacity != 0 {
            for election in contests {
                let office = election["office"] as? String ?? "Unknown"
                let tempCandidates = election["candidates"] as? [[String: String]] ?? []
                var array = [Person]()
                for person in tempCandidates {
                    array.append(Person(name: person["name"] ?? "Not available", party: person["party"] ?? "Not available"))
                }
                self.candidates[i] = array
                self.offices[i] = office
                i += 1
            }
        }
    }
}
