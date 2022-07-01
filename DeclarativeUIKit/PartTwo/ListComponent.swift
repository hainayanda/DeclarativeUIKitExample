//
//  ListComponent.swift
//  DeclarativeUIKit
//
//  Created by Nayanda Haberty on 02/07/22.
//

import Foundation
import UIKit
import Draftsman
import Pharos

class ListComponent: UIView, Planned, ObjectRetainer {
    
    @Subject var text: String?
    @Subject var checked: Bool = false
    
    private lazy var checkButton: CheckButton = CheckButton()
    private lazy var label: UILabel = UILabel(font: .systemFont(ofSize: 18), textColor: .darkGray)
    
    @LayoutPlan
    var viewPlan: ViewPlan {
        checkButton.drf
            .left.equal(with: .parent).offset(by: 12)
            .vertical.moreThan(with: .parent).offset(by: 12)
            .centerY.equal(with: .parent)
            .width.equal(with: .height(of: .mySelf))
        label.drf
            .vertical.right.equal(with: .parent).offset(by: 12)
            .left.equal(to: checkButton.drf.right).offset(by: 12)
    }
    
    init(text: String) {
        super.init(frame: .zero)
        self.text = text
        didInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        didInit()
    }
    
    private func didInit() {
        backgroundColor = .white
        setupBorder()
        addShadow()
        bind()
        applyPlan()
    }
    
    private func setupBorder() {
        layer.cornerRadius = 12
        layer.borderColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
        layer.borderWidth = 1
    }
    
    private func addShadow() {
        layer.shadowOffset = CGSize(width: .zero, height: -4)
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.1
    }
    
    private func bind() {
        $text.bind(with: label.bindables.text)
            .observe(on: .main)
            .retained(by: self)
            .fire()
        
        $checked.bind(with: checkButton.$checked)
            .observe(on: .main)
            .retained(by: self)
    }
}
