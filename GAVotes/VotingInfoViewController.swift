//
//  VoterInfoViewController.swift
//  GAVotes
//
//  Created by Andrew Mo on 10/27/20.
//

import UIKit

class VotingInfoViewController: UIViewController {
    
    @IBOutlet weak var vrrequirementsBody: UITextView!
    @IBOutlet weak var vronlineBody: UITextView!
    @IBOutlet weak var vrByMailBody: UITextView!
    @IBOutlet weak var vrInPersonBody: UITextView!
    @IBOutlet weak var vrDeadlinesBody: UITextView!
    @IBOutlet weak var vrAdditionalInformationBody: UITextView!
    @IBOutlet var vrcollection: [UIStackView]!
    
    @IBOutlet weak var evRequirementsBody: UITextView!
    @IBOutlet weak var evDatesDeadlinesBody: UITextView!
    @IBOutlet weak var evAdditionalInformationBody: UITextView!
    @IBOutlet var evcollection: [UIStackView]!
    
    @IBOutlet weak var avbmPoliciesBody: UITextView!
    @IBOutlet weak var avbmRequestSubmitBallotBody: UITextView!
    @IBOutlet weak var avbmByMailBody: UITextView!
    @IBOutlet weak var avbmDeadlines: UITextView!
    @IBOutlet weak var avbmAdditionalInformationBody: UITextView!
    @IBOutlet var avbmcollection: [UIStackView]!
    
    @IBOutlet weak var vipPoliciesBody: UITextView!
    @IBOutlet weak var vipDatesDeadlinesBody: UITextView!
    @IBOutlet weak var vipAdditionalInformationBody: UITextView!
    @IBOutlet var vipcollection: [UIStackView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        configureNavBar()
        configureBody()
    }
    
