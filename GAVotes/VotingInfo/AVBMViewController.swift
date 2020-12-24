//
//  AVBMViewController.swift
//  GAVotes
//
//  Created by Andrew Mo on 12/22/20.
//

import UIKit

class AVBMViewController: UIViewController {

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
    
    private let stack4: UIStackView = {
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
    
    private let stack5: UIStackView = {
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
    
    private let avbmpolicies: UIButton = {
        let avbmpolicies = CustomButton()
        avbmpolicies.setTitle("Absentee Voting Policies", for: .normal)
        avbmpolicies.addTarget(self, action: #selector(policies), for: .touchUpInside)
        return avbmpolicies
    }()
    
    private let avbmpoliciesBody: UITextView = {
        let avbmpolicies = UITextView()
        let text = "Any registered Georgia voter may vote by mail with an absentee ballot.\nYou do not need to provide a reason for voting absentee.\nOnce you have voted by absentee, you CANNOT change your mind by voting in person."
        avbmpolicies.text = text
        avbmpolicies.font = UIFont(name: "LouisGeorgeCafe", size: 18)!
        avbmpolicies.textAlignment = .left
        avbmpolicies.textColor = .black
        avbmpolicies.backgroundColor = .white
        avbmpolicies.tintColor = .link
        avbmpolicies.isEditable = false
        avbmpolicies.isHidden = true
        return avbmpolicies
    }()
    
    private let avbmrequest: UIButton = {
        let avbmrequest = CustomButton()
        avbmrequest.setTitle("Request and Submit an Absentee", for: .normal)
        avbmrequest.addTarget(self, action: #selector(request), for: .touchUpInside)
        return avbmrequest
    }()
    
    private let avbmrequestBody: UITextView = {
        let avbmrequest = UITextView()
        let text = "You can request an absentee ballot up to 180 days before an election either online or with an absentee ballot request application. When requesting online, be sure to have your driver’s license or state-issued ID as well as your email address.\nFill out the absentee ballot request application above. You can submit by mail, by fax, or by handing in your application in person at your County Board of Registrar’s Office, which you can find here."
        var attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.link, value: "https://ballotrequest.sos.ga.gov/", range: NSRange(location: 76, length: 6))
        attributedString.addAttribute(.link, value: "https://georgia.gov/vote-absentee-ballot", range: NSRange(location: 118, length: 11))
        attributedString.addAttribute(.link, value: "https://elections.sos.ga.gov/Elections/countyregistrars.do", range: NSRange(location: 438, length: 4))
        avbmrequest.attributedText = attributedString
        avbmrequest.font = UIFont(name: "LouisGeorgeCafe", size: 18)!
        avbmrequest.textAlignment = .left
        avbmrequest.textColor = .black
        avbmrequest.backgroundColor = .white
        avbmrequest.tintColor = .link
        avbmrequest.isEditable = false
        avbmrequest.isHidden = true
        return avbmrequest
    }()
    
    private let avbmmail: UIButton = {
        let avbmmail = CustomButton()
        avbmmail.setTitle("How to Vote By Mail", for: .normal)
        avbmmail.addTarget(self, action: #selector(mail), for: .touchUpInside)
        return avbmmail
    }()
    
    private let avbmmailBody: UITextView = {
        let avbmmail = UITextView()
        let text = "Fill out and sign the absentee ballot once received.\nMail your ballot to your county election office, which you can find here.\nYou can also drop off your absentee ballot at a drop-off location in your county, which can be found with this app. You can also contact your County Registrar to find drop-off locations (no stamps required).\nYou do not have to include identification when voting absentee if you are not voting for the first time in Georgia. However, if you are voting for the first time in Georgia, registered by mail, and did not provide valid ID during registration, you have to provide a copy of valid ID when sending in your ballot. Valid forms of ID include:\n    1. Georgia’s driver’s license, even if expired\n    2. Valid US passport\n    3. Georgia voter identification card\n    4. School ID is accepted from the following colleges, universities, and technical colleges found here.\n    5. You can find more specific information about what qualifies as Valid ID and how to obtain a Georgia voter identification card here."
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.link, value: "https://elections.sos.ga.gov/Elections/countyelectionoffices.do", range: NSRange(location: 121, length: 4))
        attributedString.addAttribute(.link, value: "https://elections.sos.ga.gov/Elections/countyelectionoffices.do", range: NSRange(location: 294, length: 18))
        attributedString.addAttribute(.link, value: "https://sos.ga.gov/admin/files/acceptableID_9-18.v2.pdf", range: NSRange(location: 892, length: 4))
        attributedString.addAttribute(.link, value: "https://sos.ga.gov/index.php/elections/georgia_voter_identification_requirements2", range: NSRange(location: 1031, length: 4))
        avbmmail.attributedText = attributedString
        avbmmail.font = UIFont(name: "LouisGeorgeCafe", size: 18)!
        avbmmail.textAlignment = .left
        avbmmail.textColor = .black
        avbmmail.backgroundColor = .white
        avbmmail.tintColor = .link
        avbmmail.isEditable = false
        avbmmail.isHidden = true
        return avbmmail
    }()
    
    private let avbmdeadlines: UIButton = {
        let avbmdeadlines = CustomButton()
        avbmdeadlines.setTitle("Dates and Deadlines", for: .normal)
        avbmdeadlines.addTarget(self, action: #selector(deadlines), for: .touchUpInside)
        return avbmdeadlines
    }()
    
    private let avbmdeadlinesBody: UITextView = {
        let avbmdeadlines = UITextView()
        avbmdeadlines.text = "1. Absentee ballot applications must be received in person, by mail, or online by the Friday before Election Day\n2. Absentee ballots must be received either by mail or in drop-off locations by Election Day at 7:00pm"
        avbmdeadlines.font = UIFont(name: "LouisGeorgeCafe", size: 18)!
        avbmdeadlines.textAlignment = .left
        avbmdeadlines.textColor = .black
        avbmdeadlines.backgroundColor = .white
        avbmdeadlines.tintColor = .link
        avbmdeadlines.isEditable = false
        avbmdeadlines.isHidden = true
        return avbmdeadlines
    }()
    
    private let avbmadditionalinfo: UIButton = {
        let avbmadditionalinfo = CustomButton()
        avbmadditionalinfo.setTitle("Additional Information", for: .normal)
        avbmadditionalinfo.addTarget(self, action: #selector(additionalinfo), for: .touchUpInside)
        return avbmadditionalinfo
    }()
    
    private let avbmadditionalinfoBody: UITextView = {
        let avbmadditionalinfo = UITextView()
        let text = "For additional information, visit georgia.gov.\nCheck your voter registration status, ballot status, and more at this link."
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.link, value: "https://georgia.gov/vote-absentee-ballot", range: NSRange(location: 34, length: 11))
        attributedString.addAttribute(.link, value: "https://www.mvp.sos.ga.gov/MVP/mvp.do", range: NSRange(location: 117, length: 4))
        avbmadditionalinfo.attributedText = attributedString
        avbmadditionalinfo.font = UIFont(name: "LouisGeorgeCafe", size: 18)!
        avbmadditionalinfo.textAlignment = .left
        avbmadditionalinfo.textColor = .black
        avbmadditionalinfo.backgroundColor = .white
        avbmadditionalinfo.tintColor = .link
        avbmadditionalinfo.isEditable = false
        avbmadditionalinfo.isHidden = true
        return avbmadditionalinfo
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        view.addSubview(scrollView)
        scrollView.addSubview(myView)
        myView.addSubview(stack1)
        myView.addSubview(stack2)
        myView.addSubview(stack3)
        myView.addSubview(stack4)
        myView.addSubview(stack5)
        configureStack()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width: view.frame.width, height: 1550)
        myView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 1550)
    }
    
    private func configureNavBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor(red: 14.0 / 255.0, green: 26.0 / 255.0, blue: 82.0 / 255.0, alpha: 1)
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "LouisGeorgeCafe-Bold", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "LouisGeorgeCafe-Bold", size: 30)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        self.title = "Absentee Voting By Mail"
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
        
        stack4.translatesAutoresizingMaskIntoConstraints = false
        stack4.topAnchor.constraint(equalTo: stack3.bottomAnchor, constant: 0).isActive = true
        stack4.leadingAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        stack4.trailingAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        stack5.translatesAutoresizingMaskIntoConstraints = false
        stack5.topAnchor.constraint(equalTo: stack4.bottomAnchor, constant: 0).isActive = true
        stack5.leadingAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        stack5.trailingAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.trailingAnchor).isActive = true
        addViews()
    }
    
    private func addViews() {
        stack1.addArrangedSubview(avbmpolicies)
        avbmpolicies.translatesAutoresizingMaskIntoConstraints = false
        avbmpolicies.heightAnchor.constraint(equalToConstant: 60).isActive = true
        avbmpolicies.trailingAnchor.constraint(equalTo: stack1.trailingAnchor).isActive = true
        avbmpolicies.leadingAnchor.constraint(equalTo: stack1.leadingAnchor).isActive = true
        
        stack1.addArrangedSubview(avbmpoliciesBody)
        avbmpoliciesBody.translatesAutoresizingMaskIntoConstraints = false
        avbmpoliciesBody.heightAnchor.constraint(equalToConstant: 150).isActive = true
        avbmpoliciesBody.trailingAnchor.constraint(equalTo: stack1.trailingAnchor).isActive = true
        avbmpoliciesBody.leadingAnchor.constraint(equalTo: stack1.leadingAnchor).isActive = true
        
        stack2.addArrangedSubview(avbmrequest)
        avbmrequest.translatesAutoresizingMaskIntoConstraints = false
        avbmrequest.heightAnchor.constraint(equalToConstant: 60).isActive = true
        avbmrequest.trailingAnchor.constraint(equalTo: stack2.trailingAnchor).isActive = true
        avbmrequest.leadingAnchor.constraint(equalTo: stack2.leadingAnchor).isActive = true
        
        stack2.addArrangedSubview(avbmrequestBody)
        avbmrequestBody.translatesAutoresizingMaskIntoConstraints = false
        avbmrequestBody.heightAnchor.constraint(equalToConstant: 250).isActive = true
        avbmrequestBody.trailingAnchor.constraint(equalTo: stack2.trailingAnchor).isActive = true
        avbmrequestBody.leadingAnchor.constraint(equalTo: stack2.leadingAnchor).isActive = true
        
        stack3.addArrangedSubview(avbmmail)
        avbmmail.translatesAutoresizingMaskIntoConstraints = false
        avbmmail.heightAnchor.constraint(equalToConstant: 60).isActive = true
        avbmmail.trailingAnchor.constraint(equalTo: stack3.trailingAnchor).isActive = true
        avbmmail.leadingAnchor.constraint(equalTo: stack3.leadingAnchor).isActive = true
        
        stack3.addArrangedSubview(avbmmailBody)
        avbmmailBody.translatesAutoresizingMaskIntoConstraints = false
        avbmmailBody.heightAnchor.constraint(equalToConstant: 550).isActive = true
        avbmmailBody.trailingAnchor.constraint(equalTo: stack3.trailingAnchor).isActive = true
        avbmmailBody.leadingAnchor.constraint(equalTo: stack3.leadingAnchor).isActive = true
        
        stack4.addArrangedSubview(avbmdeadlines)
        avbmdeadlines.translatesAutoresizingMaskIntoConstraints = false
        avbmdeadlines.heightAnchor.constraint(equalToConstant: 60).isActive = true
        avbmdeadlines.trailingAnchor.constraint(equalTo: stack3.trailingAnchor).isActive = true
        avbmdeadlines.leadingAnchor.constraint(equalTo: stack3.leadingAnchor).isActive = true
        
        stack4.addArrangedSubview(avbmdeadlinesBody)
        avbmdeadlinesBody.translatesAutoresizingMaskIntoConstraints = false
        avbmdeadlinesBody.heightAnchor.constraint(equalToConstant: 150).isActive = true
        avbmdeadlinesBody.trailingAnchor.constraint(equalTo: stack3.trailingAnchor).isActive = true
        avbmdeadlinesBody.leadingAnchor.constraint(equalTo: stack3.leadingAnchor).isActive = true
        
        stack5.addArrangedSubview(avbmadditionalinfo)
        avbmadditionalinfo.translatesAutoresizingMaskIntoConstraints = false
        avbmadditionalinfo.heightAnchor.constraint(equalToConstant: 60).isActive = true
        avbmadditionalinfo.trailingAnchor.constraint(equalTo: stack3.trailingAnchor).isActive = true
        avbmadditionalinfo.leadingAnchor.constraint(equalTo: stack3.leadingAnchor).isActive = true
        
        stack5.addArrangedSubview(avbmadditionalinfoBody)
        avbmadditionalinfoBody.translatesAutoresizingMaskIntoConstraints = false
        avbmadditionalinfoBody.heightAnchor.constraint(equalToConstant: 150).isActive = true
        avbmadditionalinfoBody.trailingAnchor.constraint(equalTo: stack3.trailingAnchor).isActive = true
        avbmadditionalinfoBody.leadingAnchor.constraint(equalTo: stack3.leadingAnchor).isActive = true
    }
    
    @objc private func policies() {
        UIView.animate(withDuration: 0.3) {
            self.avbmpoliciesBody.isHidden = !self.avbmpoliciesBody.isHidden
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func request() {
        UIView.animate(withDuration: 0.3) {
            self.avbmrequestBody.isHidden = !self.avbmrequestBody.isHidden
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func mail() {
        UIView.animate(withDuration: 0.3) {
            self.avbmmailBody.isHidden = !self.avbmmailBody.isHidden
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func deadlines() {
        UIView.animate(withDuration: 0.3) {
            self.avbmdeadlinesBody.isHidden = !self.avbmdeadlinesBody.isHidden
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func additionalinfo() {
        UIView.animate(withDuration: 0.3) {
            self.avbmadditionalinfoBody.isHidden = !self.avbmadditionalinfoBody.isHidden
            self.view.layoutIfNeeded()
        }
    }
}
