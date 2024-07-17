//
//  HomeControllerViewModel.swift
//  Crypt-Pro
//
//  Created by USER on 7/16/24.
//

import Foundation

import UIKit

class HomeControllerViewModel {
    
    // MARK: - Callbacks
    // 코인 데이터가 업데이트되었을 때 호출될 클로저
    var onCoinsUpdated: (()->Void)?
    // 에러 메시지가 발생했을 때 호출될 클로저
    var onErrorMessage: ((CoinServiceError)->Void)?
    
    // MARK: - Variables
    // 코인 데이터를 저장하는 변수, 데이터가 변경될 때마다 `onCoinsUpdated` 클로저 호출
    private(set) var coins: [Coin] = [] {
        didSet {
            self.onCoinsUpdated?() // 코인 데이터가 변경되었으므로 UI 업데이트 필요
        }
    }
    
    // MARK: - Initializer
    // 초기화 메소드, 코인 데이터를 가져오는 메소드 호출
    init() {
        self.fetchCoins()
        
        // 테스트 코드 주석
        // self.coins.insert(Coin(id: <#T##Int#>, name: <#T##String#>, maxSupply: <#T##Int?#>, rank: <#T##Int#>, pricingData: <#T##PricingData#>, logoURL: <#T##URL?#>), at: <#T##Int#>)
    }
    
    // MARK: - Data Fetching
    // 코인 데이터를 서버에서 가져오는 메소드
    public func fetchCoins() {
        // `Endpoint.fetchCoins`를 사용해 코인 데이터를 가져오는 요청 생성
        let endpoint = Endpoint.fetchCoins()
        
        // `CoinService`를 사용해 코인 데이터를 비동기적으로 가져옴
        CoinService.fetchCoins(with: endpoint) { [weak self] result in
            switch result {
            case .success(let coins):
                // 성공적으로 코인 데이터를 가져온 경우
                self?.coins = coins
                print("DEBUG PRINT:", "\(coins.count) coins fetched.") // 디버깅용 출력
                
            case .failure(let error):
                // 에러가 발생한 경우, 에러 메시지를 전달
                self?.onErrorMessage?(error)
            }
        }
    }
}
