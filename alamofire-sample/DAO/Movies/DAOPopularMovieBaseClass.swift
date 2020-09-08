//
//  DAOPopularMovieBaseClass.swift
//
//  Created by IRFAN TRIHANDOKO on 23/03/20
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class DAOPopularMovieBaseClass: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let totalResults = "total_results"
    static let page = "page"
    static let results = "results"
    static let totalPages = "total_pages"
  }

  // MARK: Properties
  public var totalResults: Int?
  public var page: Int?
  public var results: [DAOPopularMovieResults]?
  public var totalPages: Int?

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
    totalResults = json[SerializationKeys.totalResults].int
    page = json[SerializationKeys.page].int
    if let items = json[SerializationKeys.results].array { results = items.map { DAOPopularMovieResults(json: $0) } }
    totalPages = json[SerializationKeys.totalPages].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = totalResults { dictionary[SerializationKeys.totalResults] = value }
    if let value = page { dictionary[SerializationKeys.page] = value }
    if let value = results { dictionary[SerializationKeys.results] = value.map { $0.dictionaryRepresentation() } }
    if let value = totalPages { dictionary[SerializationKeys.totalPages] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.totalResults = aDecoder.decodeObject(forKey: SerializationKeys.totalResults) as? Int
    self.page = aDecoder.decodeObject(forKey: SerializationKeys.page) as? Int
    self.results = aDecoder.decodeObject(forKey: SerializationKeys.results) as? [DAOPopularMovieResults]
    self.totalPages = aDecoder.decodeObject(forKey: SerializationKeys.totalPages) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(totalResults, forKey: SerializationKeys.totalResults)
    aCoder.encode(page, forKey: SerializationKeys.page)
    aCoder.encode(results, forKey: SerializationKeys.results)
    aCoder.encode(totalPages, forKey: SerializationKeys.totalPages)
  }

}
