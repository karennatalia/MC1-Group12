//
//  GradientViewClass.swift
//  MC1-Group12
//
//  Created by Rizki Faris on 07/04/22.
//

import UIKit

@IBDesignable
class GradientViewClass: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBInspectable var FirstColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    @IBInspectable var SecondColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override class var layerClass: AnyClass {
            get {
                return CAGradientLayer.self
            }
        }
    
    func updateView() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [ FirstColor.cgColor, SecondColor.cgColor ]
    }
}
