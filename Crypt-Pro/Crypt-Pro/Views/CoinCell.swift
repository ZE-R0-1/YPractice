//
//  CoinCell.swift
//  Crypt-Pro
//
//  Created by USER on 7/15/24.
//

import UIKit

class CoinCell: UITableViewCell {
    
    static let identifier = "CoinCell" // 셀의 재사용 식별자를 정의

    private(set) var coin: Coin! // Coin 데이터를 저장하는 변수로, 외부에서는 읽기만 가능

    private let coinLogo: UIImageView = {
        let iv = UIImageView() // UIImageView 인스턴스를 생성
        iv.contentMode = .scaleAspectFit // 이미지 뷰의 콘텐츠 모드를 설정
        iv.image = UIImage(systemName: "questionmark") // 기본 이미지를 설정
        iv.tintColor = .black // 이미지 틴트 색상을 설정
        return iv // 이미지 뷰를 반환
    }()
    
    private let coinName: UILabel = {
        let label = UILabel() // UILabel 인스턴스를 생성
        label.textColor = .label // 텍스트 색상을 시스템 기본 색상으로 설정
        label.textAlignment = .left // 텍스트 정렬을 왼쪽으로 설정
        label.font = .systemFont(ofSize: 22, weight: .semibold) // 폰트 크기와 굵기를 설정
        label.text = "Error" // 기본 텍스트를 설정
        return label // 레이블을 반환
    }()

    // 초기화 메서드
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI() // UI 설정 메서드 호출
    }
    
    // NSCoder를 사용한 초기화는 지원하지 않음
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Coin 데이터를 사용하여 셀을 구성하는 메서드
    public func configure(with coin: Coin) {
        self.coin = coin // 코인 데이터를 설정
        
        self.coinName.text = coin.name // 코인 이름을 레이블에 설정
        
        // 코인 로고 URL로부터 데이터를 가져옴
        let imageData = try? Data(contentsOf: self.coin.logoURL!)
        if let imageData { // 데이터가 유효하면
            // 메인 스레드에서 이미지 뷰에 이미지 설정
            DispatchQueue.main.async { [weak self] in
                self?.coinLogo.image = UIImage(data: imageData)
            }
        }
    }

    // UI 요소를 설정하는 메서드
    private func setupUI() {
        self.addSubview(coinLogo) // 이미지 뷰를 셀에 추가
        self.addSubview(coinName) // 레이블을 셀에 추가
        
        coinLogo.translatesAutoresizingMaskIntoConstraints = false // 자동 제약을 비활성화
        coinName.translatesAutoresizingMaskIntoConstraints = false // 자동 제약을 비활성화
        
        // 제약 조건을 설정
        NSLayoutConstraint.activate([
            coinLogo.centerYAnchor.constraint(equalTo: self.centerYAnchor), // 이미지 뷰의 수직 중심을 셀의 수직 중심에 맞춤
            coinLogo.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor), // 이미지 뷰의 왼쪽을 셀의 레이아웃 여백에 맞춤
            coinLogo.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75), // 이미지 뷰의 너비를 셀 높이의 75%로 설정
            coinLogo.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75), // 이미지 뷰의 높이를 셀 높이의 75%로 설정
            
            coinName.leadingAnchor.constraint(equalTo: coinLogo.trailingAnchor, constant: 16), // 레이블의 왼쪽을 이미지 뷰의 오른쪽에 16 포인트 간격으로 맞춤
            coinName.centerYAnchor.constraint(equalTo: self.centerYAnchor) // 레이블의 수직 중심을 셀의 수직 중심에 맞춤
        ])
    }
}
