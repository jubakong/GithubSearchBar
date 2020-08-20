//
//  ViewController.swift
//  GithubSearch
//
//  Created by Jeongbae Kong on 2020/08/20.
//  Copyright © 2020 Jeongbae Kong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
  
  @IBOutlet weak var searchBar: UISearchBar!
  
  
  @IBOutlet weak var tableView: UITableView!
  
  let viewModel = ViewModel()
  
  let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  private func setup() {
    
    let input = ViewModel.Input(
      searchBar: searchBar.rx.text.orEmpty.asDriver()
      )
    
    let output = viewModel.transform(input: input)
    
    output.result
      .drive(tableView.rx.items(cellIdentifier: "Cell")) { _, repository, cell in
        
        cell.textLabel?.text = repository.repoName
        cell.detailTextLabel?.text = repository.repoURL
    }
  .disposed(by: disposeBag)
  }
}

