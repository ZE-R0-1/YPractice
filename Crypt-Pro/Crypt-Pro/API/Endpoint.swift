//
//  Endpoint.swift
//  Crypt-Pro
//
//  Created by USER on 7/16/24.
//

import Foundation

// API의 엔드포인트를 정의하는 열거형
enum Endpoint {
    // 코인 목록을 가져오는 엔드포인트 케이스. 기본 URL은 "/v1/cryptocurrency/listings/latest"
    case fetchCoins(url: String = "/v1/cryptocurrency/listings/latest")
    
    // URLRequest 객체를 생성하는 연산 프로퍼티
    var request: URLRequest? {
        // URL을 확인하고, nil이면 nil 반환
        guard let url = self.url else { return nil }
        // URLRequest 객체 생성
        var request = URLRequest(url: url)
        // HTTP 메서드 설정
        request.httpMethod = self.httpMethod
        // HTTP 바디 설정 (해당 엔드포인트에서는 nil)
        request.httpBody = self.httpBody
        // 헤더 값을 추가
        request.addValues(for: self)
        return request
    }
    
    // URL을 생성하는 연산 프로퍼티
    private var url: URL? {
        // URL 구성 요소 생성
        var components = URLComponents()
        components.scheme = Constants.scheme // 스킴 설정 (예: "https")
        components.host = Constants.baseURL // 호스트 설정 (예: "api.example.com")
        components.port = Constants.port // 포트 설정 (옵션)
        components.path = self.path // 경로 설정
        components.queryItems = self.querItems // 쿼리 아이템 설정
        return components.url // URL 반환
    }
    
    // 엔드포인트의 경로를 반환하는 연산 프로퍼티
    private var path: String {
        // 각 케이스에 따라 경로 설정
        switch self {
        case .fetchCoins(let url):
            return url
        }
    }
    
    // 쿼리 아이템을 반환하는 연산 프로퍼티
    private var querItems: [URLQueryItem] {
        // 각 케이스에 따라 쿼리 아이템 설정
        switch self {
        case .fetchCoins:
            return [
                URLQueryItem(name: "limit", value: "150"),
                URLQueryItem(name: "sort", value: "market_cap"),
                URLQueryItem(name: "convert", value: "CAD"),
                URLQueryItem(name: "aux", value: "cmc_rank, max_supply, circulating_supply, total_supply")
            ]
        }
    }
    
    // HTTP 메서드를 반환하는 연산 프로퍼티
    private var httpMethod: String {
        // 각 케이스에 따라 HTTP 메서드 설정
        switch self {
        case .fetchCoins:
            return HTTP.Method.get.rawValue
        }
    }
    
    // HTTP 바디를 반환하는 연산 프로퍼티
    private var httpBody: Data? {
        // 각 케이스에 따라 HTTP 바디 설정 (해당 엔드포인트에서는 nil)
        switch self {
        case .fetchCoins:
            return nil
        }
    }
}

// URLRequest를 확장하여 엔드포인트에 맞는 헤더 값을 추가하는 메서드
extension URLRequest {
    mutating func addValues(for endpoint: Endpoint) {
        // 각 엔드포인트 케이스에 따라 헤더 값 설정
        switch endpoint {
        case .fetchCoins:
            self.setValue(HTTP.Headers.Value.applicationJson.rawValue, forHTTPHeaderField: HTTP.Headers.Key.contentType.rawValue)
            self.setValue(Constants.API_KEY, forHTTPHeaderField: HTTP.Headers.Key.apiKey.rawValue)
        }
    }
}
