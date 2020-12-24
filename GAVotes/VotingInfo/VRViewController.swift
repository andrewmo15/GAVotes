//
//  VRViewController.swift
//  GAVotes
//
//  Created by Andrew Mo on 12/22/20.
//

import UIKit

class VRViewController: UIViewController {
    
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
    
    private let stack6: UIStackView = {
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
    
    private let vrrequirements: UIButton = {
        let vrrequirements = CustomButton()
        vrrequirements.setTitle("Voter Registration Requirements", for: .normal)
        vrrequirements.addTarget(self, action: #selector(requirements), for: .touchUpInside)
        return vrrequirements
    }()
    
    private let vrrequirementsBody: UITextView = {
        let vrrequirements = UITextView()
        vrrequirements.text = "To be eligible to register to vote, you must...\n    1. Be a citizen of the United States\n    2. Be a legal resident of the country\n    3. Be at least 17.5 years old (and 18 years old to vote)\n    4. Not be serving a sentence for conviction of a felony involving moral turpitude\n    5. Not be determined mentally incompetent by a judge"
        vrrequirements.font = UIFont(name: "LouisGeorgeCafe", size: 18)!
        vrrequirements.textAlignment = .left
        vrrequirements.textColor = .black
        vrrequirements.backgroundColor = .white
        vrrequirements.tintColor = .link
        vrrequirements.isEditable = false
        vrrequirements.isHidden = true
        return vrrequirements
    }()
    
    private let vronline: UIButton = {
        let vronline = CustomButton()
        vronline.setTitle("Registering Online", for: .normal)
        vronline.addTarget(self, action: #selector(online), for: .touchUpInside)
        return vronline
    }()
    
    private let vronlineBody: UITextView = {
        let vronline = UITextView()
        let text = "You can register to vote online here.\nYou will need valid ID. Valid forms of ID include:\n    1. Georgia’s driver’s license, even if expired\n    2. Valid US passport\n    3. Georgia voter identification card\n    4. School ID is accepted from the following colleges, universities, and technical colleges found here.\n    5. You can find more specific information about what qualifies as Valid ID and how to obtain a Georgia voter identification card here.\nYou are NOT officially registered until the form is approved, and you will receive a voter precinct card in the mail within 3 or 4 weeks."
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.link, value: "https://registertovote.sos.ga.gov/GAOLVR/welcometoga.do#no-back-button", range: NSRange(location: 32, length: 4))
        attributedString.addAttribute(.link, value: "https://sos.ga.gov/admin/files/acceptableID_9-18.v2.pdf", range: NSRange(location: 307, length: 4))
        attributedString.addAttribute(.link, value: "https://sos.ga.gov/index.php/elections/georgia_voter_identification_requirements2", range: NSRange(location: 446, length: 4))
        vronline.attributedText = attributedString
        vronline.font = UIFont(name: "LouisGeorgeCafe", size: 18)!
        vronline.textAlignment = .left
        vronline.textColor = .black
        vronline.backgroundColor = .white
        vronline.tintColor = .link
        vronline.isEditable = false
        vronline.isHidden = true
        return vronline
    }()
    
    private let vrmail: UIButton = {
        let vrmail = CustomButton()
        vrmail.setTitle("How to Vote By Mail", for: .normal)
        vrmail.addTarget(self, action: #selector(mail), for: .touchUpInside)
        return vrmail
    }()
    
    private let vrmailBody: UITextView = {
        let vrmail = UITextView()
        let text = "You can register by mail by printing and filling out this form.\n    1. Valid Georgia ID is not necessary for the form, though you may need the last four digits of your Social Security Number. If you have neither, check the box on Row 5 and a unique identifier will be provided for you\n    2. IF you are registering for the first time in Georgia and submitting the form by mail, you must include a copy of your ID as well as proof of residence, such as a copy of valid photo ID, utility bill, or bank statement. You can also provide this information when you vote for the first time. More information can be found on the form above.\nWhen complete, send the form to your local election official, which you can find here (postage is prepaid).\nYou are NOT officially registered until the form is approved, and you will receive a voter precinct card in the mail within 3 or 4 weeks."
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.link, value: "https://registertovote.sos.ga.gov/GAOLVR/images/reg_form.pdf", range: NSRange(location: 58, length: 4))
        attributedString.addAttribute(.link, value: "https://sos.ga.gov/index.php/elections/georgia_voter_identification_requirements2", range: NSRange(location: 713, length: 4))
        vrmail.attributedText = attributedString
        vrmail.font = UIFont(name: "LouisGeorgeCafe", size: 18)!
        vrmail.textAlignment = .left
        vrmail.textColor = .black
        vrmail.backgroundColor = .white
        vrmail.tintColor = .link
        vrmail.isEditable = false
        vrmail.isHidden = true
        return vrmail
    }()
    
    private let vrperson: UIButton = {
        let vrperson = CustomButton()
        vrperson.setTitle("Registering in Person", for: .normal)
        vrperson.addTarget(self, action: #selector(person), for: .touchUpInside)
        return vrperson
    }()
    
    private let vrpersonBody: UITextView = {
        let vrperson = UITextView()
        let text = "You can register to vote in person, though due to COVID-19, many locations are not open. You can find out where and when to register by contacting your local election office, which you can find here.\nYou will need to bring valid ID. Valid forms of ID include:\n    1. Georgia’s driver’s license, even if expired\n    2. Valid US passport\n    3. Georgia voter identification card\n    4. School ID is accepted from the following colleges, universities, and technical colleges found here.\n    5. You can find more specific information about what qualifies as Valid ID and how to obtain a Georgia voter identification card here.\nBe sure to social distance when registering to vote. CDC guidelines for voters can be found here."
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.link, value: "https://elections.sos.ga.gov/Elections/countyregistrars.do", range: NSRange(location: 194, length: 4))
        attributedString.addAttribute(.link, value: "https://sos.ga.gov/admin/files/acceptableID_9-18.v2.pdf", range: NSRange(location: 478, length: 4))
        attributedString.addAttribute(.link, value: "https://sos.ga.gov/index.php/elections/georgia_voter_identification_requirements2", range: NSRange(location: 617, length: 4))
        attributedString.addAttribute(.link, value: "https://www.cdc.gov/coronavirus/2019-ncov/community/election-polling-locations.html#VoterRecommendations", range: NSRange(location: 715, length: 4))
        vrperson.attributedText = attributedString
        vrperson.font = UIFont(name: "LouisGeorgeCafe", size: 18)!
        vrperson.textAlignment = .left
        vrperson.textColor = .black
        vrperson.backgroundColor = .white
        vrperson.tintColor = .link
        vrperson.isEditable = false
        vrperson.isHidden = true
        return vrperson
    }()
    
    private let vrdeadlines: UIButton = {
        let vrdeadlines = CustomButton()
        vrdeadlines.setTitle("How to Vote By Mail", for: .normal)
        vrdeadlines.addTarget(self, action: #selector(deadlines), for: .touchUpInside)
        return vrdeadlines
    }()
    
    private let vrdeadlinesBody: UITextView = {
        let vrdeadlines = UITextView()
        let text = "In Person & By Mail: 29 days prior to Election Day.\nOnline: Fifth Monday prior to Election Day.\nGeorgia does NOT offer same-day voter registration.\nSpecific voter registration deadlines for each election can be found here."
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.link, value: "https://sos.ga.gov/index.php/elections/elections_and_voter_registration_calendars", range: NSRange(location: text.count - 5, length: 4))
        vrdeadlines.attributedText = attributedString
        vrdeadlines.font = UIFont(name: "LouisGeorgeCafe", size: 18)!
        vrdeadlines.textAlignment = .left
        vrdeadlines.textColor = .black
        vrdeadlines.backgroundColor = .white
        vrdeadlines.tintColor = .link
        vrdeadlines.isEditable = false
        vrdeadlines.isHidden = true
        return vrdeadlines
    }()
    
    private let vradditionalinfo: UIButton = {
        let vradditionalinfo = CustomButton()
        vradditionalinfo.setTitle("Additional Information", for: .normal)
        vradditionalinfo.addTarget(self, action: #selector(additionalinfo), for: .touchUpInside)
        return vradditionalinfo
    }()
    
    private let vradditionalinfoBody: UITextView = {
        let vradditionalinfo = UITextView()
        let text = "You can look up your voter registration status and ballot status here.\nYou can change your current voter registration, for example, if you’ve moved or changed your name here.\nFor more information about voter registration policies, read here.\n"
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.link, value: "https://www.mvp.sos.ga.gov/MVP/mvp.do", range: NSRange(location: 65, length: 4))
        attributedString.addAttribute(.link, value: "https://registertovote.sos.ga.gov/GAOLVR/welcometoga.do#no-back-button", range: NSRange(location: 169, length: 4))
        attributedString.addAttribute(.link, value: "https://sos.ga.gov/index.php/Elections/register_to_vote", range: NSRange(location: 236, length: 4))
        vradditionalinfo.attributedText = attributedString
        vradditionalinfo.font = UIFont(name: "LouisGeorgeCafe", size: 18)!
        vradditionalinfo.textAlignment = .left
        vradditionalinfo.textColor = .black
        vradditionalinfo.backgroundColor = .white
        vradditionalinfo.tintColor = .link
        vradditionalinfo.isEditable = false
        vradditionalinfo.isHidden = true
        return vradditionalinfo
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
        myView.addSubview(stack6)
        configureStack()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width: view.frame.width, height: 2100)
        myView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 2100)
    }
    
