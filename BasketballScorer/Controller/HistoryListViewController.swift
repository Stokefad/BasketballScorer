//
//  HistoryListViewController.swift
//  BasketballScorer
//
//  Created by Igor-Macbook Pro on 10/12/2018.
//  Copyright © 2018 Igor-Macbook Pro. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HistoryListViewController : UIViewController, UITableViewDelegate, UISearchBarDelegate {
    
    let historyVM = HistoryListViewModel()
    let disposeBag = DisposeBag()
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var customTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customTableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        
        driveData { games in
            return true
        }
        
        customTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
    }
    
    private func driveData(filtering : @escaping ([Game]) -> (Bool)) {
        historyVM.dataDriver.filter(filtering).drive(customTableView.rx.items(cellIdentifier: "CustomCell", cellType: CustomCell.self)) { _, game, cell in
            
            cell.configure(game: game)
            
            }
            .disposed(by: disposeBag)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(integerLiteral: 120)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        driveData { games in
            
        }
    }
    
}
