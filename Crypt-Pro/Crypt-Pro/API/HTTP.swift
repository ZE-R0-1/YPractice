//
//  HTTP.swift
//  Crypt-Pro
//
//  Created by USER on 7/16/24.
//

import Foundation

// HTTP 관련 열거형을 정의하는 최상위 enum
enum HTTP {
    // HTTP 메서드를 정의하는 중첩된 enum
    enum Method: String {
        // GET 메서드, 문자열 "GET"과 연결
        case get = "GET"
        // POST 메서드, 문자열 "POST"과 연결
        case post = "POST"
    }
    
    // HTTP 헤더를 정의하는 중첩된 enum
    enum Headers {
        // HTTP 헤더 키를 정의하는 중첩된 enum
        enum Key: String {
            // Content-Type 헤더 키, 문자열 "Content-Type"과 연결
            case contentType = "Content-Type"
            // API 키 헤더 키, 문자열 "X-CMC_PRO_API_KEY"와 연결
            case apiKey = "X-CMC_PRO_API_KEY"
        }
        // HTTP 헤더 값을 정의하는 중첩된 enum
        enum Value: String {
            // Content-Type 헤더 값, 문자열 "application/json"과 연결
            case applicationJson = "application/json"
        }
    }
}
