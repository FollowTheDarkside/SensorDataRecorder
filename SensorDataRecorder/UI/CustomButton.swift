//
//  CustomButton.swift
//  SensorDataRecorder
//
//  Created by FTD on 2019/09/03.
//  Copyright © 2019 FTD. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        self.layer.borderWidth = 3.0
        self.layer.cornerRadius = 3.0
        self.layer.borderColor = UIColor.black.cgColor
        
        self.tintColor = UIColor.black
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
    }

}
