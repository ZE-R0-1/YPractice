//
//  Coin.swift
//  Crypt-Pro
//
//  Created by USER on 7/15/24.
//

import Foundation

struct CoinArray: Decodable {
    let data: [Coin]
}

struct Coin: Decodable {
    let id: Int // 코인의 고유 식별자를 나타내는 정수형 프로퍼티
    let name: String // 코인의 이름을 나타내는 문자열형 프로퍼티
    let maxSupply: Int? // 코인의 최대 공급량을 나타내는 정수형 프로퍼티, nil일 수 있음
    let rank: Int // 코인의 CoinMarketCap 순위를 나타내는 정수형 프로퍼티
    let pricingData: PricingData

    // 코인의 로고 URL을 반환하는 계산형 프로퍼티, URL 객체를 옵셔널로 반환
    var logoURL: URL? {
        return URL(string: "https://s2.coinmarketcap.com/static/img/coins/200x200/\(id).png")
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case maxSupply = "max_supply"
        case rank = "cmc_rank"
        case pricingData = "quote"
    }
}

// Quote 구조체 정의
struct PricingData: Decodable {
    let CAD: CAD // CAD 통화에 대한 가격 정보를 담고 있는 CAD 구조체 인스턴스를 나타내는 프로퍼티
}

// CAD 구조체 정의
struct CAD: Decodable {
    let price: Double // 코인의 가격을 나타내는 실수형 프로퍼티
    let market_cap: Double // 코인의 시가총액을 나타내는 실수형 프로퍼티
}
