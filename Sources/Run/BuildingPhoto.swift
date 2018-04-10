//
//  BuildingPhoto.swift
//  ar-backendPackageDescription
//
//  Created by Alexandra Muresan on 23/03/2018.
//

import Foundation
import Vapor
import FluentProvider

final class BuildingPhoto: Model {

    // MARK: - Public properties

    var storage = Storage()
    var id: Node?
    var exists: Bool = false
    var image: String?
    var date: String
    var latitude: Double
    var longitude: Double

    // MARK: - Lifecycle

    init(image: String, date: String, latitude: Double, longitude: Double) {
        self.date = date
        self.latitude = latitude
        self.longitude = longitude
        self.image = image
    }

    func makeRow() throws -> Row {
        var row = Row()
        try row.set("image", image)
        try row.set("date", date)
        try row.set("latitude", latitude)
        try row.set("longitude",longitude)

        return row
    }

    init(row: Row) throws {
        self.image = try row.get("image")
        self.date = try row.get("date")
        self.latitude = try row.get("latitude")
        self.longitude = try row.get("longitude")
    }
}

extension BuildingPhoto: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(BuildingPhoto.self, closure: { photo in
            photo.id()
            photo.string("image")
            photo.string("date")
            photo.double("latitude")
            photo.double("longitude")
        })
    }

    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}

extension BuildingPhoto: NodeRepresentable {
    func makeNode(in context: Context?) throws -> Node {
        return try Node(node: [
            "image": image,
            "date": date,
            "latitude": latitude,
            "longitude": longitude
            ])
    }
}
