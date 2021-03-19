//
//  Utills.swift
//  TheNoteApp
//
//  Created by Neskin Ivan on 17.03.2021.
//  Copyright © 2021 Neskin Ivan. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UITextField {
    class func setupTextField(placeholder: String, hideText: Bool) -> UITextField {
        let textField = CustomTextField.init(padding: 16)
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 16
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.placeholder = placeholder
        textField.isSecureTextEntry = hideText
        return textField
    }
}

class CustomTextField: UITextField {
    
    let padding: CGFloat
    
    init(padding: CGFloat) {
        self.padding = padding
        super.init(frame: .zero)
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    override var intrinsicContentSize: CGSize {
        return .init(width: 0, height: 50)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
