//
//  CoinService.swift
//  Crypt-Pro
//
//  Created by USER on 7/16/24.
//

import Foundation

// CoinService에서 발생할 수 있는 에러를 정의하는 열거형
enum CoinServiceError: Error {
    // 서버 에러를 나타내는 케이스
    case serverError(CoinError)
    // 알 수 없는 에러를 나타내는 케이스
    case unknown(String = "An unknown error occurred")
    // 디코딩 에러를 나타내는 케이스
    case decodingError(String = "Error parsing server response")
}

// 코인 데이터를 가져오기 위한 서비스를 정의하는 클래스
class CoinService {
    
    // 코인 데이터를 가져오는 메서드
    static func fetchCoins(with endpoint: Endpoint, completion: @escaping (Result<[Coin], CoinServiceError>)->Void) {
        // 엔드포인트에서 URLRequest를 생성
        guard let request = endpoint.request else { return }
        
        // URLSession을 사용하여 데이터 요청을 수행
        URLSession.shared.dataTask(with: request) { data, resp, error in
            // 요청 중 에러가 발생하면 알 수 없는 에러로 완료 클로저 호출
            if let error = error {
                completion(.failure(.unknown(error.localizedDescription)))
                return
            }
            
            // 서버 응답이 200이 아닌 경우 서버 에러로 완료 클로저 호출
            if let resp = resp as? HTTPURLResponse, resp.statusCode != 200 {
                do {
                    // 서버로부터 받은 에러 메시지를 디코딩
                    let coinError = try JSONDecoder().decode(CoinError.self, from: data ?? Data())
                    completion(.failure(.serverError(coinError)))
                } catch let err {
                    // 디코딩 중 에러가 발생하면 알 수 없는 에러로 완료 클로저 호출
                    completion(.failure(.unknown()))
                    print(err.localizedDescription)
                }
            }
            
            // 서버로부터 데이터를 성공적으로 받은 경우
            if let data = data {
                do {
                    // JSON 데이터를 디코딩하여 코인 배열을 생성
                    let decoder = JSONDecoder()
                    let coinData = try decoder.decode(CoinArray.self, from: data)
                    // 성공적으로 디코딩되면 코인 배열을 완료 클로저로 전달
                    completion(.success(coinData.data))
                } catch let err {
                    // 디코딩 중 에러가 발생하면 디코딩 에러로 완료 클로저 호출
                    completion(.failure(.decodingError(err.localizedDescription)))
                    print(err.localizedDescription)
                }
            } else {
                // 데이터가 없는 경우 알 수 없는 에러로 완료 클로저 호출
                completion(.failure(.unknown()))
            }
        }.resume() // 데이터 요청을 시작
    }
}
