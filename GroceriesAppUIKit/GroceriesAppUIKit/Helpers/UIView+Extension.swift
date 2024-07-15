//
//  UIView+Extension.swift
//  GroceriesApp
//
//  Created by Everton Carneiro on 30/08/23.
//

import UIKit

extension UIView {
    // 주어진 뷰의 모든 가장자리에 현재 뷰를 맞추는 메서드
    func pinToEdges(of view: UIView, with constant: CGFloat = 0) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: constant),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant)
        ])
    }
    
    // 여러개의 서브뷰를 한 번에 추가하는 메서드
    func addSubViews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}
