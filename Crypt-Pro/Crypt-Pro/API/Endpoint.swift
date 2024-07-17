//
//  Endpoint.swift
//  Crypt-Pro
//
//  Created by USER on 7/16/24.
//

import Foundation

// API 엔드포인트를 나타내는 열거형
enum Endpoint {
    
    // 코인 데이터를 가져오는 엔드포인트, 기본 URL 제공
    case fetchCoins(url: String = "/v1/cryptocurrency/listings/latest")
    
    // URLRequest를 생성하는 계산 속성
    var request: URLRequest? {
        // URL 생성이 실패하면 nil 반환
        guard let url = self.url else { return nil }
        // URL을 사용해 URLRequest 생성
        var request = URLRequest(url: url)
        // HTTP 메소드 설정
        request.httpMethod = self.httpMethod
        // HTTP 바디 설정 (현재는 nil)
        request.httpBody = self.httpBody
        // 필요한 헤더 값을 추가
        request.addValues(for: self)
        return request
    }
    
    // URL을 생성하는 계산 속성
    private var url: URL? {
        var components = URLComponents()
        // URL 구성 요소 설정
        components.scheme = Constants.scheme
        components.host = Constants.baseURL
        components.port = Constants.port
        components.path = self.path
        components.queryItems = self.queryItems
        return components.url
    }
    
    // 엔드포인트의 경로를 반환하는 계산 속성
    private var path: String {
        switch self {
        case .fetchCoins(let url):
            return url
        }
    }
    
    // 엔드포인트의 쿼리 파라미터를 반환하는 계산 속성
    private var queryItems: [URLQueryItem] {
        switch self {
        case .fetchCoins:
            return [
                // 필요한 쿼리 파라미터들 설정
                URLQueryItem(name: "limit", value: "150"),
                URLQueryItem(name: "sort", value: "market_cap"),
                URLQueryItem(name: "convert", value: "CAD"),
                URLQueryItem(name: "aux", value: "cmc_rank,max_supply,circulating_supply,total_supply")
            ]
        }
    }
    
    // HTTP 메소드를 반환하는 계산 속성
    private var httpMethod: String {
        switch self {
        case .fetchCoins:
            return HTTP.Method.get.rawValue
        }
    }
    
    // HTTP 바디를 반환하는 계산 속성 (현재는 nil)
    private var httpBody: Data? {
        switch self {
        case .fetchCoins:
            return nil
        }
    }
}

// URLRequest 확장에서 헤더 값을 추가하는 메소드 정의
extension URLRequest {
    
    mutating func addValues(for endpoint: Endpoint) {
        switch endpoint {
        case .fetchCoins:
            // Content-Type 헤더 추가
            self.setValue(HTTP.Headers.Value.applicationJson.rawValue, forHTTPHeaderField: HTTP.Headers.Key.contentType.rawValue)
            // API 키 헤더 추가
            self.setValue(Constants.API_KEY, forHTTPHeaderField: HTTP.Headers.Key.apiKey.rawValue)
        }
    }
}
