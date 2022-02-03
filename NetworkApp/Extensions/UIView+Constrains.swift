//
//  UIView+Constrains.swift
//  NetworkApp
//
//  Created by Данил on 03.02.2022.
//

import UIKit

extension UIView {
    func fillSuperView(with constant: CGFloat) {
        guard let superView = superview else {return}
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: constant),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -constant),
            topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor, constant: constant),
            bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor, constant: -constant)
        ])
    }
}

