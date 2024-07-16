//
//  HomeControllerViewModel.swift
//  Crypt-Pro
//
//  Created by USER on 7/16/24.
//

import Foundation

// HomeController의 ViewModel을 정의하는 클래스
class HomeControllerViewModel {
    
    // 코인이 업데이트되었을 때 호출되는 클로저
    var onCoinsUpdated: (()->Void)?
    // 에러 메시지가 발생했을 때 호출되는 클로저
    var onErrorMessage: ((CoinServiceError)->Void)?
    
    // 코인의 배열을 저장하는 프로퍼티. 값이 변경되면 onCoinsUpdated 클로저가 호출됨
    private(set) var coins: [Coin] = [] {
        didSet {
            self.onCoinsUpdated?()
        }
    }
    
    // 초기화 메서드, 생성 시 코인 데이터를 가져옴
    init() {
        self.fetchCoins()
    }
    
    // 코인 데이터를 가져오는 메서드
    public func fetchCoins() {
        // 코인 데이터를 가져오기 위한 엔드포인트 생성
        let endpoint = Endpoint.fetchCoins()
        
        // CoinService를 통해 코인 데이터를 가져옴
        CoinService.fetchCoins(with: endpoint) { [weak self] result in
            // 결과에 따라 처리
            switch result {
            case .success(let coins):
                // 성공적으로 코인을 가져오면 coins 프로퍼티를 업데이트
                self?.coins = coins
                // 디버그용 출력
                print("DEBUG PRINT:", "\(coins.count) coins fetched.")
                
            case .failure(let error):
                // 에러가 발생하면 onErrorMessage 클로저를 호출하여 에러 메시지 전달
                self?.onErrorMessage?(error)
            }
        }
    }
}
