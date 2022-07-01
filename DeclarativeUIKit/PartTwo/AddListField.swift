//
//  AddListField.swift
//  DeclarativeUIKit
//
//  Created by Nayanda Haberty on 02/07/22.
//

import Foundation
import UIKit
import Draftsman
import Pharos
import Builder

class AddListField: UIView, Planned, ObjectRetainer {
    
    @Subject var text: String?
    @Subject var textReturned: String?
    
    private lazy var textField: UITextField = builder(UITextField(placeholder: "Add to list here"))
        .delegate(self)
        .build()
    
    @LayoutPlan
    var viewPlan: ViewPlan {
        textField.drf
            .edges.equal(with: .safeArea).offset(by: 16)
            .builder.delegate(self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        didInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        didInit()
    }
    
    private func didInit() {
        addShadow()
        applyPlan()
        backgroundColor = .white
        bind()
    }
    
    private func bind() {
        $text.bind(with: textField.bindables.text)
            .observe(on: .main)
            .retained(by: self)
    }
    
    private func addShadow() {
        layer.shadowOffset = CGSize(width: .zero, height: -4)
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.1
    }
}

extension AddListField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textReturned = text
        text = nil
        textField.resignFirstResponder()
        return true
    }
}
