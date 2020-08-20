//
//  ViewModelType.swift
//  GithubSearch
//
//  Created by Jeongbae Kong on 2020/08/20.
//  Copyright © 2020 Jeongbae Kong. All rights reserved.
//

import Foundation

protocol ViewModelType {
  associatedtype Input
  associatedtype Output
  
  func transform(input: Input) -> Output
}
