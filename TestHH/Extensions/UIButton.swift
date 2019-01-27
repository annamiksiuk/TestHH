//
//  UIButton.swift
//  TestHH
//
//  Created by Anna Miksiuk on 27.01.2019.
//  Copyright © 2019 Anna Miksiuk. All rights reserved.
//

import UIKit

extension UIButton {
    func addLettersSpacing(spacing: CGFloat) {
        let attributedString = NSMutableAttributedString(string: titleLabel?.text ?? "")
        attributedString.addAttribute(NSAttributedString.Key.kern,
                                      value: spacing,
                                      range: NSMakeRange(0, (titleLabel?.text ?? "").count))
        setAttributedTitle(attributedString, for: .normal)
    }
}
