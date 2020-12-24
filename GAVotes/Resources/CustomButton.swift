//
//  CustomButton.swift
//  GAVotes
//
//  Created by Andrew Mo on 10/27/20.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton() {
        backgroundColor = .white
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.5
        titleLabel?.font = UIFont(name: "LouisGeorgeCafe-Bold", size: 25)!
        setTitleColor(.black, for: .normal)
    }

}
