//
//  DAOMoviesCodableBaseClass.swift
//
//  Created by IRFAN TRIHANDOKO on 16/09/20
//  Copyright (c) . All rights reserved.
//

import Foundation

class DAOMoviesCodableBaseClass: Codable {

  enum CodingKeys: String, CodingKey {
    case totalPages = "total_pages"
    case totalResults = "total_results"
    case results
    case page
  }

  var totalPages: Int?
  var totalResults: Int?
  var results: [DAOMoviesCodableResults]?
  var page: Int?

  init (totalPages: Int?, totalResults: Int?, results: [DAOMoviesCodableResults]?, page: Int?) {
    self.totalPages = totalPages
    self.totalResults = totalResults
    self.results = results
    self.page = page
  }

  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    totalPages = try container.decodeIfPresent(Int.self, forKey: .totalPages)
    totalResults = try container.decodeIfPresent(Int.self, forKey: .totalResults)
    results = try container.decodeIfPresent([DAOMoviesCodableResults].self, forKey: .results)
    page = try container.decodeIfPresent(Int.self, forKey: .page)
  }

}
