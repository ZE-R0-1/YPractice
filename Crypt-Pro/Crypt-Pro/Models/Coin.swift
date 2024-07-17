//
//  Coin.swift
//  Crypt-Pro
//
//  Created by USER on 7/15/24.
//

import Foundation

// 서버 응답에서 코인 배열을 디코딩하기 위한 구조체
struct CoinArray: Decodable {
    let data: [Coin]
}

// 개별 코인 데이터를 나타내는 구조체
struct Coin: Codable {
    let id: Int             // 코인의 고유 ID
    let name: String        // 코인의 이름
    let maxSupply: Int?     // 최대 공급량, 선택적 속성
    let rank: Int           // 코인의 순위
    let pricingData: PricingData  // 가격 데이터를 포함하는 속성
    
    // 코인의 로고 URL을 생성하는 계산 속성
    var logoURL: URL? {
        return URL(string: "https://s2.coinmarketcap.com/static/img/coins/200x200/\(id).png")
    }
    
    // JSON 키와 매핑하기 위한 열거형
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case maxSupply = "max_supply"
        case rank = "cmc_rank"
        case pricingData = "quote"
    }
}

// 코인의 가격 데이터를 나타내는 구조체
struct PricingData: Codable {
    let CAD: CAD  // 캐나다 달러(CAD)로 표현된 가격 데이터
}

// 캐나다 달러(CAD)로 표현된 가격 데이터를 나타내는 구조체
struct CAD: Codable {
    let price: Double       // 코인의 가격
    let market_cap: Double  // 코인의 시가 총액
}
