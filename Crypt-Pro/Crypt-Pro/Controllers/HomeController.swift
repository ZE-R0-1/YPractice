//
//  HomeController.swift
//  Crypt-Pro
//
//  Created by USER on 7/15/24.
//

import UIKit

class HomeController: UIViewController {
    
    // MARK: - Variables
    private let viewModel: HomeControllerViewModel  // 뷰 모델 변수
    
    // MARK: - UI Components
    private let searchController = UISearchController(searchResultsController: nil)  // 검색 컨트롤러
    
    private let tableView: UITableView = {  // 테이블 뷰 설정
        let tv = UITableView()
        tv.backgroundColor = .systemBackground
        tv.register(CoinCell.self, forCellReuseIdentifier: CoinCell.identifier)  // 테이블 뷰 셀 등록
        return tv
    }()
    
    // MARK: - LifeCycle
    init(_ viewModel: HomeControllerViewModel = HomeControllerViewModel()) {
        self.viewModel = viewModel  // 뷰 모델 초기화
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSearchController()  // 검색 컨트롤러 설정
        self.setupUI()  // UI 설정
        
        self.tableView.delegate = self  // 테이블 뷰 델리게이트 설정
        self.tableView.dataSource = self  // 테이블 뷰 데이터 소스 설정
        
        self.viewModel.onCoinsUpdated = { [weak self] in  // 코인 데이터 업데이트 콜백 설정
            DispatchQueue.main.async {
                self?.tableView.reloadData()  // 테이블 뷰 리로드
            }
        }
        
        self.viewModel.onErrorMessage = { [weak self] error in  // 에러 메시지 콜백 설정
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
    private func setupUI() {  // UI 설정 함수
        self.navigationItem.title = "iCryyptPro"  // 네비게이션 타이틀 설정
        self.view.backgroundColor = .systemBackground  // 배경색 설정
        
        self.view.addSubview(tableView)  // 테이블 뷰 추가
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([  // 오토레이아웃 설정
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
    
    private func setupSearchController() {  // 검색 컨트롤러 설정 함수
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search Cryptos"
        
        self.navigationItem.searchController = searchController  // 네비게이션 아이템에 검색 컨트롤러 추가
        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchBar.showsBookmarkButton = true  // 북마크 버튼 표시
        searchController.searchBar.setImage(UIImage(systemName: "line.horizontal.3.decrease"), for: .bookmark, state: .normal)
    }
}

// MARK: - Search Controller Functions
extension HomeController: UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate  {
    
    func updateSearchResults(for searchController: UISearchController) {  // 검색 결과 업데이트 함수
        self.viewModel.updateSearchController(searchBarText: searchController.searchBar.text)
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {  // 북마크 버튼 클릭 함수
        print("Search bar button called!")
    }
}

// MARK: - TableView Functions
extension HomeController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {  // 섹션당 행의 개수 설정
        let inSearchMode = self.viewModel.inSearchMode(searchController)
        return inSearchMode ? self.viewModel.filteredCoins.count : self.viewModel.allCoins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {  // 셀 구성 함수
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinCell.identifier, for: indexPath) as? CoinCell else {
            fatalError("Unable to dequeue CoinCell in HomeController")
        }
        
        let inSearchMode = self.viewModel.inSearchMode(searchController)
        
        let coin = inSearchMode ? self.viewModel.filteredCoins[indexPath.row] : self.viewModel.allCoins[indexPath.row]
        cell.configure(with: coin)  // 셀에 코인 데이터 설정
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {  // 행 높이 설정
        return 88
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {  // 셀 선택 시 호출
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        let inSearchMode = self.viewModel.inSearchMode(searchController)
        
        let coin = inSearchMode ? self.viewModel.filteredCoins[indexPath.row] : self.viewModel.allCoins[indexPath.row]
        
        let vm = ViewCryptoControllerViewModel(coin)
        let vc = ViewCryptoController(vm)
        self.navigationController?.pushViewController(vc, animated: true)  // 상세 정보 화면으로 이동
    }
}
