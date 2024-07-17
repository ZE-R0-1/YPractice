//
//  CoinService.swift
//  Crypt-Pro
//
//  Created by USER on 7/16/24.
//

import Foundation

// 코인 서비스 에러를 정의하는 열거형
enum CoinServiceError: Error {
    // 서버 에러를 나타내는 케이스
    case serverError(CoinError)
    // 알 수 없는 에러를 나타내는 케이스, 기본 메시지 제공
    case unknown(String = "An unknown error occurred.")
    // 디코딩 에러를 나타내는 케이스, 기본 메시지 제공
    case decodingError(String = "Error parsing server response.")
}

// 코인 데이터를 가져오는 서비스를 제공하는 클래스
class CoinService {
    
    // 코인 데이터를 가져오는 함수, 완료 핸들러를 사용해 결과를 반환
    static func fetchCoins(with endpoint: Endpoint, completion: @escaping (Result<[Coin], CoinServiceError>) -> Void) {
        // 엔드포인트로부터 URLRequest를 생성, 실패 시 함수 종료
        guard let request = endpoint.request else { return }
        
        // URLSession을 사용해 데이터 요청 수행
        URLSession.shared.dataTask(with: request) { data, resp, error in
            // 요청 중 에러 발생 시 알 수 없는 에러로 완료 핸들러 호출
            if let error = error {
                completion(.failure(.unknown(error.localizedDescription)))
                return
            }
            
            // HTTP 응답이 200이 아닌 경우
            if let resp = resp as? HTTPURLResponse, resp.statusCode != 200 {
                do {
                    // 서버에서 보낸 에러 메시지를 디코딩
                    let coinError = try JSONDecoder().decode(CoinError.self, from: data ?? Data())
                    completion(.failure(.serverError(coinError)))
                } catch let err {
                    // 디코딩 실패 시 알 수 없는 에러로 완료 핸들러 호출
                    completion(.failure(.unknown()))
                    print(err.localizedDescription)
                }
            }
            
            // 데이터를 받은 경우
            if let data = data {
                do {
                    // 서버 응답을 디코딩하여 코인 데이터를 파싱
                    let decoder = JSONDecoder()
                    let coinData = try decoder.decode(CoinArray.self, from: data)
                    // 성공적으로 코인 데이터를 파싱한 경우 완료 핸들러 호출
                    completion(.success(coinData.data))
                } catch let err {
                    // 디코딩 실패 시 디코딩 에러로 완료 핸들러 호출
                    completion(.failure(.decodingError()))
                    print(err.localizedDescription)
                }
            } else {
                // 데이터가 없는 경우 알 수 없는 에러로 완료 핸들러 호출
                completion(.failure(.unknown()))
            }
        }.resume() // 데이터 태스크 시작
    }
}
