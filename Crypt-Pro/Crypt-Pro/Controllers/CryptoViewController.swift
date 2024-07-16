//
//  CryptoViewController.swift
//  Crypt-Pro
//
//  Created by USER on 7/16/24.
//

import UIKit

class CryptoViewController: UIViewController {
    let viewModel: CryptoViewControllerViewModel
    
    // MARK: - UI Components
    private let scrollView: UIScrollView = {
        // 스크롤 뷰 생성
        let sv = UIScrollView()
        return sv
    }()
    
    private let contentView: UIView = {
        // 콘텐츠 뷰 생성
        let v = UIView()
        return v
    }()
    
    private let coinLogo: UIImageView = {
        // 이미지 뷰 생성 및 설정
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "questionmark")
        iv.tintColor = .label
        return iv
    }()
    
    private let rankLabel: UILabel = {
        // 순위 레이블 생성 및 설정
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "Error"
        return label
    }()
    
    private let priceLabel: UILabel = {
        // 가격 레이블 생성 및 설정
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "Error"
        return label
    }()
    
    private let marketCapLabel: UILabel = {
        // 시가총액 레이블 생성 및 설정
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "Error"
        return label
    }()
    
    private let maxSupplyLabel: UILabel = {
        // 최대 공급량 레이블 생성 및 설정
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 500
        return label
    }()
    
    private lazy var vStack: UIStackView = {
        // 수직 스택 뷰 생성 및 설정
        let vStack = UIStackView(arrangedSubviews: [rankLabel, priceLabel, marketCapLabel, maxSupplyLabel])
        vStack.axis = .vertical
        vStack.spacing = 12
        vStack.distribution = .fill
        vStack.alignment = .center
        return vStack
    }()
    
    init(_ viewModel: CryptoViewControllerViewModel) {
        // 초기화 메서드
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        // 배경색 설정 및 네비게이션 아이템 설정
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = self.viewModel.coin.name
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: nil, action: nil)
        
        // 레이블 텍스트 설정
        self.rankLabel.text = self.viewModel.rankLabel
        self.priceLabel.text = self.viewModel.priceLabel
        self.marketCapLabel.text = self.viewModel.marketCapLabel
        self.maxSupplyLabel.text = self.viewModel.maxSupplyLabel
        
        // 이미지 로딩 완료 시 이미지 뷰 업데이트
        self.viewModel.onImageLoaded = { [weak self] logoImage in
            DispatchQueue.main.async {
                self?.coinLogo.image = logoImage
            }
        }
    }
    
    private func setupUI() {
        // 서브뷰 추가
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(coinLogo)
        self.contentView.addSubview(vStack)
        
        // 자동 제약 조건 비활성화
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        coinLogo.translatesAutoresizingMaskIntoConstraints = false
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        // 콘텐츠 뷰 높이 설정 (우선 순위 낮음)
        let height = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        height.priority = UILayoutPriority(1)
        height.isActive = true
        
        // 제약 조건 설정
        NSLayoutConstraint.activate([
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