    private func configureNavBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor(red: 14.0 / 255.0, green: 26.0 / 255.0, blue: 82.0 / 255.0, alpha: 1)
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "LouisGeorgeCafe-Bold", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "LouisGeorgeCafe-Bold", size: 40)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "location"), style: .done, target: self, action: #selector(showAddress))
        self.title = "Voting Info"
    }
    
    @objc private func showAddress() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "editAddress")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    @IBAction func registration(_ sender: UIButton) {
        vrcollection.forEach { (stack) in
            UIView.animate(withDuration: 0.3) {
                stack.isHidden = !stack.isHidden
                self.view.layoutIfNeeded()
            }
        }
    }
    @IBAction func vrrequirements(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.vrrequirementsBody.isHidden = !self.vrrequirementsBody.isHidden
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func vronline(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.vronlineBody.isHidden = !self.vronlineBody.isHidden
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func vrByMail(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.vrByMailBody.isHidden = !self.vrByMailBody.isHidden
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func vrInPerson(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.vrInPersonBody.isHidden = !self.vrInPersonBody.isHidden
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func vrDeadlines(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.vrDeadlinesBody.isHidden = !self.vrDeadlinesBody.isHidden
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func vrAdditionalInformation(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.vrAdditionalInformationBody.isHidden = !self.vrAdditionalInformationBody.isHidden
            self.view.layoutIfNeeded()
        }
    }
    
    
    @IBAction func earlyvoting(_ sender: Any) {
        evcollection.forEach { (stack) in
            UIView.animate(withDuration: 0.3) {
                stack.isHidden = !stack.isHidden
                self.view.layoutIfNeeded()
            }
        }
    }
    @IBAction func evRequirements(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.evRequirementsBody.isHidden = !self.evRequirementsBody.isHidden
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func evDatesDeadlines(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.evDatesDeadlinesBody.isHidden = !self.evDatesDeadlinesBody.isHidden
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func evAdditionalInformation(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.evAdditionalInformationBody.isHidden = !self.evAdditionalInformationBody.isHidden
            self.view.layoutIfNeeded()
        }
    }
    
    
    @IBAction func avbm(_ sender: Any) {
        avbmcollection.forEach { (stack) in
            UIView.animate(withDuration: 0.3) {
                stack.isHidden = !stack.isHidden
                self.view.layoutIfNeeded()
            }
        }
    }
    @IBAction func avbmPolicies(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.avbmPoliciesBody.isHidden = !self.avbmPoliciesBody.isHidden
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func avbmRequstSubmitBallot(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.avbmRequestSubmitBallotBody.isHidden = !self.avbmRequestSubmitBallotBody.isHidden
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func avbmByMail(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.avbmByMailBody.isHidden = !self.avbmByMailBody.isHidden
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func avbmDeadlines(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.avbmDeadlines.isHidden = !self.avbmDeadlines.isHidden
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func avbmAdditionalInformation(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.avbmAdditionalInformationBody.isHidden = !self.avbmAdditionalInformationBody.isHidden
            self.view.layoutIfNeeded()
        }
    }
    
    
    @IBAction func vip(_ sender: Any) {
        vipcollection.forEach { (stack) in
            UIView.animate(withDuration: 0.3) {
                stack.isHidden = !stack.isHidden
                self.view.layoutIfNeeded()
            }
        }
    }
    @IBAction func vipPolicies(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.vipPoliciesBody.isHidden = !self.vipPoliciesBody.isHidden
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func vipDatesDeadlines(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.vipDatesDeadlinesBody.isHidden = !self.vipDatesDeadlinesBody.isHidden
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func vipAdditionalInformation(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.vipAdditionalInformationBody.isHidden = !self.vipAdditionalInformationBody.isHidden
            self.view.layoutIfNeeded()
        }
    }
    
    private func configureBody() {
        vrrequirementsBody.text = "To be eligible to register to vote, you must...\n    1. Be a citizen of the United States\n    2. Be a legal resident of the country\n    3. Be at least 17.5 years old (and 18 years old to vote)\n    4. Not be serving a sentence for conviction of a felony involving moral turpitude\n    5. Not be determined mentally incompetent by a judge"
        vrrequirementsBody.font = UIFont(name: "LouisGeorgeCafe", size: 18)!
        vrrequirementsBody.textAlignment = .left
        vrrequirementsBody.textColor = .black
        
        var text = "You can register to vote online here.\nYou will need valid ID. Valid forms of ID include:\n    1. Georgia’s driver’s license, even if expired\n    2. Valid US passport\n    3. Georgia voter identification card\n    4. School ID is accepted from the following colleges, universities, and technical colleges found here.\n    5. You can find more specific information about what qualifies as Valid ID and how to obtain a Georgia voter identification card here.\nYou are NOT officially registered until the form is approved, and you will receive a voter precinct card in the mail within 3 or 4 weeks."
        var attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.link, value: "https://registertovote.sos.ga.gov/GAOLVR/welcometoga.do#no-back-button", range: NSRange(location: 32, length: 4))
        attributedString.addAttribute(.link, value: "https://sos.ga.gov/admin/files/acceptableID_9-18.v2.pdf", range: NSRange(location: 307, length: 4))
        attributedString.addAttribute(.link, value: "https://sos.ga.gov/index.php/elections/georgia_voter_identification_requirements2", range: NSRange(location: 445, length: 4))
        vronlineBody.attributedText = attributedString
        vronlineBody.font = UIFont(name: "LouisGeorgeCafe", size: 18)!
        vronlineBody.textAlignment = .left
        vronlineBody.textColor = .black
        
        text = "You can register by mail by printing and filling out this form.\n    1. Valid Georgia ID is not necessary for the form, though you may need the last four digits of your Social Security Number. If you have neither, check the box on Row 5 and a unique identifier will be provided for you\n    2. IF you are registering for the first time in Georgia and submitting the form by mail, you must include a copy of your ID as well as proof of residence, such as a copy of valid photo ID, utility bill, or bank statement. You can also provide this information when you vote for the first time. More information can be found on the form above.\nWhen complete, send the form to your local election official, which you can find here (postage is prepaid).\nYou are NOT officially registered until the form is approved, and you will receive a voter precinct card in the mail within 3 or 4 weeks."
        attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.link, value: "https://registertovote.sos.ga.gov/GAOLVR/images/reg_form.pdf", range: NSRange(location: 58, length: 4))
        attributedString.addAttribute(.link, value: "https://sos.ga.gov/index.php/elections/georgia_voter_identification_requirements2", range: NSRange(location: 713, length: 4))
        vrByMailBody.attributedText = attributedString
        vrByMailBody.font = UIFont(name: "LouisGeorgeCafe", size: 18)!
        vrByMailBody.textAlignment = .left
        vrByMailBody.textColor = .black
        
        text = "You can register to vote in person, though due to COVID-19, many locations are not open. You can find out where and when to register by contacting your local election office, which you can find here.\nYou will need to bring valid ID. Valid forms of ID include:\n    1. Georgia’s driver’s license, even if expired\n    2. Valid US passport\n    3. Georgia voter identification card\n    4. School ID is accepted from the following colleges, universities, and technical colleges found here.\n    5. You can find more specific information about what qualifies as Valid ID and how to obtain a Georgia voter identification card here.\nBe sure to social distance when registering to vote. CDC guidelines for voters can be found here."
        attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.link, value: "https://elections.sos.ga.gov/Elections/countyregistrars.do", range: NSRange(location: 194, length: 4))
        attributedString.addAttribute(.link, value: "https://sos.ga.gov/admin/files/acceptableID_9-18.v2.pdf", range: NSRange(location: 478, length: 4))
        attributedString.addAttribute(.link, value: "https://sos.ga.gov/index.php/elections/georgia_voter_identification_requirements2", range: NSRange(location: 617, length: 4))
        attributedString.addAttribute(.link, value: "https://www.cdc.gov/coronavirus/2019-ncov/community/election-polling-locations.html#VoterRecommendations", range: NSRange(location: 715, length: 4))
        vrInPersonBody.attributedText = attributedString
        vrInPersonBody.font = UIFont(name: "LouisGeorgeCafe", size: 18)!
        vrInPersonBody.textAlignment = .left
        vrInPersonBody.textColor = .black
        
        text = "In Person & By Mail: 29 days prior to Election Day.\nOnline: Fifth Monday prior to Election Day.\nGeorgia does NOT offer same-day voter registration.\nSpecific voter registration deadlines for each election can be found here."
        attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.link, value: "https://sos.ga.gov/index.php/elections/elections_and_voter_registration_calendars", range: NSRange(location: text.count - 5, length: 4))
        vrDeadlinesBody.attributedText = attributedString
        vrDeadlinesBody.font = UIFont(name: "LouisGeorgeCafe-Bold", size: 18)!
        vrDeadlinesBody.textAlignment = .left
        vrDeadlinesBody.textColor = .black
        
        text = "You can look up your voter registration status and ballot status here.\nYou can change your current voter registration, for example, if you’ve moved or changed your name here.\nFor more information about voter registration policies, read here.\n"
        attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.link, value: "https://www.mvp.sos.ga.gov/MVP/mvp.do", range: NSRange(location: 65, length: 4))
        attributedString.addAttribute(.link, value: "https://registertovote.sos.ga.gov/GAOLVR/welcometoga.do#no-back-button", range: NSRange(location: 169, length: 4))
        attributedString.addAttribute(.link, value: "https://sos.ga.gov/index.php/Elections/register_to_vote", range: NSRange(location: 236, length: 4))
        vrAdditionalInformationBody.attributedText = attributedString
        vrAdditionalInformationBody.font = UIFont(name: "LouisGeorgeCafe", size: 18)!
        vrAdditionalInformationBody.textAlignment = .left
        vrAdditionalInformationBody.textColor = .black
        
        text = "You can vote at any early voting site in your county.\nTo vote early, you must bring valid voter ID. Valid forms of ID include:\n    1. Georgia’s driver’s license, even if expired\n    2. Valid US passport\n    3. Georgia voter identification card\n    4. School ID is accepted from the following colleges, universities, and technical colleges found here.\n    5. You can find more specific information about what qualifies as Valid ID and how to obtain a Georgia voter identification card here.\nBe sure to social distance when registering to vote. CDC guidelines for voters can be found here."
        attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.link, value: "https://sos.ga.gov/admin/files/acceptableID_9-18.v2.pdf", range: NSRange(location: 345, length: 4))
        attributedString.addAttribute(.link, value: "https://sos.ga.gov/index.php/elections/georgia_voter_identification_requirements2", range: NSRange(location: 484, length: 4))
        attributedString.addAttribute(.link, value: "https://www.cdc.gov/coronavirus/2019-ncov/community/election-polling-locations.html#VoterRecommendations", range: NSRange(location: 582, length: 4))
        evRequirementsBody.attributedText = attributedString
        evRequirementsBody.font = UIFont(name: "LouisGeorgeCafe", size: 18)!
        evRequirementsBody.textAlignment = .left
        evRequirementsBody.textColor = .black
        
        text = "Early in-person voting begins on the fourth Monday prior to a primary or election.\nThe early voting period ends on the Friday before Election Day.\nThe calendar for when voting dates and deadlines for voter registration, including when early voting begins, can be found here."
        attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.link, value: "https://sos.ga.gov/index.php/elections/elections_and_voter_registration_calendars", range: NSRange(location: 269, length: 4))
        evDatesDeadlinesBody.attributedText = attributedString
        evDatesDeadlinesBody.font = UIFont(name: "LouisGeorgeCafe", size: 18)!
        evDatesDeadlinesBody.textAlignment = .left
        evDatesDeadlinesBody.textColor = .black
        
        text = "For additional information, visit georgia.gov."
        attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.link, value: "https://georgia.gov/early-voting", range: NSRange(location: 34, length: 11))
        evAdditionalInformationBody.attributedText = attributedString
        evAdditionalInformationBody.font = UIFont(name: "LouisGeorgeCafe", size: 18)!
        evAdditionalInformationBody.textAlignment = .center
        evAdditionalInformationBody.textColor = .black
        
        text = "Any registered Georgia voter may vote by mail with an absentee ballot.\nYou do not need to provide a reason for voting absentee.\nOnce you have voted by absentee, you CANNOT change your mind by voting in person."
        avbmPoliciesBody.text = text
        avbmPoliciesBody.font = UIFont(name: "LouisGeorgeCafe", size: 18)!
        avbmPoliciesBody.textAlignment = .left
        avbmPoliciesBody.textColor = .black
        
        text = "You can request an absentee ballot up to 180 days before an election either online or with an absentee ballot request application. When requesting online, be sure to have your driver’s license or state-issued ID as well as your email address.\nFill out the absentee ballot request application above. You can submit by mail, by fax, or by handing in your application in person at your County Board of Registrar’s Office, which you can find here."
        attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.link, value: "https://ballotrequest.sos.ga.gov/", range: NSRange(location: 76, length: 6))
        attributedString.addAttribute(.link, value: "https://georgia.gov/vote-absentee-ballot", range: NSRange(location: 118, length: 11))
        attributedString.addAttribute(.link, value: "https://elections.sos.ga.gov/Elections/countyregistrars.do", range: NSRange(location: 438, length: 4))
        avbmRequestSubmitBallotBody.attributedText = attributedString
        avbmRequestSubmitBallotBody.font = UIFont(name: "LouisGeorgeCafe", size: 18)!
        avbmRequestSubmitBallotBody.textAlignment = .center
        avbmRequestSubmitBallotBody.textColor = .black
        
        text = "Fill out and sign the absentee ballot once received.\nMail your ballot to your county election office, which you can find here.\nYou can also drop off your absentee ballot at a drop-off location in your county, which can be found with this app. You can also contact your County Registrar to find drop-off locations (no stamps required).\nYou do not have to include identification when voting absentee if you are not voting for the first time in Georgia. However, if you are voting for the first time in Georgia, registered by mail, and did not provide valid ID during registration, you have to provide a copy of valid ID when sending in your ballot. Valid forms of ID include:\n    1. Georgia’s driver’s license, even if expired\n    2. Valid US passport\n    3. Georgia voter identification card\n    4. School ID is accepted from the following colleges, universities, and technical colleges found here.\n    5. You can find more specific information about what qualifies as Valid ID and how to obtain a Georgia voter identification card here."
        attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.link, value: "https://elections.sos.ga.gov/Elections/countyelectionoffices.do", range: NSRange(location: 121, length: 4))
        attributedString.addAttribute(.link, value: "https://elections.sos.ga.gov/Elections/countyelectionoffices.do", range: NSRange(location: 294, length: 18))
        attributedString.addAttribute(.link, value: "https://sos.ga.gov/admin/files/acceptableID_9-18.v2.pdf", range: NSRange(location: 892, length: 4))
        attributedString.addAttribute(.link, value: "https://sos.ga.gov/index.php/elections/georgia_voter_identification_requirements2", range: NSRange(location: 1031, length: 4))
        avbmByMailBody.attributedText = attributedString
        avbmByMailBody.font = UIFont(name: "LouisGeorgeCafe", size: 18)!
        avbmByMailBody.textAlignment = .center
        avbmByMailBody.textColor = .black
        
        avbmDeadlines.text = "Absentee ballot applications must be received in person, by mail, or online by the Friday before Election Day.\nAbsentee ballots must be received either by mail or in drop-off locations by Election Day at 7:00pm."
        avbmDeadlines.attributedText = attributedString
        avbmDeadlines.font = UIFont(name: "LouisGeorgeCafe", size: 18)!
        avbmDeadlines.textAlignment = .center
        avbmDeadlines.textColor = .black
        
        text = "For additional information, visit *georgia.gov.\nCheck your voter registration status, ballot status, and more at this link."
        attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.link, value: "https://georgia.gov/vote-absentee-ballot", range: NSRange(location: 34, length: 4))
        attributedString.addAttribute(.link, value: "https://www.mvp.sos.ga.gov/MVP/mvp.do", range: NSRange(location: 117, length: 4))
        avbmAdditionalInformationBody.attributedText = attributedString
        avbmAdditionalInformationBody.font = UIFont(name: "LouisGeorgeCafe", size: 18)!
        avbmAdditionalInformationBody.textAlignment = .center
        avbmAdditionalInformationBody.textColor = .black
        
        text = "Verify that you are going to your assigned polling station with this app. Your polling station can change from election to election.\nYou must show photo identification when voting in person. Valid forms of ID include:\n    1. Georgia’s driver’s license, even if expired\n    2. Valid US passport\n    3. Georgia voter identification card\n    4. School ID is accepted from the following colleges, universities, and technical colleges found here.\n    5. You can find more specific information about what qualifies as Valid ID and how to obtain a Georgia voter identification card here.\nIf you do not bring your ID to the polling location, you can cast a provisional ballot, but you must provide valid ID at your county registrar within three days of Election Day.\nBe sure to social distance when voting. CDC guidelines for voters can be found here."
        attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.link, value: "https://sos.ga.gov/admin/files/acceptableID_9-18.v2.pdf", range: NSRange(location: 436, length: 4))
        attributedString.addAttribute(.link, value: "https://sos.ga.gov/index.php/elections/georgia_voter_identification_requirements2", range: NSRange(location: 575, length: 4))
        attributedString.addAttribute(.link, value: "https://www.cdc.gov/coronavirus/2019-ncov/community/election-polling-locations.html#VoterRecommendations", range: NSRange(location: 838, length: 4))
        vipPoliciesBody.attributedText = attributedString
        vipPoliciesBody.font = UIFont(name: "LouisGeorgeCafe", size: 18)!
        vipPoliciesBody.textAlignment = .center
        vipPoliciesBody.textColor = .black
        
        text = "The calendar for election dates can be found here."
        attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.link, value: "https://sos.ga.gov/index.php/elections/elections_and_voter_registration_calendars", range: NSRange(location: 45, length: 4))
        vipDatesDeadlinesBody.attributedText = attributedString
        vipDatesDeadlinesBody.font = UIFont(name: "LouisGeorgeCafe", size: 18)!
        vipDatesDeadlinesBody.textAlignment = .center
        vipDatesDeadlinesBody.textColor = .black
        
        text = "For additional information, visit georgia.gov. If you have a problem at your polling location, call 404-656-2871 (in metro Atlanta) or 877-725-9727 (everywhere else in Georgia). Check your voter registration status, ballot status, and more at www.mvp.sps.ga.gov"
        attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.link, value: "https://georgia.gov/vote-election-day", range: NSRange(location: 34, length: 11))
        attributedString.addAttribute(.link, value: "https://www.mvp.sos.ga.gov/MVP/mvp.do", range: NSRange(location: 243, length: 18))
        vipAdditionalInformationBody.attributedText = attributedString
        vipAdditionalInformationBody.font = UIFont(name: "LouisGeorgeCafe", size: 18)!
        vipAdditionalInformationBody.textAlignment = .center
        vipAdditionalInformationBody.textColor = .black
    }
}
