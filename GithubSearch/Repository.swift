//
//  Repository.swift
//  GithubSearch
//
//  Created by Jeongbae Kong on 2020/08/20.
//  Copyright © 2020 Jeongbae Kong. All rights reserved.
//

import Foundation
import ObjectMapper

struct Repository: Mappable {
  
  var repoName: String?
  var repoURL: String?
  
  init?(map: Map) { }
  
  init(repoName: String, repoURL: String) {
    self.repoName = repoName
    self.repoURL = repoURL
  }
  
  mutating func mapping(map: Map) {
    repoName <- map["repoName"]
    repoURL <- map["repoURL"]
  }
  
}
