//
// Race.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
import AnyCodable

public struct Race: Codable, Hashable {

    public var round: String?
    public var url: String?
    public var raceName: String?
    public var season: String?
    public var date: String?
    public var circuit: Circuit?

    public init(round: String? = nil, url: String? = nil, raceName: String? = nil, season: String? = nil, date: String? = nil, circuit: Circuit? = nil) {
        self.round = round
        self.url = url
        self.raceName = raceName
        self.season = season
        self.date = date
        self.circuit = circuit
    }
    public enum CodingKeys: String, CodingKey, CaseIterable {
        case round
        case url
        case raceName
        case season
        case date
        case circuit = "Circuit"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(round, forKey: .round)
        try container.encodeIfPresent(url, forKey: .url)
        try container.encodeIfPresent(raceName, forKey: .raceName)
        try container.encodeIfPresent(season, forKey: .season)
        try container.encodeIfPresent(date, forKey: .date)
        try container.encodeIfPresent(circuit, forKey: .circuit)
    }



}