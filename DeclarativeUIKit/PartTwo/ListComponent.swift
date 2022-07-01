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
import Builder

class ListComponent: UIView, Planned, ObjectRetainer {
    
    @Subject var text: String?
    @Subject var checked: Bool = false
    
    private lazy var checkButton: CheckButton = CheckButton()
    private lazy var label: UILabel = UILabel(font: .systemFont(ofSize: 18), textColor: .darkGray)
    private lazy var removeButton: UIButton = UIButton(type: .close)
    
    @LayoutPlan
    var viewPlan: ViewPlan {
        UIStackView(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 12).drf
            .edges.equal(with: .parent).offset(by: 12)
            .insertStacked {
                checkButton.drf
                    .size.equal(with: CGSize(sides: 20))
                label
                if checked {
                    removeButton.drf
                        .size.equal(with: CGSize(sides: 20))
                }
            }
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
    
    func whenRemoveDidTap(thenDo work: @escaping (Changes<UIControl.Event>) -> Void) -> Observed<UIControl.Event> {
        removeButton.whenDidTapped(thenDo: work)
    }
    
    private func didInit() {
        backgroundColor = .white
        removeButton.titleLabel?.font = .systemFont(ofSize: 12)
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
        
        $checked
            .mapped { checked in
                checked ? UIColor.lightGray : UIColor.darkGray
            }
            .relayChanges(to: label.bindables.textColor)
            .observe(on: .main)
            .retained(by: self)
        
        $checked
            .ignoreSameValue()
            .whenDidSet { [unowned self] _ in
                applyPlan()
            }
            .observe(on: .main)
            .retained(by: self)
    }
}
