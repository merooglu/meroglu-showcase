//
//  Metarialview.swift
//  meroglu-showcase
//
//  Created by Mehmet Eroğlu on 20.07.2017.
//  Copyright © 2017 Mehmet Eroğlu. All rights reserved.
//

import UIKit

class Materialview: UIView {

    override func awakeFromNib() {
        layer.cornerRadius = 2.0
        layer.shadowColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.5).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
    }

}
