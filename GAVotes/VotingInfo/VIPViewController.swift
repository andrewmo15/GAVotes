//
//  VIPViewController.swift
//  GAVotes
//
//  Created by Andrew Mo on 12/22/20.
//

import UIKit

class VIPViewController: UIViewController {

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
    
    private let vippolicies: UIButton = {
        let vippolicies = CustomButton()
        vippolicies.setTitle("Voting Policies and Requirements", for: .normal)
        vippolicies.addTarget(self, action: #selector(policies), for: .touchUpInside)
        return vippolicies
    }()
    
    private let vippoliciesBody: UITextView = {
        let vippolicies = UITextView()
        let text = "Verify that you are going to your assigned polling station with this app. Your polling station can change from election to election.\nYou must show photo identification when voting in person. Valid forms of ID include:\n    1. Georgia’s driver’s license, even if expired\n    2. Valid US passport\n    3. Georgia voter identification card\n    4. School ID is accepted from the following colleges, universities, and technical colleges found here.\n    5. You can find more specific information about what qualifies as Valid ID and how to obtain a Georgia voter identification card here.\nIf you do not bring your ID to the polling location, you can cast a provisional ballot, but you must provide valid ID at your county registrar within three days of Election Day.\nBe sure to social distance when voting. CDC guidelines for voters can be found here."
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.link, value: "https://sos.ga.gov/admin/files/acceptableID_9-18.v2.pdf", range: NSRange(location: 436, length: 4))
        attributedString.addAttribute(.link, value: "https://sos.ga.gov/index.php/elections/georgia_voter_identification_requirements2", range: NSRange(location: 575, length: 4))
        attributedString.addAttribute(.link, value: "https://www.cdc.gov/coronavirus/2019-ncov/community/election-polling-locations.html#VoterRecommendations", range: NSRange(location: 838, length: 4))
        vippolicies.attributedText = attributedString
        vippolicies.font = UIFont(name: "LouisGeorgeCafe", size: 18)!
        vippolicies.textAlignment = .left
        vippolicies.textColor = .black
        vippolicies.backgroundColor = .white
        vippolicies.tintColor = .link
        vippolicies.isHidden = true
        vippolicies.isEditable = false
        return vippolicies
    }()
    
    private let vipdates: UIButton = {
        let vipdates = CustomButton()
        vipdates.setTitle("Dates and Deadlines", for: .normal)
        vipdates.addTarget(self, action: #selector(dates), for: .touchUpInside)
        return vipdates
    }()
    
    private let vipdatesBody: UITextView = {
        let vipdates = UITextView()
        let text = "The calendar for election dates can be found here."
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.link, value: "https://sos.ga.gov/index.php/elections/elections_and_voter_registration_calendars", range: NSRange(location: 45, length: 4))
        vipdates.attributedText = attributedString
        vipdates.font = UIFont(name: "LouisGeorgeCafe", size: 18)!
        vipdates.textAlignment = .left
        vipdates.textColor = .black
        vipdates.backgroundColor = .white
        vipdates.tintColor = .link
        vipdates.isHidden = true
        vipdates.isEditable = false
        return vipdates
    }()
    
