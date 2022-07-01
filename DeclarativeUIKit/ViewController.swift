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
                let partOne = PartOneViewController()
                self.present(partOne, animated: true)
            }
            .observe(on: .main)
            .retained(by: self)
    }
    
}

