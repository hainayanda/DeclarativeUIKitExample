//
//  TodoListViewController.swift
//  DeclarativeUIKit
//
//  Created by Nayanda Haberty on 02/07/22.
//

import Foundation
import Draftsman
import UIKit

class TodoListViewController: UIViewController, Planned {
    
    @LayoutPlan
    var viewPlan: ViewPlan {
        UIScrollView().drf
            .edges.equal(with: .parent)
            .insert {
                UIStackView(axis: .vertical, distribution: .equalSpacing, spacing: 8).drf
                    .width.equal(with: .parent)
                    .edges.equal(with: .parent)
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyPlan()
    }
}
