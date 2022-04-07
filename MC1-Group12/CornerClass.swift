//
//  CornerClass.swift
//  MC1-Group12
//
//  Created by Rizki Faris on 07/04/22.
//

import UIKit

@IBDesignable
class CornerClass: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
       didSet {
           layer.cornerRadius = cornerRadius
           layer.masksToBounds = cornerRadius > 0
       }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
       didSet {
           layer.borderWidth = borderWidth
       }
    }
    @IBInspectable var borderColor: UIColor? {
       didSet {
           layer.borderColor = borderColor?.cgColor
       }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
            setUpView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
            setUpView()
    }
    
    func setUpView() {
        let theLayer = self.layer
        theLayer.cornerRadius = self.cornerRadius
        self.clipsToBounds = true
    }
}
