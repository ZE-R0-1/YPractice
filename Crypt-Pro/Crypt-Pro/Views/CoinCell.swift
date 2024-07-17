//
//  CoinCell.swift
//  Crypt-Pro
//
//  Created by USER on 7/15/24.
//

import UIKit
import SDWebImage


class CoinCell: UITableViewCell {
    
    // 셀의 재사용 식별자
    static let identifier = "CoinCell"
    
    // MARK: - Variables
    // 코인 데이터를 저장하는 변수, 외부에서는 읽기만 가능
    private(set) var coin: Coin!
    
    // MARK: - UI Components
    // 코인 로고를 표시하는 UIImageView
    private let coinLogo: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "questionmark")
        iv.tintColor = .black
        return iv
    }()
    
    // 코인 이름을 표시하는 UILabel
    private let coinName: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.text = "Error"
        return label
    }()
    
    // MARK: - Lifecycle
    // 초기화 메소드
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    // NSCoder를 통한 초기화는 사용하지 않음
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 코인 데이터를 설정하고 UI를 업데이트하는 메소드
    public func configure(with coin: Coin) {
        self.coin = coin
        
        // 코인 이름을 설정
        self.coinName.text = coin.name
        self.coinLogo.sd_setImage(with: coin.logoURL)
        
    }
    
    // 셀이 재사용될 때 호출되는 메소드, 초기 상태로 되돌림
    override func prepareForReuse() {
        super.prepareForReuse()
        self.coinName.text = nil
        self.coinLogo.image = nil
    }
    
    // MARK: - UI Setup
    // UI 요소를 설정하는 메소드
    private func setupUI() {
        // 코인 로고와 이름 라벨을 셀에 추가
        self.addSubview(coinLogo)
        self.addSubview(coinName)
        
        // 오토레이아웃 설정을 위한 준비
        coinLogo.translatesAutoresizingMaskIntoConstraints = false
        coinName.translatesAutoresizingMaskIntoConstraints = false
        
        // 오토레이아웃 제약 조건 설정
        NSLayoutConstraint.activate([
            coinLogo.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            coinLogo.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            coinLogo.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
            coinLogo.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
            
            coinName.leadingAnchor.constraint(equalTo: coinLogo.trailingAnchor, constant: 16),
            coinName.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}
