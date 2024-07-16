//
//  SceneDelegate.swift
//  Crypt-Pro
//
//  Created by USER on 7/15/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // 윈도우 객체를 저장하는 변수
    var window: UIWindow?

    // 씬이 연결될 때 호출되는 메서드
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // scene이 UIWindowScene으로 변환 가능한지 확인
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // windowScene을 사용하여 UIWindow 객체 생성
        let window = UIWindow(windowScene: windowScene)

        // HomeController를 루트 뷰 컨트롤러로 하는 UINavigationController 생성
        window.rootViewController = UINavigationController(rootViewController: HomeController())

        // window 변수를 초기화하고 윈도우를 보이도록 설정
        self.window = window
        self.window?.makeKeyAndVisible()
    }
}
