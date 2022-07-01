//
//  PartOneViewController.swift
//  DeclarativeUIKit
//
//  Created by Nayanda Haberty on 02/07/22.
//

import Foundation
import Draftsman
import UIKit

class PartOneViewController: UIViewController, Planned {
    
    lazy var customField: CustomField = CustomField()
    
    @LayoutPlan
    var viewPlan: ViewPlan {
        UIStackView(axis: .vertical, alignment: .fill, spacing: 8).drf
            .horizontal.equal(with: .safeArea).offset(by: 24)
            .top.moreThan(with: .safeArea).offset(by: 24)
            .bottom.moreThan(to: customField.drf.top)
            .centerY.lessThan(with: .safeArea)
            .insertStacked {
                centeredLabel(text: "Hello World", font: .boldSystemFont(ofSize: 24))
                centeredLabel(text: "Lorem ipsum dolor sit amet", font: .systemFont(ofSize: 18))
                centeredLabel(text: myVeryLongText, font: .systemFont(ofSize: 12))
            }
        customField.drf
            .horizontal.equal(with: .parent)
            .bottom.equal(with: .top(of: .keyboard))
    }
    
    @LayoutPlan
    func centeredLabel(text: String, font: UIFont) -> ViewPlan {
        UILabel(text: text, font: font).drf
            .resistVerticalCompression(.defaultHigh)
            .builder
            .numberOfLines(0)
            .textAlignment(.center)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        applyPlan()
    }

}
