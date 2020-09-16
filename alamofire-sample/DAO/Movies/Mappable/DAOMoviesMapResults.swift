//
//  DAOMoviesMapResults.swift
//
//  Created by IRFAN TRIHANDOKO on 16/09/20
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class DAOMoviesMapResults: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let posterPath = "poster_path"
    static let backdropPath = "backdrop_path"
    static let genreIds = "genre_ids"
    static let voteCount = "vote_count"
    static let overview = "overview"
    static let originalTitle = "original_title"
    static let popularity = "popularity"
    static let releaseDate = "release_date"
    static let id = "id"
    static let video = "video"
    static let originalLanguage = "original_language"
    static let voteAverage = "vote_average"
    static let title = "title"
    static let adult = "adult"
  }

  // MARK: Properties
  public var posterPath: String?
  public var backdropPath: String?
  public var genreIds: [Int]?
  public var voteCount: Int?
  public var overview: String?
  public var originalTitle: String?
  public var popularity: Float?
  public var releaseDate: String?
  public var id: Int?
  public var video: Bool? = false
  public var originalLanguage: String?
  public var voteAverage: Float?
  public var title: String?
  public var adult: Bool? = false

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    posterPath = json[SerializationKeys.posterPath].string
    backdropPath = json[SerializationKeys.backdropPath].string
    if let items = json[SerializationKeys.genreIds].array { genreIds = items.map { $0.intValue } }
    voteCount = json[SerializationKeys.voteCount].int
    overview = json[SerializationKeys.overview].string
    originalTitle = json[SerializationKeys.originalTitle].string
    popularity = json[SerializationKeys.popularity].float
    releaseDate = json[SerializationKeys.releaseDate].string
    id = json[SerializationKeys.id].int
    video = json[SerializationKeys.video].boolValue
    originalLanguage = json[SerializationKeys.originalLanguage].string
    voteAverage = json[SerializationKeys.voteAverage].float
    title = json[SerializationKeys.title].string
    adult = json[SerializationKeys.adult].boolValue
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = posterPath { dictionary[SerializationKeys.posterPath] = value }
    if let value = backdropPath { dictionary[SerializationKeys.backdropPath] = value }
    if let value = genreIds { dictionary[SerializationKeys.genreIds] = value }
    if let value = voteCount { dictionary[SerializationKeys.voteCount] = value }
    if let value = overview { dictionary[SerializationKeys.overview] = value }
    if let value = originalTitle { dictionary[SerializationKeys.originalTitle] = value }
    if let value = popularity { dictionary[SerializationKeys.popularity] = value }
    if let value = releaseDate { dictionary[SerializationKeys.releaseDate] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    dictionary[SerializationKeys.video] = video
    if let value = originalLanguage { dictionary[SerializationKeys.originalLanguage] = value }
    if let value = voteAverage { dictionary[SerializationKeys.voteAverage] = value }
    if let value = title { dictionary[SerializationKeys.title] = value }
    dictionary[SerializationKeys.adult] = adult
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.posterPath = aDecoder.decodeObject(forKey: SerializationKeys.posterPath) as? String
    self.backdropPath = aDecoder.decodeObject(forKey: SerializationKeys.backdropPath) as? String
    self.genreIds = aDecoder.decodeObject(forKey: SerializationKeys.genreIds) as? [Int]
    self.voteCount = aDecoder.decodeObject(forKey: SerializationKeys.voteCount) as? Int
    self.overview = aDecoder.decodeObject(forKey: SerializationKeys.overview) as? String
    self.originalTitle = aDecoder.decodeObject(forKey: SerializationKeys.originalTitle) as? String
    self.popularity = aDecoder.decodeObject(forKey: SerializationKeys.popularity) as? Float
    self.releaseDate = aDecoder.decodeObject(forKey: SerializationKeys.releaseDate) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.video = aDecoder.decodeBool(forKey: SerializationKeys.video)
    self.originalLanguage = aDecoder.decodeObject(forKey: SerializationKeys.originalLanguage) as? String
    self.voteAverage = aDecoder.decodeObject(forKey: SerializationKeys.voteAverage) as? Float
    self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
    self.adult = aDecoder.decodeBool(forKey: SerializationKeys.adult)
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(posterPath, forKey: SerializationKeys.posterPath)
    aCoder.encode(backdropPath, forKey: SerializationKeys.backdropPath)
    aCoder.encode(genreIds, forKey: SerializationKeys.genreIds)
    aCoder.encode(voteCount, forKey: SerializationKeys.voteCount)
    aCoder.encode(overview, forKey: SerializationKeys.overview)
    aCoder.encode(originalTitle, forKey: SerializationKeys.originalTitle)
    aCoder.encode(popularity, forKey: SerializationKeys.popularity)
    aCoder.encode(releaseDate, forKey: SerializationKeys.releaseDate)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(video, forKey: SerializationKeys.video)
    aCoder.encode(originalLanguage, forKey: SerializationKeys.originalLanguage)
    aCoder.encode(voteAverage, forKey: SerializationKeys.voteAverage)
    aCoder.encode(title, forKey: SerializationKeys.title)
    aCoder.encode(adult, forKey: SerializationKeys.adult)
  }

}
