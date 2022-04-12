//
//  ReminderHeaderViewController.swift
//  MC1-Group12
//
//  Created by Mohammad Alfarisi on 12/04/22.
//

import UIKit

class ReminderHeaderViewController: UITableViewHeaderFooterView {
    var dayLabel = UILabel()

     override init(reuseIdentifier: String?) {
         super.init(reuseIdentifier: reuseIdentifier)
         configureContents()
     }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
     func configureContents() {

         // Center the image vertically and place it near the leading
         // edge of the view. Constrain its width and height to 50 points.
//         NSLayoutConstraint.activate([
//             // Center the label vertically, and use it to fill the remaining
//             // space in the header view.
//             dayLabel.heightAnchor.constraint(equalToConstant: 0),
//             dayLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
//             dayLabel.trailingAnchor.constraint(equalTo:
//                    contentView.layoutMarginsGuide.trailingAnchor),
//             dayLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
//         ])
     }
}
