//
//  CoinError.swift
//  Crypt-Pro
//
//  Created by USER on 7/16/24.
//

import Foundation

// 서버 응답에서 코인 상태를 디코딩하기 위한 구조체
struct CoinStatus: Decodable {
    let status: CoinError  // 코인 에러 상태를 나타내는 속성
}

// 코인 에러 정보를 나타내는 구조체
struct CoinError: Decodable {
    let errorCode: Int       // 에러 코드
    let errorMessage: String // 에러 메시지
    
    // JSON 키와 매핑하기 위한 열거형
    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case errorMessage = "error_message"
    }
}
