//
//  DAOMoviesCodableResults.swift
//
//  Created by IRFAN TRIHANDOKO on 16/09/20
//  Copyright (c) . All rights reserved.
//

import Foundation

class DAOMovieResults: Codable {

  enum CodingKeys: String, CodingKey {
    case genreIds = "genre_ids"
    case releaseDate = "release_date"
    case id
    case originalTitle = "original_title"
    case originalLanguage = "original_language"
    case voteCount = "vote_count"
    case overview
    case adult
    case video
    case posterPath = "poster_path"
    case popularity
    case title
    case backdropPath = "backdrop_path"
    case voteAverage = "vote_average"
  }

  var genreIds: [Int]?
  var releaseDate: String?
  var id: Int?
  var originalTitle: String?
  var originalLanguage: String?
  var voteCount: Int?
  var overview: String?
  var adult: Bool?
  var video: Bool?
  var posterPath: String?
  var popularity: Float?
  var title: String?
  var backdropPath: String?
  var voteAverage: Float?

  init (genreIds: [Int]?, releaseDate: String?, id: Int?, originalTitle: String?, originalLanguage: String?, voteCount: Int?, overview: String?, adult: Bool?, video: Bool?, posterPath: String?, popularity: Float?, title: String?, backdropPath: String?, voteAverage: Float?) {
    self.genreIds = genreIds
    self.releaseDate = releaseDate
    self.id = id
    self.originalTitle = originalTitle
    self.originalLanguage = originalLanguage
    self.voteCount = voteCount
    self.overview = overview
    self.adult = adult
    self.video = video
    self.posterPath = posterPath
    self.popularity = popularity
    self.title = title
    self.backdropPath = backdropPath
    self.voteAverage = voteAverage
  }

  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    genreIds = try container.decodeIfPresent([Int].self, forKey: .genreIds)
    releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle)
    originalLanguage = try container.decodeIfPresent(String.self, forKey: .originalLanguage)
    voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount)
    overview = try container.decodeIfPresent(String.self, forKey: .overview)
    adult = try container.decodeIfPresent(Bool.self, forKey: .adult)
    video = try container.decodeIfPresent(Bool.self, forKey: .video)
    posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
    popularity = try container.decodeIfPresent(Float.self, forKey: .popularity)
    title = try container.decodeIfPresent(String.self, forKey: .title)
    backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath)
    voteAverage = try container.decodeIfPresent(Float.self, forKey: .voteAverage)
  }

}
