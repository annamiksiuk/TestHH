//
//  Global.swift
//  TestHH
//
//  Created by Anna Miksiuk on 26.01.2019.
//  Copyright © 2019 Anna Miksiuk. All rights reserved.
//

import UIKit

// MARK: - Alert

func alertOk(message: String) -> UIAlertController {
    let alert = UIAlertController(title: "TestHH",
                                  message: message,
                                  preferredStyle: .alert)
    let actionOK = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(actionOK)
    return alert
}

// MARK: - Enums

enum ValidationType: String {
    case email = "[a-zA-Z0-9]{1,32}@[a-zA-Z0-9]{1,10}.[a-zA-Z]{2,4}"
    case password = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{6,}$"
}

func validateString(text: String, type: ValidationType) -> Bool {
    let predicate = NSPredicate(format:"SELF MATCHES %@", type.rawValue)
    return predicate.evaluate(with: text)
}

