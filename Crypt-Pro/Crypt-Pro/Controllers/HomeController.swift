//
//  HomeController.swift
//  Crypt-Pro
//
//  Created by USER on 7/15/24.
//

import UIKit

class HomeController: UIViewController {
    
    // MARK: - Variables
    // `HomeControllerViewModel`의 인스턴스, 코인 데이터와 관련된 로직을 처리
    private let viewModel: HomeControllerViewModel
    
    // MARK: - UI Components
    // UITableView를 설정하고 등록하는 코드
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .systemBackground
        // `CoinCell`을 재사용 셀로 등록
        tv.register(CoinCell.self, forCellReuseIdentifier: CoinCell.identifier)
        return tv
    }()
    
    // MARK: - LifeCycle
    // 초기화 메소드, ViewModel을 주입받아 초기화
    init(_ viewModel: HomeControllerViewModel = HomeControllerViewModel()) {
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
        self.setupUI()
        
        // UITableView의 delegate와 dataSource를 설정
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // ViewModel의 `onCoinsUpdated` 클로저 설정: 코인 데이터가 업데이트되면 테이블 뷰를 갱신
        self.viewModel.onCoinsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        // ViewModel의 `onErrorMessage` 클로저 설정: 에러 발생 시 알림을 표시
        self.viewModel.onErrorMessage = { [weak self] error in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                
                switch error {
                case .serverError(let serverError):
                    alert.title = "Server Error \(serverError.errorCode)"
                    alert.message = serverError.errorMessage
                case .unknown(let string):
                    alert.title = "Error Fetching Coins"
                    alert.message = string
                case .decodingError(let string):
                    alert.title = "Error Parsing Data"
                    alert.message = string
                }
                
                // 생성한 알림을 화면에 표시
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }

    // MARK: - UI Setup
    // UI 요소를 설정하는 메소드
    private func setupUI() {
        // 내비게이션 바의 제목 설정
        self.navigationItem.title = "CryptPro"
        // 뷰의 배경색 설정
        self.view.backgroundColor = .systemBackground
        
        // 테이블 뷰를 현재 뷰에 추가
        self.view.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        // 오토레이아웃 제약 조건 설정
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
    
    // MARK: - Selectors
    // 셀 선택 시 호출될 메소드들은 UITableViewDelegate 및 UITableViewDataSource extension에 구현
}

// MARK: - TableView Functions
// UITableView의 delegate와 dataSource를 구현하는 확장
extension HomeController: UITableViewDelegate, UITableViewDataSource {
    
    // 테이블 뷰의 섹션에 있는 행의 수를 반환하는 메소드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.coins.count
    }
    
    // 테이블 뷰의 각 행에 표시될 셀을 반환하는 메소드
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinCell.identifier, for: indexPath) as? CoinCell else {
            fatalError("Unable to dequeue CoinCell in HomeController")
        }
        
        // ViewModel에서 코인 데이터 가져오기
        let coin = self.viewModel.coins[indexPath.row]
        // 셀을 코인 데이터로 구성
        cell.configure(with: coin)
        return cell
    }
    
    // 각 행의 높이를 설정하는 메소드
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88  // 각 셀의 높이를 88로 설정
    }
    
    // 셀을 선택했을 때 호출되는 메소드
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 선택한 셀의 선택 상태 해제
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        // 선택한 코인 데이터를 가져와 ViewModel과 ViewController를 생성
        let coin = self.viewModel.coins[indexPath.row]
        let vm = ViewCryptoControllerViewModel(coin)
        let vc = ViewCryptoController(vm)
        // 새로운 뷰 컨트롤러를 네비게이션 스택에 추가
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
