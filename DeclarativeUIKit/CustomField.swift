//
//  CustomField.swift
//  DeclarativeUIKit
//
//  Created by Nayanda Haberty on 16/06/22.
//

import UIKit
import Draftsman

class CustomField: UIView, Planned {
    
    @LayoutPlan
    var viewPlan: ViewPlan {
        UITextField().drf
            .edges.equal(with: .safeArea).offset(by: 16)
            .builder
            .placeholder("Type here!")
            .delegate(self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        didInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        didInit()
    }
    
    func didInit() {
        addShadow()
        applyPlan()
        backgroundColor = .white
    }
    
    func addShadow() {
        layer.shadowOffset = CGSize(width: .zero, height: -4)
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.1
    }
}

extension CustomField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
