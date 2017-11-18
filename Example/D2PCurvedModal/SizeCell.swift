//
//  SizeCell.swift
//  D2PCurvedModal_Example
//
//  Created by Pradheep Rajendirane on 18/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class SizeCell: UICollectionViewCell {
    
    @IBOutlet weak var sizeLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setUpStyle()
        
    }
    
    func setUpStyle() {
        
        self.layer.cornerRadius = self.frame.height * 0.5
        
    }
    
    func setUpUnselectedStyle() {
        
        self.backgroundColor = .clear
        sizeLabel.textColor = .lightGray
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    func setUpSelectedStyle() {
        
        self.backgroundColor = UIColor(red:0.99, green:0.28, blue:0.25, alpha:1.0)
        sizeLabel.textColor = .white
        self.layer.borderWidth = 0.0
        
    }
    
    func animateCell() {
        self.transform = .init(translationX: 0, y: self.frame.height)
        self.alpha = 0.0
        
        UIView.animate(withDuration: 0.1, delay: 0.4, options: .curveEaseIn, animations: {
            self.transform = .identity
            self.alpha = 1.0
        }, completion: nil)
        
    }
    
}
