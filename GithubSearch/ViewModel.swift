//
//  ViewModel.swift
//  GithubSearch
//
//  Created by Jeongbae Kong on 2020/08/20.
//  Copyright © 2020 Jeongbae Kong. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ViewModel: ViewModelType {
  
  var text: String?
  let router = APIManager()
  let disposeBag = DisposeBag()
  
  struct Input {
    let searchBar: Driver<String>
  }
  
  struct Output {
    let result: Driver<[Repository]>
  }
  
  let searchBarLinker = PublishSubject<[Repository]>()
  
  
  func transform(input: Input) -> Output {
    
    input.searchBar.drive(onNext: { [weak self] in
      guard let `self` = self else { return }

      self.router.repositoriesBy($0)
        .subscribe(onNext: { self.searchBarLinker.onNext($0) })
        .disposed(by: self.disposeBag)
    })
      .disposed(by: disposeBag)
    
    return Output(
      result: searchBarLinker.asDriver(onErrorJustReturn: [])
    )
  }
  
  
}
