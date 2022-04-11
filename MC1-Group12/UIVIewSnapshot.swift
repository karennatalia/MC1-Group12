//
//  UIVIewSnapshot.swift
//  MC1-Group12
//
//  Created by Karen Natalia on 12/04/22.
//

import UIKit

extension UIView  {
  func asImage() -> UIImage {
    let renderer = UIGraphicsImageRenderer(bounds: bounds)
      return renderer.image(actions: { rendererContext in
        layer.render(in: rendererContext.cgContext)
    })
  }
}
