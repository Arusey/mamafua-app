//
//  extensions.swift
//  Mamafua
//
//  Created by macbook on 24/11/2019.
//  Copyright © 2019 Arusey. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func validatedText(validationType: ValidatorType) throws -> String {
        let validator = VaildatorFactory.validatorFor(type: validationType)
        return try validator.validated(self.text!)
    }
}