    private let vipadditionalinfo: UIButton = {
        let vipadditionalinfo = CustomButton()
        vipadditionalinfo.setTitle("Additional Information", for: .normal)
        vipadditionalinfo.addTarget(self, action: #selector(additionalinfo), for: .touchUpInside)
        return vipadditionalinfo
    }()
    
    private let vipadditionalinfoBody: UITextView = {
        let vipadditionalinfo = UITextView()
        let text = "For additional information, visit georgia.gov. If you have a problem at your polling location, call 404-656-2871 (in metro Atlanta) or 877-725-9727 (everywhere else in Georgia). Check your voter registration status, ballot status, and more at www.mvp.sps.ga.gov"
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.link, value: "https://georgia.gov/vote-election-day", range: NSRange(location: 34, length: 11))
        attributedString.addAttribute(.link, value: "https://www.mvp.sos.ga.gov/MVP/mvp.do", range: NSRange(location: 243, length: 18))
        vipadditionalinfo.attributedText = attributedString
        vipadditionalinfo.font = UIFont(name: "LouisGeorgeCafe", size: 18)!
        vipadditionalinfo.textAlignment = .left
        vipadditionalinfo.textColor = .black
        vipadditionalinfo.backgroundColor = .white
        vipadditionalinfo.tintColor = .link
        vipadditionalinfo.isHidden = true
        vipadditionalinfo.isEditable = false
        return vipadditionalinfo
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
        scrollView.contentSize = CGSize(width: view.frame.width, height: 850)
        myView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 850)
    }
    
    private func configureNavBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor(red: 14.0 / 255.0, green: 26.0 / 255.0, blue: 82.0 / 255.0, alpha: 1)
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "LouisGeorgeCafe-Bold", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "LouisGeorgeCafe-Bold", size: 30)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        self.title = "Voting in Person"
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
        stack1.addArrangedSubview(vippolicies)
        vippolicies.translatesAutoresizingMaskIntoConstraints = false
        vippolicies.heightAnchor.constraint(equalToConstant: 60).isActive = true
        vippolicies.trailingAnchor.constraint(equalTo: stack1.trailingAnchor).isActive = true
        vippolicies.leadingAnchor.constraint(equalTo: stack1.leadingAnchor).isActive = true
        
        stack1.addArrangedSubview(vippoliciesBody)
        vippoliciesBody.translatesAutoresizingMaskIntoConstraints = false
        vippoliciesBody.heightAnchor.constraint(equalToConstant: 450).isActive = true
        vippoliciesBody.trailingAnchor.constraint(equalTo: stack1.trailingAnchor).isActive = true
        vippoliciesBody.leadingAnchor.constraint(equalTo: stack1.leadingAnchor).isActive = true
        
        stack2.addArrangedSubview(vipdates)
        vipdates.translatesAutoresizingMaskIntoConstraints = false
        vipdates.heightAnchor.constraint(equalToConstant: 60).isActive = true
        vipdates.trailingAnchor.constraint(equalTo: stack2.trailingAnchor).isActive = true
        vipdates.leadingAnchor.constraint(equalTo: stack2.leadingAnchor).isActive = true
        
        stack2.addArrangedSubview(vipdatesBody)
        vipdatesBody.translatesAutoresizingMaskIntoConstraints = false
        vipdatesBody.heightAnchor.constraint(equalToConstant: 50).isActive = true
        vipdatesBody.trailingAnchor.constraint(equalTo: stack2.trailingAnchor).isActive = true
        vipdatesBody.leadingAnchor.constraint(equalTo: stack2.leadingAnchor).isActive = true
        
        stack3.addArrangedSubview(vipadditionalinfo)
        vipadditionalinfo.translatesAutoresizingMaskIntoConstraints = false
        vipadditionalinfo.heightAnchor.constraint(equalToConstant: 60).isActive = true
        vipadditionalinfo.trailingAnchor.constraint(equalTo: stack3.trailingAnchor).isActive = true
        vipadditionalinfo.leadingAnchor.constraint(equalTo: stack3.leadingAnchor).isActive = true
        
        stack3.addArrangedSubview(vipadditionalinfoBody)
        vipadditionalinfoBody.translatesAutoresizingMaskIntoConstraints = false
        vipadditionalinfoBody.heightAnchor.constraint(equalToConstant: 150).isActive = true
        vipadditionalinfoBody.trailingAnchor.constraint(equalTo: stack3.trailingAnchor).isActive = true
        vipadditionalinfoBody.leadingAnchor.constraint(equalTo: stack3.leadingAnchor).isActive = true
    }
    
    @objc private func policies() {
        UIView.animate(withDuration: 0.3) {
            self.vippoliciesBody.isHidden = !self.vippoliciesBody.isHidden
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func dates() {
        UIView.animate(withDuration: 0.3) {
            self.vipdatesBody.isHidden = !self.vipdatesBody.isHidden
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func additionalinfo() {
        UIView.animate(withDuration: 0.3) {
            self.vipadditionalinfoBody.isHidden = !self.vipadditionalinfoBody.isHidden
            self.view.layoutIfNeeded()
        }
    }
}
