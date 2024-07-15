//
//  Router.swift
//  GroceriesApp
//
//  Created by Everton Carneiro on 01/09/23.
//

import UIKit

final class Router {
    let navigation: UINavigationController
        
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    // 화면 전환과 관련된 메서드
    private func push(controller: UIViewController) {
        navigation.pushViewController(controller, animated: true)
        // 새로운 뷰 컨트롤러를 스택에 추가합니다
    }
    
    private func pop() {
        navigation.popViewController(animated: true)
        // 현재 뷰 컨트롤러를 스택에서 제거합니다
    }
    
    // CategoriesViewController로 이동
    func pushCategoriesViewController() {
        let controller = CategoriesViewController(router: self)
        push(controller: controller)
    }
    
    // CategoryDetailViewController로 이동
    func pushCategoryDetailViewController(with model: CategoryCardModel) {
        let controller = CategoryDetailViewController(model: model)
        push(controller: controller)
    }
}
