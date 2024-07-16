//
//  CryptoViewControllerViewModel.swift
//  Crypt-Pro
//
//  Created by USER on 7/16/24.
//

import UIKit

class CryptoViewControllerViewModel {

    // 이미지를 로드할 때 호출될 클로저
    var onImageLoaded: ((UIImage?)->Void)?

    // Coin 데이터를 저장하는 변수
    let coin: Coin

    // 초기화 메서드
    init(_ coin: Coin) {
        self.coin = coin
        self.loadImage() // 초기화 시 이미지를 로드
    }

    // 이미지를 비동기적으로 로드하는 메서드
    private func loadImage() {
        // 글로벌 큐에서 비동기 작업 수행
        DispatchQueue.global().async { [weak self] in
            // logoURL에서 데이터를 가져와 UIImage로 변환 후 onImageLoaded 클로저 호출
            if let logoURL = self?.coin.logoURL,
               let imageData = try? Data(contentsOf: logoURL),
               let logoImage = UIImage(data: imageData) {
                self?.onImageLoaded?(logoImage)
            }
        }
    }

    // 코인의 순위를 문자열로 반환
    var rankLabel: String {
        return "Rank: \(self.coin.rank)"
    }

    // 코인의 가격을 문자열로 반환
    var priceLabel: String {
        return "Price: $\(self.coin.pricingData.CAD.price) CAD"
    }

    // 코인의 시가총액을 문자열로 반환
    var marketCapLabel: String {
        return "Market Cap: $\(self.coin.pricingData.CAD.market_cap) CAD"
    }

    // 코인의 최대 공급량을 문자열로 반환
    var maxSupplyLabel: String {
        if let maxSupply = self.coin.maxSupply {
            return "Max Supply: \(maxSupply)"
        } else {
            // 최대 공급량이 없는 경우, 테스트를 위해 긴 문자열 반환
            return "123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123"
        }
    }
}
