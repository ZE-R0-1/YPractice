//
//  Coin.swift
//  Crypt-Pro
//
//  Created by USER on 7/15/24.
//

import Foundation // Foundation 프레임워크를 임포트하여 URL과 같은 기본 데이터 타입들을 사용할 수 있게 합니다.

struct Coin {
    let id: Int // 코인의 고유 식별자를 나타내는 정수형 프로퍼티
    let name: String // 코인의 이름을 나타내는 문자열형 프로퍼티
    let max_supply: Int? // 코인의 최대 공급량을 나타내는 정수형 프로퍼티, nil일 수 있음
    let cmc_rank: Int // 코인의 CoinMarketCap 순위를 나타내는 정수형 프로퍼티
    let quote: Quote // 코인의 가격 정보를 담고 있는 Quote 구조체 인스턴스를 나타내는 프로퍼티

    // 코인의 로고 URL을 반환하는 계산형 프로퍼티, URL 객체를 옵셔널로 반환
    var logoURL: URL? {
        return URL(string: "https://s2.coinmarketcap.com/static/img/coins/200x200/1.png")
    }

    // Quote 구조체 정의
    struct Quote {
        let CAD: CAD // CAD 통화에 대한 가격 정보를 담고 있는 CAD 구조체 인스턴스를 나타내는 프로퍼티

        // CAD 구조체 정의
        struct CAD {
            let price: Double // 코인의 가격을 나타내는 실수형 프로퍼티
            let market_cap: Double // 코인의 시가총액을 나타내는 실수형 프로퍼티
        }
    }
}

// Coin 구조체의 익스텐션을 사용하여 추가 기능을 정의
extension Coin {
    // Coin 구조체 배열을 반환하는 정적 메서드
    public static func getMockArray() -> [Coin] {
        return [
            // Bitcoin에 대한 Coin 인스턴스 생성 및 배열에 추가
            Coin(id: 1, name: "Bitcoin", max_supply: 200, cmc_rank: 1, quote: Quote(CAD: Quote.CAD(price: 50000, market_cap: 1_000_000))),
            // Ethereum에 대한 Coin 인스턴스 생성 및 배열에 추가
            Coin(id: 2, name: "Ethereum", max_supply: nil, cmc_rank: 2, quote: Quote(CAD: Quote.CAD(price: 2000, market_cap: 500_000))),
            // Monero에 대한 Coin 인스턴스 생성 및 배열에 추가
            Coin(id: 3, name: "Monero", max_supply: nil, cmc_rank: 3, quote: Quote(CAD: Quote.CAD(price: 200, market_cap: 250_000)))
        ]
    }
}
