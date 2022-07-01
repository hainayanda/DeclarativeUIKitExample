//
//  TodoListViewController.swift
//  DeclarativeUIKit
//
//  Created by Nayanda Haberty on 02/07/22.
//

import Foundation
import Draftsman
import UIKit
import Pharos
import Builder

class TodoListViewController: UIViewController, Planned, ObjectRetainer {
    
    lazy var lists: [ListComponent] = [autoRemoveListComponent(text: "Test 1"), autoRemoveListComponent(text: "Test 1")]
    {
        didSet {
            applyPlanWhileAnimatingStack()

        }
    }
    
    lazy var addListField: AddListField = AddListField()
    lazy var scrollView: UIScrollView = UIScrollView()
    lazy var stackView: UIStackView = builder(UIStackView(axis: .vertical, distribution: .equalSpacing, spacing: 8))
        .layoutMargins(UIEdgeInsets(insets: 24))
        .isLayoutMarginsRelativeArrangement(true)
        .build()
    
    @LayoutPlan
    var viewPlan: ViewPlan {
        scrollView.drf
            .top.horizontal.equal(with: .parent)
            .bottom.equal(to: addListField.drf.top)
            .insert {
                stackView.drf
                    .width.equal(with: .parent)
                    .edges.equal(with: .parent)
                    .insertStacked {
                        for list in lists {
                            list
                        }
                    }
            }
        addListField.drf
            .horizontal.equal(with: .safeArea)
            .bottom.equal(with: .top(of: .keyboard))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "TODO LIST"
        applyPlanWhileAnimatingStack()
        observeInput()
    }
    
    private func observeInput() {
        addListField.$textReturned
            .compactMapped { $0 }
            .ignore { $0.new.isEmpty }
            .whenDidSet { [unowned self] changes in
                self.lists.append(autoRemoveListComponent(text: changes.new))
            }
            .observe(on: .main)
            .retained(by: self)
    }
    
    private func autoRemoveListComponent(text: String) -> ListComponent {
        let listComponent = ListComponent(text: text)
        listComponent.isHidden = true
        listComponent.alpha = .zero
        listComponent.whenRemoveDidTap { [unowned self, weak listComponent] _ in
            self.lists.removeAll { $0 == listComponent }
        }
        .observe(on: .main)
        .retained(by: self)
        return listComponent
    }
    
    private func applyPlanWhileAnimatingStack() {
        self.applyPlan()
        UIView.animate(withDuration: 0.25, delay: 0 , options: .curveEaseInOut) { [weak self] in
            guard let self = self else { return }
            for list in self.lists where list.isHidden {
                list.isHidden = false
                list.alpha = 1
            }
        }
    }
}
