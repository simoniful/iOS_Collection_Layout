//
//  BaseView.swift
//  Playground
//
//  Created by Sang hun Lee on 2022/07/06.
//

import UIKit

class BasicView: UIView {
    fileprivate let label = UILabel()
    
    init(text: String? = nil) {
        super.init(frame: .zero)

        backgroundColor = UIColor(red: 0.58, green: 0.78, blue: 0.95, alpha: 1.00)
        layer.borderColor = UIColor(red: 0.37, green: 0.67, blue: 0.94, alpha: 1.00).cgColor
        layer.borderWidth = 2
               
        label.text = text
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.numberOfLines = 0
        label.sizeToFit()
        addSubview(label)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
            
        label.pin.center()
    }
    
    var sizeThatFitsExpectedArea: CGFloat = 40 * 40
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var newSize = CGSize()
        if size.width != CGFloat.greatestFiniteMagnitude {
            newSize.width = size.width
            newSize.height = sizeThatFitsExpectedArea / newSize.width
        } else if size.height != CGFloat.greatestFiniteMagnitude {
            newSize.height = size.height
            newSize.width = sizeThatFitsExpectedArea / newSize.height
        } else {
            newSize.width = 40
            newSize.height = sizeThatFitsExpectedArea / newSize.width
        }
        
        return newSize
    }
}
