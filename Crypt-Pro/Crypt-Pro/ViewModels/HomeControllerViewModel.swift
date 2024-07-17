//
//  HomeControllerViewModel.swift
//  Crypt-Pro
//
//  Created by USER on 7/16/24.
//

import UIKit

class HomeControllerViewModel {
    
    // MARK: - Callbacks
    var onCoinsUpdated: (()->Void)?
    var onErrorMessage: ((CoinServiceError)->Void)?
    
    // MARK: - Variables
    private(set) var allCoins: [Coin] = [] {
        didSet {
            self.onCoinsUpdated?()
        }
    }
    
    private(set) var filteredCoins: [Coin] = []
    
    // MARK: - Initializer
    init() {
        self.fetchCoins()
    }
    
    // 코인 데이터를 서버로부터 가져오는 메서드
    public func fetchCoins() {
        let endpoint = Endpoint.fetchCoins()
        
        CoinService.fetchCoins(with: endpoint) { [weak self] result in
            switch result {
            case .success(let coins):
                self?.allCoins = coins
                print("DEBUG PRINT:", "\(coins.count) coins fetched.")
                
            case .failure(let error):
                self?.onErrorMessage?(error)
            }
        }
    }
}

// MARK: - Search
extension HomeControllerViewModel {
    
    // 검색 모드 여부를 확인하는 메서드
    public func inSearchMode(_ searchController: UISearchController) -> Bool {
        let isActive = searchController.isActive
        let searchText = searchController.searchBar.text ?? ""
        
        return isActive && !searchText.isEmpty
    }
    
    // 검색어에 따라 필터링된 코인 목록을 업데이트하는 메서드
    public func updateSearchController(searchBarText: String?) {
        self.filteredCoins = allCoins

        if let searchText = searchBarText?.lowercased() {
            guard !searchText.isEmpty else { self.onCoinsUpdated?(); return }
            
            self.filteredCoins = self.filteredCoins.filter({ $0.name.lowercased().contains(searchText) })
        }
        
        self.onCoinsUpdated?()
    }
}
