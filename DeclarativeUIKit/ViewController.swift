//
//  ViewController.swift
//  DeclarativeUIKit
//
//  Created by Nayanda Haberty on 16/06/22.
//

import UIKit
import Draftsman
import Pharos

class ViewController: UIViewController, Planned, ObjectRetainer {
    
    lazy var partOneButton: UIButton = UIButton(text: "Tap for part 1", textColor: .black)
    lazy var partTwoButton: UIButton = UIButton(text: "Tap for part 2", textColor: .black)
    
    @LayoutPlan
    var viewPlan: ViewPlan {
        UIStackView(axis: .vertical, alignment: .fill, spacing: 8).drf
            .centerY.equal(with: .safeArea)
            .horizontal.equal(with: .safeArea).offset(by: 24)
            .vertical.moreThan(with: .safeArea).offset(by: 24)
            .insertStacked {
                partOneButton
                partTwoButton
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyPlan()
        partOneButton
            .whenDidTapped { [unowned self] _ in
                self.showInNavigation(for: PartOneViewController())
            }
            .observe(on: .main)
            .retained(by: self)
        partTwoButton
            .whenDidTapped { [unowned self] _ in
                self.showInNavigation(for: TodoListViewController())
            }
            .observe(on: .main)
            .retained(by: self)
    }
    
    func showInNavigation(for viewController: UIViewController) {
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.modalPresentationStyle = .fullScreen
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(dismissPresented)
        )
        self.present(navigation, animated: true)
    }
    
    @objc func dismissPresented() {
        dismiss(animated: true)
    }
    
}

