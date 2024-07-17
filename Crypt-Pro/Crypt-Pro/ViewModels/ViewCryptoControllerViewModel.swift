//
//  CryptoViewControllerViewModel.swift
//  Crypt-Pro
//
//  Created by USER on 7/16/24.
//

import UIKit

class ViewCryptoControllerViewModel {
    
    // MARK: - Variables
    // 코인 데이터를 저장하는 변수
    let coin: Coin
    
    // MARK: - Initializer
    // 초기화 메소드, 코인 데이터를 설정하고 이미지를 로드함
    init(_ coin: Coin) {
        self.coin = coin
    }
    
    // MARK: - Computed Properties
    // 코인의 순위를 나타내는 문자열
    var rankLabel: String {
        return "Rank: \(self.coin.rank)"
    }
    
    // 코인의 가격을 나타내는 문자열
    var priceLabel: String {
        return "Price: $\(self.coin.pricingData.CAD.price) CAD"
    }
    
    // 코인의 시가 총액을 나타내는 문자열
    var marketCapLabel: String {
        return "Market Cap: $\(self.coin.pricingData.CAD.market_cap) CAD"
    }
    
    // 코인의 최대 공급량을 나타내는 문자열, 최대 공급량이 없는 경우 기본 메시지 반환
    var maxSupplyLabel: String {
        if let maxSupply = self.coin.maxSupply {
            return "Max Supply: \(maxSupply)"
        } else {
            // 최대 공급량이 없는 경우 기본 메시지 반환
            return "Max Supply: Not Available"
        }
    }
}
