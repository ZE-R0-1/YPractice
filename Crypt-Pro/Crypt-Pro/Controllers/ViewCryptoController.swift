//
//  CryptoViewController.swift
//  Crypt-Pro
//
//  Created by USER on 7/16/24.
//

import UIKit

import UIKit

class ViewCryptoController: UIViewController {
    
    // MARK: - Variables
    // ViewModel 인스턴스: 이 뷰 컨트롤러의 데이터를 처리
    let viewModel: ViewCryptoControllerViewModel
    
    // MARK: - UI Components
    // UIScrollView: 콘텐츠를 스크롤할 수 있는 뷰
    private let scrollView: UIScrollView = {
       let sv = UIScrollView()
        return sv
    }()
    
    // 콘텐츠를 담는 UIView
    private let contentView: UIView = {
       let view = UIView()
        return view
    }()
    
    // 코인 로고 이미지 뷰
    private let coinLogo: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "questionmark")  // 기본 이미지
        iv.tintColor = .label  // 텍스트 색상 설정
        return iv
    }()
    
    // 랭크를 표시할 레이블
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label  // 텍스트 색상 설정
        label.textAlignment = .center  // 텍스트 중앙 정렬
        label.font = .systemFont(ofSize: 20, weight: .semibold)  // 폰트 설정
        label.text = "Error"  // 기본 텍스트
        return label
    }()
    
    // 가격을 표시할 레이블
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label  // 텍스트 색상 설정
        label.textAlignment = .center  // 텍스트 중앙 정렬
        label.font = .systemFont(ofSize: 20, weight: .semibold)  // 폰트 설정
        label.text = "Error"  // 기본 텍스트
        return label
    }()
    
    // 시가총액을 표시할 레이블
    private let marketCapLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label  // 텍스트 색상 설정
        label.textAlignment = .center  // 텍스트 중앙 정렬
        label.font = .systemFont(ofSize: 20, weight: .semibold)  // 폰트 설정
        label.text = "Error"  // 기본 텍스트
        return label
    }()
    
    // 최대 공급량을 표시할 레이블
    private let maxSupplyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label  // 텍스트 색상 설정
        label.textAlignment = .center  // 텍스트 중앙 정렬
        label.font = .systemFont(ofSize: 20, weight: .semibold)  // 폰트 설정
        label.numberOfLines = 500  // 텍스트 줄 수 설정 (비워두면 무제한)
        return label
    }()
    
    // 세로 스택 뷰: `rankLabel`, `priceLabel`, `marketCapLabel`, `maxSupplyLabel`을 세로로 나열
    private lazy var vStack: UIStackView = {
       let vStack = UIStackView(arrangedSubviews: [rankLabel, priceLabel, marketCapLabel, maxSupplyLabel])
        vStack.axis = .vertical  // 세로 방향으로 배치
        vStack.spacing = 12  // 항목 간의 간격
        vStack.distribution = .fill  // 스택 뷰의 항목이 스택 뷰의 공간을 채우도록 설정
        vStack.alignment = .center  // 항목을 중앙 정렬
        return vStack
    }()
    
    // MARK: - LifeCycle
    // 초기화 메소드: ViewModel을 주입받아 초기화
    init(_ viewModel: ViewCryptoControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    // NSCoder를 통한 초기화는 사용하지 않음
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 뷰가 로드될 때 호출되는 메소드
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()  // UI 설정
        
        // 배경 색상 설정
        self.view.backgroundColor = .systemBackground
        // 내비게이션 바의 제목을 코인 이름으로 설정
        self.navigationItem.title = self.viewModel.coin.name
        // 내비게이션 바의 뒤로 가기 버튼을 설정
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: nil, action: nil)
        
        // ViewModel에서 가져온 정보를 UI 레이블에 설정
        self.rankLabel.text = self.viewModel.rankLabel
        self.priceLabel.text = self.viewModel.priceLabel
        self.marketCapLabel.text = self.viewModel.marketCapLabel
        self.maxSupplyLabel.text = self.viewModel.maxSupplyLabel
        
        // ViewModel의 `onImageLoaded` 클로저 설정: 로고 이미지가 로드되면 이미지 뷰에 설정
        self.viewModel.onImageLoaded = { [weak self] logoImage in
            DispatchQueue.main.async {
                self?.coinLogo.image = logoImage
            }
        }
    }
    
    // MARK: - UI Setup
    // UI 요소를 설정하는 메소드
    private func setupUI() {
        self.view.addSubview(scrollView)  // 스크롤 뷰를 현재 뷰에 추가
        self.scrollView.addSubview(contentView)  // 콘텐츠 뷰를 스크롤 뷰에 추가
        self.contentView.addSubview(coinLogo)  // 코인 로고를 콘텐츠 뷰에 추가
        self.contentView.addSubview(vStack)  // 스택 뷰를 콘텐츠 뷰에 추가
        
        // 오토레이아웃 제약 조건 설정
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        coinLogo.translatesAutoresizingMaskIntoConstraints = false
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        // 콘텐츠 뷰의 높이 제약 조건을 스크롤 뷰의 높이와 같게 설정
        let height = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        height.priority = UILayoutPriority(1)  // 낮은 우선 순위를 설정하여 동적 높이 조절을 가능하게 함
        height.isActive = true
        
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
            coinLogo.heightAnchor.constraint(equalToConstant: 200),  // 로고 이미지의 높이 설정
            
            vStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            vStack.topAnchor.constraint(equalTo: coinLogo.bottomAnchor, constant: 20),
            vStack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            vStack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),  // 스택 뷰의 아래쪽이 콘텐츠 뷰의 아래쪽과 맞춰짐
        ])
    }
}
