//
//  CryptoViewController.swift
//  Crypt-Pro
//
//  Created by USER on 7/16/24.
//

import UIKit

class ViewCryptoController: UIViewController {
    
    // MARK: - Variables
    let viewModel: ViewCryptoControllerViewModel  // 뷰 모델 변수
    
    // MARK: - UI Components
    private let scrollView: UIScrollView = {  // 스크롤 뷰 설정
       let sv = UIScrollView()
        return sv
    }()
    
    private let contentView: UIView = {  // 컨텐츠 뷰 설정
       let view = UIView()
        return view
    }()
    
    private let coinLogo: UIImageView = {  // 코인 로고 이미지 뷰 설정
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "questionmark")
        iv.tintColor = .label
        return iv
    }()
    
    private let rankLabel: UILabel = {  // 순위 라벨 설정
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "Error"
        return label
    }()
    
    private let priceLabel: UILabel = {  // 가격 라벨 설정
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "Error"
        return label
    }()
    
    private let marketCapLabel: UILabel = {  // 시가 총액 라벨 설정
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "Error"
        return label
    }()
    
    private let maxSupplyLabel: UILabel = {  // 최대 공급량 라벨 설정
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 500
        return label
    }()
    
    private lazy var vStack: UIStackView = {  // 수직 스택 뷰 설정
       let vStack = UIStackView(arrangedSubviews: [rankLabel, priceLabel, marketCapLabel, maxSupplyLabel])
        vStack.axis = .vertical
        vStack.spacing = 12
        vStack.distribution = .fill
        vStack.alignment = .center
        return vStack
    }()
    
    // MARK: - LifeCycle
    init(_ viewModel: ViewCryptoControllerViewModel) {  // 뷰 모델 초기화
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()  // UI 설정
        
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = self.viewModel.coin.name  // 네비게이션 타이틀 설정
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: nil, action: nil)
        
        self.rankLabel.text = self.viewModel.rankLabel  // 순위 라벨 텍스트 설정
        self.priceLabel.text = self.viewModel.priceLabel  // 가격 라벨 텍스트 설정
        self.marketCapLabel.text = self.viewModel.marketCapLabel  // 시가 총액 라벨 텍스트 설정
        self.maxSupplyLabel.text = self.viewModel.maxSupplyLabel  // 최대 공급량 라벨 텍스트 설정
        
        self.coinLogo.sd_setImage(with: self.viewModel.coin.logoURL)  // 코인 로고 이미지 설정
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.addSubview(scrollView)  // 스크롤 뷰 추가
        self.scrollView.addSubview(contentView)  // 컨텐츠 뷰 추가
        self.contentView.addSubview(coinLogo)  // 코인 로고 이미지 뷰 추가
        self.contentView.addSubview(vStack)  // 수직 스택 뷰 추가
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        coinLogo.translatesAutoresizingMaskIntoConstraints = false
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        let height = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        height.priority = UILayoutPriority(1)
        height.isActive = true
        
        NSLayoutConstraint.activate([  // 오토레이아웃 설정
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            scrollView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
        
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            coinLogo.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            coinLogo.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            coinLogo.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            coinLogo.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            coinLogo.heightAnchor.constraint(equalToConstant: 200),
            
            vStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            vStack.topAnchor.constraint(equalTo: coinLogo.bottomAnchor, constant: 20),
            vStack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            vStack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
    }
}
