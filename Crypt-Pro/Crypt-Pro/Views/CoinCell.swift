//
//  CoinCell.swift
//  Crypt-Pro
//
//  Created by USER on 7/15/24.
//

import UIKit
import SDWebImage

class CoinCell: UITableViewCell {
    
    // 셀 식별자
    static let identifier = "CoinCell"
    
    // MARK: - Variables
    private(set) var coin: Coin!
    
    // MARK: - UI Components
    
    // 코인 로고 이미지 뷰
    private let coinLogo: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "questionmark")  // 기본 이미지
        iv.tintColor = .black  // 이미지 틴트 색상 설정
        return iv
    }()
    
    // 코인 이름 레이블
    private let coinName: UILabel = {
        let label = UILabel()
        label.textColor = .label  // 텍스트 색상 설정
        label.textAlignment = .left  // 텍스트 왼쪽 정렬
        label.font = .systemFont(ofSize: 22, weight: .semibold)  // 폰트 설정
        label.text = "Error"  // 기본 텍스트
        return label
    }()
    
    // MARK: - Lifecycle
    // 초기화 메서드
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()  // UI 설정
    }
    
    // NSCoder를 통한 초기화는 사용하지 않음
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 코인 데이터를 사용하여 셀을 구성하는 메서드
    public func configure(with coin: Coin) {
        self.coin = coin
        
        self.coinName.text = coin.name
        self.coinLogo.sd_setImage(with: coin.logoURL)  // SDWebImage를 사용하여 비동기적으로 이미지 로드
    }
    
    // 재사용을 대비한 준비 메서드
    override func prepareForReuse() {
        super.prepareForReuse()
        self.coinName.text = nil  // 이전 텍스트 제거
        self.coinLogo.image = nil  // 이전 이미지 제거
    }
    
    // MARK: - UI Setup
    // UI 요소를 설정하는 메서드
    private func setupUI() {
        self.addSubview(coinLogo)  // 코인 로고 이미지 뷰 추가
        self.addSubview(coinName)  // 코인 이름 레이블 추가
        
        coinLogo.translatesAutoresizingMaskIntoConstraints = false
        coinName.translatesAutoresizingMaskIntoConstraints = false
        
        // 오토레이아웃 제약 조건 설정
        NSLayoutConstraint.activate([
            coinLogo.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            coinLogo.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            coinLogo.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),  // 높이의 75% 너비 설정
            coinLogo.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),  // 높이의 75% 높이 설정
            
            coinName.leadingAnchor.constraint(equalTo: coinLogo.trailingAnchor, constant: 16),  // 로고 이미지와 이름 레이블 간의 간격 설정
            coinName.centerYAnchor.constraint(equalTo: self.centerYAnchor),  // 레이블 중앙 정렬
        ])
    }
}
