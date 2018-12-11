
//
//  HistoryListViewModel.swift
//  BasketballScorer
//
//  Created by Igor-Macbook Pro on 10/12/2018.
//  Copyright © 2018 Igor-Macbook Pro. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import CoreData

class HistoryListViewModel {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    var data = BehaviorRelay<[Game]>(value: [])
    
    lazy var dataDriver : Driver<[Game]> = {
        
        data.accept(getGames())
        
        return self.data.asObservable()
            .asDriver(onErrorJustReturn : [])
    }()
    
    private func getGames() -> [Game] {
        let request : NSFetchRequest<Game> = Game.fetchRequest()
        
        var tempGames : [Game] = [Game]()
        
        do {
            tempGames = try context.fetch(request)
        }
        catch {
            print(error)
        }
        
        
        return tempGames
    }
    
}
