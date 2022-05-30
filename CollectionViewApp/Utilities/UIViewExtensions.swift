//
//  UIViewExtensions.swift
//  CollectionViewApp
//
//  Created by Preety Singh on 28/05/22.
//

import Foundation
import UIKit

extension UIView {
    /// Aligns view to super view with frames same as superView
    /// - Parameters:
    ///    - superView: Super View to which current view needs to be aligned
    func alignToSuperView(superView: UIView) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.topAnchor),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor)
        ])
    }
    /// Aligns view to center of super view
    /// - Parameters:
    ///    - superView: Super View to which current view needs to be aligned
    func alignToCentre(superView: UIView) {
        NSLayoutConstraint.activate([
            centerYAnchor.constraint(equalTo: superView.centerYAnchor),
            centerXAnchor.constraint(equalTo: superView.centerXAnchor)
        ])
    }
    /// Aligns view to center of super view with margins
    /// - Parameters:
    ///    - superView: Super View to which current view needs to be aligned
    ///    - withMargin: Margin to be left from all sides of super view 
    func alignToCentre(superView: UIView, withMargin: CGFloat) {
        NSLayoutConstraint.activate([
            centerYAnchor.constraint(equalTo: superView.centerYAnchor),
            centerXAnchor.constraint(equalTo: superView.centerXAnchor),
            topAnchor.constraint(equalTo: superView.topAnchor, constant: withMargin),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: withMargin),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -withMargin),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -withMargin)
        ])
    }
}