    private func configureNavBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor(red: 14.0 / 255.0, green: 26.0 / 255.0, blue: 82.0 / 255.0, alpha: 1)
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "LouisGeorgeCafe-Bold", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "LouisGeorgeCafe-Bold", size: 30)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        self.title = "Voter Registration"
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
        
        stack6.translatesAutoresizingMaskIntoConstraints = false
        stack6.topAnchor.constraint(equalTo: stack5.bottomAnchor, constant: 0).isActive = true
        stack6.leadingAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        stack6.trailingAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        addViews()
    }
    
    private func addViews() {
        stack1.addArrangedSubview(vrrequirements)
        vrrequirements.translatesAutoresizingMaskIntoConstraints = false
        vrrequirements.heightAnchor.constraint(equalToConstant: 60).isActive = true
        vrrequirements.trailingAnchor.constraint(equalTo: stack1.trailingAnchor).isActive = true
        vrrequirements.leadingAnchor.constraint(equalTo: stack1.leadingAnchor).isActive = true
        
        stack1.addArrangedSubview(vrrequirementsBody)
        vrrequirementsBody.translatesAutoresizingMaskIntoConstraints = false
        vrrequirementsBody.heightAnchor.constraint(equalToConstant: 220).isActive = true
        vrrequirementsBody.trailingAnchor.constraint(equalTo: stack1.trailingAnchor).isActive = true
        vrrequirementsBody.leadingAnchor.constraint(equalTo: stack1.leadingAnchor).isActive = true
        
        stack2.addArrangedSubview(vronline)
        vronline.translatesAutoresizingMaskIntoConstraints = false
        vronline.heightAnchor.constraint(equalToConstant: 60).isActive = true
        vronline.trailingAnchor.constraint(equalTo: stack2.trailingAnchor).isActive = true
        vronline.leadingAnchor.constraint(equalTo: stack2.leadingAnchor).isActive = true
        
        stack2.addArrangedSubview(vronlineBody)
        vronlineBody.translatesAutoresizingMaskIntoConstraints = false
        vronlineBody.heightAnchor.constraint(equalToConstant: 320).isActive = true
        vronlineBody.trailingAnchor.constraint(equalTo: stack2.trailingAnchor).isActive = true
        vronlineBody.leadingAnchor.constraint(equalTo: stack2.leadingAnchor).isActive = true
        
        stack3.addArrangedSubview(vrmail)
        vrmail.translatesAutoresizingMaskIntoConstraints = false
        vrmail.heightAnchor.constraint(equalToConstant: 60).isActive = true
        vrmail.trailingAnchor.constraint(equalTo: stack3.trailingAnchor).isActive = true
        vrmail.leadingAnchor.constraint(equalTo: stack3.leadingAnchor).isActive = true
        
        stack3.addArrangedSubview(vrmailBody)
        vrmailBody.translatesAutoresizingMaskIntoConstraints = false
        vrmailBody.heightAnchor.constraint(equalToConstant: 450).isActive = true
        vrmailBody.trailingAnchor.constraint(equalTo: stack3.trailingAnchor).isActive = true
        vrmailBody.leadingAnchor.constraint(equalTo: stack3.leadingAnchor).isActive = true
        
        stack4.addArrangedSubview(vrperson)
        vrperson.translatesAutoresizingMaskIntoConstraints = false
        vrperson.heightAnchor.constraint(equalToConstant: 60).isActive = true
        vrperson.trailingAnchor.constraint(equalTo: stack3.trailingAnchor).isActive = true
        vrperson.leadingAnchor.constraint(equalTo: stack3.leadingAnchor).isActive = true
        
        stack4.addArrangedSubview(vrpersonBody)
        vrpersonBody.translatesAutoresizingMaskIntoConstraints = false
        vrpersonBody.heightAnchor.constraint(equalToConstant: 400).isActive = true
        vrpersonBody.trailingAnchor.constraint(equalTo: stack3.trailingAnchor).isActive = true
        vrpersonBody.leadingAnchor.constraint(equalTo: stack3.leadingAnchor).isActive = true
        
        stack5.addArrangedSubview(vrdeadlines)
        vrdeadlines.translatesAutoresizingMaskIntoConstraints = false
        vrdeadlines.heightAnchor.constraint(equalToConstant: 60).isActive = true
        vrdeadlines.trailingAnchor.constraint(equalTo: stack3.trailingAnchor).isActive = true
        vrdeadlines.leadingAnchor.constraint(equalTo: stack3.leadingAnchor).isActive = true
        
        stack5.addArrangedSubview(vrdeadlinesBody)
        vrdeadlinesBody.translatesAutoresizingMaskIntoConstraints = false
        vrdeadlinesBody.heightAnchor.constraint(equalToConstant: 150).isActive = true
        vrdeadlinesBody.trailingAnchor.constraint(equalTo: stack3.trailingAnchor).isActive = true
        vrdeadlinesBody.leadingAnchor.constraint(equalTo: stack3.leadingAnchor).isActive = true
        
        stack6.addArrangedSubview(vradditionalinfo)
        vradditionalinfo.translatesAutoresizingMaskIntoConstraints = false
        vradditionalinfo.heightAnchor.constraint(equalToConstant: 60).isActive = true
        vradditionalinfo.trailingAnchor.constraint(equalTo: stack3.trailingAnchor).isActive = true
        vradditionalinfo.leadingAnchor.constraint(equalTo: stack3.leadingAnchor).isActive = true
        
        stack6.addArrangedSubview(vradditionalinfoBody)
        vradditionalinfoBody.translatesAutoresizingMaskIntoConstraints = false
        vradditionalinfoBody.heightAnchor.constraint(equalToConstant: 200).isActive = true
        vradditionalinfoBody.trailingAnchor.constraint(equalTo: stack3.trailingAnchor).isActive = true
        vradditionalinfoBody.leadingAnchor.constraint(equalTo: stack3.leadingAnchor).isActive = true
    }
    
    @objc private func requirements() {
        UIView.animate(withDuration: 0.3) {
            self.vrrequirementsBody.isHidden = !self.vrrequirementsBody.isHidden
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func online() {
        UIView.animate(withDuration: 0.3) {
            self.vronlineBody.isHidden = !self.vronlineBody.isHidden
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func mail() {
        UIView.animate(withDuration: 0.3) {
            self.vrmailBody.isHidden = !self.vrmailBody.isHidden
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func person() {
        UIView.animate(withDuration: 0.3) {
            self.vrpersonBody.isHidden = !self.vrpersonBody.isHidden
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func deadlines() {
        UIView.animate(withDuration: 0.3) {
            self.vrdeadlinesBody.isHidden = !self.vrdeadlinesBody.isHidden
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func additionalinfo() {
        UIView.animate(withDuration: 0.3) {
            self.vradditionalinfoBody.isHidden = !self.vradditionalinfoBody.isHidden
            self.view.layoutIfNeeded()
        }
    }
}
