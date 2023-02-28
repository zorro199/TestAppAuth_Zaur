//
//  UIView + Ext.swift
//  Auth_Test_App
//
//  Created by Zaur on 26.02.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
}
