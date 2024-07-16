//
//  HomeController.swift
//  Crypt-Pro
//
//  Created by USER on 7/15/24.
//

import UIKit

class Test {
    let homecontroller: HomeController = HomeController()
}

class HomeController: UIViewController {
    
    // MARK: - variables
    private let viewModel: HomeControllerViewModel
    
    // MARK: - UI Components
    private let tableView: UITableView = {
        // 테이블 뷰 생성 및 설정
        let tv = UITableView()
        tv.backgroundColor = .systemBackground
        tv.register(CoinCell.self, forCellReuseIdentifier: CoinCell.identifier)
        return tv
    }()
    
    // MARK: - LifeCycle
    init(_ viewModel: HomeControllerViewModel = HomeControllerViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        // 테이블 뷰의 델리게이트와 데이터 소스 설정
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.viewModel.onCoinsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
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
                
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        // 네비게이션 아이템의 타이틀 설정
        self.navigationItem.title = "CryptPro"
        
        // 뷰의 배경색 설정
        self.view.backgroundColor = .systemBackground
        
        // 테이블 뷰를 서브뷰로 추가
        self.view.addSubview(tableView)
        
        // 자동 제약 조건 비활성화
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        // 제약 조건 설정
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    // MARK: - Selectors
}

// MARK: - TableView Functions
extension HomeController: UITableViewDelegate, UITableViewDataSource {
    
    // 테이블 뷰의 섹션 당 행 개수 설정
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.coins.count
    }
    
    // 각 행에 표시될 셀 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinCell.identifier, for: indexPath) as? CoinCell else {
            fatalError("Unable to dequeue CoinCell in HomeController")
        }
        
        // 셀을 구성하는 데 필요한 코인 데이터 가져오기
        let coin = self.viewModel.coins[indexPath.row]
        cell.configure(with: coin)
        
        return cell
    }
    
    // 각 행의 높이 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    // 행이 선택되었을 때의 동작 정의
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        // 선택된 코인 데이터 가져오기
        let coin = self.viewModel.coins[indexPath.row]
        
        // 뷰 모델 및 뷰 컨트롤러 생성
        let vm = CryptoViewControllerViewModel(coin)
        let vc = CryptoViewController(vm)
        
        // 네비게이션 컨트롤러를 통해 새로운 뷰 컨트롤러로 이동
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
