//
//  CheckButton.swift
//  DeclarativeUIKit
//
//  Created by Nayanda Haberty on 02/07/22.
//

import Foundation
import UIKit
import Pharos

class CheckButton: UIButton, ObjectRetainer {
    
    @Subject var checked: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        didInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        didInit()
    }
    
    private func didInit() {
        whenDidTapped { [unowned self] _ in
            self.checked.toggle()
        }
        .observe(on: .main)
        .retained(by: self)
        
        $checked.mapped { checked in
            checked ? UIImage(systemName: "checkmark.circle"): UIImage(systemName: "circle")
        }.whenDidSet { [unowned self] changes in
            self.setImage(changes.new, for: .normal)
        }.retained(by: self)
            .fire()
    }
}
