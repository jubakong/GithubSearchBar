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
  private lazy var refreshControl = UIRefreshControl()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    addRefreshControlCollectionView()
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
  
  private func addRefreshControlCollectionView() {
    let colorOption = [NSAttributedString.Key.foregroundColor : UIColor.white]
    
    let title = NSAttributedString(string: "pull to refresh", attributes: colorOption)
    
    refreshControl.attributedTitle = title
    refreshControl.backgroundColor = .blue
    refreshControl.tintColor = .white
    refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    
    if #available(iOS 10.0, *) {
      tableView.refreshControl = refreshControl
    } else {
      tableView.addSubview(refreshControl)
    }
  }
  
  @objc private func refresh() {
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {[weak self] in
      guard let `self` = self else { return }
      
      self.tableView.refreshControl?.endRefreshing()
      self.tableView.reloadData()
    }
  }
}

