//
//  EVViewController.swift
//  GAVotes
//
//  Created by Andrew Mo on 12/22/20.
//

import UIKit

class EVViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    private let myView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let stack1: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 25
        stack.isBaselineRelativeArrangement = true
        stack.contentMode = .scaleToFill
        stack.isUserInteractionEnabled = true
        return stack
    }()
    
    private let stack2: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 25
        stack.isBaselineRelativeArrangement = true
        stack.contentMode = .scaleToFill
        stack.isUserInteractionEnabled = true
        return stack
    }()
    
    private let stack3: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 25
        stack.isBaselineRelativeArrangement = true
        stack.contentMode = .scaleToFill
        stack.isUserInteractionEnabled = true
        return stack
    }()
    
    private let evrequirements: UIButton = {
        let evrequirements = CustomButton()
        evrequirements.setTitle("Voter Registration", for: .normal)
        evrequirements.addTarget(self, action: #selector(requirements), for: .touchUpInside)
        return evrequirements
    }()
    
    private let evrequirementsBody: UITextView = {
        let evrequirements = UITextView()
        let text = "You can vote at any early voting site in your county.\nTo vote early, you must bring valid voter ID. Valid forms of ID include:\n    1. Georgia’s driver’s license, even if expired\n    2. Valid US passport\n    3. Georgia voter identification card\n    4. School ID is accepted from the following colleges, universities, and technical colleges found here.\n    5. You can find more specific information about what qualifies as Valid ID and how to obtain a Georgia voter identification card here.\nBe sure to social distance when registering to vote. CDC guidelines for voters can be found here."
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.link, value: "https://sos.ga.gov/admin/files/acceptableID_9-18.v2.pdf", range: NSRange(location: 345, length: 4))
        attributedString.addAttribute(.link, value: "https://sos.ga.gov/index.php/elections/georgia_voter_identification_requirements2", range: NSRange(location: 484, length: 4))
        attributedString.addAttribute(.link, value: "https://www.cdc.gov/coronavirus/2019-ncov/community/election-polling-locations.html#VoterRecommendations", range: NSRange(location: 582, length: 4))
        evrequirements.attributedText = attributedString
        evrequirements.font = UIFont(name: "LouisGeorgeCafe", size: 18)!
        evrequirements.textAlignment = .left
        evrequirements.textColor = .black
        evrequirements.backgroundColor = .white
        evrequirements.tintColor = .link
        evrequirements.isHidden = true
        evrequirements.isEditable = false
        return evrequirements
    }()
    
    private let evdates: UIButton = {
        let evrequirements = CustomButton()
        evrequirements.setTitle("Dates and Deadlines", for: .normal)
        evrequirements.addTarget(self, action: #selector(dates), for: .touchUpInside)
        return evrequirements
    }()
    
    private let evdatesBody: UITextView = {
        let evdates = UITextView()
        let text = "Early in-person voting begins on the fourth Monday prior to a primary or election.\nThe early voting period ends on the Friday before Election Day.\nThe calendar for when voting dates and deadlines for voter registration, including when early voting begins, can be found here."
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.link, value: "https://sos.ga.gov/index.php/elections/elections_and_voter_registration_calendars", range: NSRange(location: 269, length: 4))
        evdates.attributedText = attributedString
        evdates.font = UIFont(name: "LouisGeorgeCafe", size: 18)!
        evdates.textAlignment = .left
        evdates.textColor = .black
        evdates.backgroundColor = .white
        evdates.tintColor = .link
        evdates.isHidden = true
        evdates.isEditable = false
        return evdates
    }()
    
    private let evadditionalinfo: UIButton = {
        let evrequirements = CustomButton()
        evrequirements.setTitle("Additional Information", for: .normal)
        evrequirements.addTarget(self, action: #selector(additionalinfo), for: .touchUpInside)
        return evrequirements
    }()
    
    private let evadditionalinfoBody: UITextView = {
        let evadditionalinfo = UITextView()
        let text = "For additional information, visit georgia.gov."
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.link, value: "https://georgia.gov/early-voting", range: NSRange(location: 34, length: 11))
        evadditionalinfo.attributedText = attributedString
        evadditionalinfo.font = UIFont(name: "LouisGeorgeCafe", size: 18)!
        evadditionalinfo.textAlignment = .center
        evadditionalinfo.textColor = .black
        evadditionalinfo.backgroundColor = .white
        evadditionalinfo.tintColor = .link
        evadditionalinfo.isHidden = true
        evadditionalinfo.isEditable = false
        return evadditionalinfo
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        view.addSubview(scrollView)
        scrollView.addSubview(myView)
        myView.addSubview(stack1)
        myView.addSubview(stack2)
        myView.addSubview(stack3)
        configureStack()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width: view.frame.width, height: 760)
        myView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 760)
    }
    
    private func configureNavBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor(red: 14.0 / 255.0, green: 26.0 / 255.0, blue: 82.0 / 255.0, alpha: 1)
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "LouisGeorgeCafe-Bold", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "LouisGeorgeCafe-Bold", size: 30)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        self.title = "Early Voting"
    }
    
    private func configureStack() {
        stack1.translatesAutoresizingMaskIntoConstraints = false
        stack1.topAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        stack1.leadingAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        stack1.trailingAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        stack2.translatesAutoresizingMaskIntoConstraints = false
        stack2.topAnchor.constraint(equalTo: stack1.bottomAnchor, constant: 0).isActive = true
        stack2.leadingAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        stack2.trailingAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        stack3.translatesAutoresizingMaskIntoConstraints = false
        stack3.topAnchor.constraint(equalTo: stack2.bottomAnchor, constant: 0).isActive = true
        stack3.leadingAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        stack3.trailingAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.trailingAnchor).isActive = true
        addViews()
    }
    
    private func addViews() {
        stack1.addArrangedSubview(evrequirements)
        evrequirements.translatesAutoresizingMaskIntoConstraints = false
        evrequirements.heightAnchor.constraint(equalToConstant: 60).isActive = true
        evrequirements.trailingAnchor.constraint(equalTo: stack1.trailingAnchor).isActive = true
        evrequirements.leadingAnchor.constraint(equalTo: stack1.leadingAnchor).isActive = true
        
        stack1.addArrangedSubview(evrequirementsBody)
        evrequirementsBody.translatesAutoresizingMaskIntoConstraints = false
        evrequirementsBody.heightAnchor.constraint(equalToConstant: 340).isActive = true
        evrequirementsBody.trailingAnchor.constraint(equalTo: stack1.trailingAnchor).isActive = true
        evrequirementsBody.leadingAnchor.constraint(equalTo: stack1.leadingAnchor).isActive = true
        
        stack2.addArrangedSubview(evdates)
        evdates.translatesAutoresizingMaskIntoConstraints = false
        evdates.heightAnchor.constraint(equalToConstant: 60).isActive = true
        evdates.trailingAnchor.constraint(equalTo: stack2.trailingAnchor).isActive = true
        evdates.leadingAnchor.constraint(equalTo: stack2.leadingAnchor).isActive = true
        
        stack2.addArrangedSubview(evdatesBody)
        evdatesBody.translatesAutoresizingMaskIntoConstraints = false
        evdatesBody.heightAnchor.constraint(equalToConstant: 180).isActive = true
        evdatesBody.trailingAnchor.constraint(equalTo: stack2.trailingAnchor).isActive = true
        evdatesBody.leadingAnchor.constraint(equalTo: stack2.leadingAnchor).isActive = true
        
        stack3.addArrangedSubview(evadditionalinfo)
        evadditionalinfo.translatesAutoresizingMaskIntoConstraints = false
        evadditionalinfo.heightAnchor.constraint(equalToConstant: 60).isActive = true
        evadditionalinfo.trailingAnchor.constraint(equalTo: stack3.trailingAnchor).isActive = true
        evadditionalinfo.leadingAnchor.constraint(equalTo: stack3.leadingAnchor).isActive = true
        
        stack3.addArrangedSubview(evadditionalinfoBody)
        evadditionalinfoBody.translatesAutoresizingMaskIntoConstraints = false
        evadditionalinfoBody.heightAnchor.constraint(equalToConstant: 50).isActive = true
        evadditionalinfoBody.trailingAnchor.constraint(equalTo: stack3.trailingAnchor).isActive = true
        evadditionalinfoBody.leadingAnchor.constraint(equalTo: stack3.leadingAnchor).isActive = true
    }
    
    @objc private func requirements() {
        UIView.animate(withDuration: 0.3) {
            self.evrequirementsBody.isHidden = !self.evrequirementsBody.isHidden
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func dates() {
        UIView.animate(withDuration: 0.3) {
            self.evdatesBody.isHidden = !self.evdatesBody.isHidden
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func additionalinfo() {
        UIView.animate(withDuration: 0.3) {
            self.evadditionalinfoBody.isHidden = !self.evadditionalinfoBody.isHidden
            self.view.layoutIfNeeded()
        }
    }
}
