//
//  HTTP.swift
//  Crypt-Pro
//
//  Created by USER on 7/16/24.
//

import Foundation

// 네임스페이스 역할을 하는 HTTP 열거형(enum)
enum HTTP {
    
    // HTTP 메소드를 나타내는 열거형, 문자열 타입을 준수
    enum Method: String {
        // GET 메소드
        case get = "GET"
        // POST 메소드
        case post = "POST"
    }
    
    // HTTP 헤더를 나타내는 열거형
    enum Headers {
        
        // HTTP 헤더 키를 나타내는 열거형, 문자열 타입을 준수
        enum Key: String {
            // Content-Type 헤더 키
            case contentType = "Content-Type"
            // API 키 헤더
            case apiKey = "X-CMC_PRO_API_KEY"
        }
        
        // HTTP 헤더 값을 나타내는 열거형, 문자열 타입을 준수
        enum Value: String {
            // application/json 값
            case applicationJson = "application/json"
        }
    }
}

