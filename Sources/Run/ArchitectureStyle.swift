//
//  ArchitectureStyle.swift
//  ar-backendPackageDescription
//
//  Created by Alexandra Muresan on 01/04/2018.
//

import Foundation
import Vapor
import FluentProvider

final class ArchitectureStyle: Model {

    // MARK: - Public properties

    var storage = Storage()
    var id: Node?
    var exists: Bool = false
    var title: String
    var period: String
    var location: String
    var description: String
    var imageURL: String?

    // MARK: - Lifecycle

    init(title: String, period: String, location: String, description: String, imageURL: String) {
        self.title = title
        self.period = period
        self.location = location
        self.description = description
        self.imageURL = imageURL
    }

    func makeRow() throws -> Row {
        var row = Row()
        try row.set("title", title)
        try row.set("period", period)
        try row.set("location", location)
        try row.set("description",description)
        try row.set("imageURL", imageURL)

        return row
    }

    init(row: Row) throws {
        self.title = try row.get("title")
        self.period = try row.get("period")
        self.location = try row.get("location")
        self.description = try row.get("description")
        self.imageURL = try row.get("imageURL")
    }
}

extension ArchitectureStyle: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(ArchitectureStyle.self, closure: { style in
            style.id()
            style.string("title")
            style.string("period")
            style.string("location")
            style.string("description")
            style.string("imageURL")
        })
    }

    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}

extension ArchitectureStyle: NodeRepresentable {
    func makeNode(in context: Context?) throws -> Node {
        return try Node(node: [
            "title": title,
            "period": period,
            "location": location,
            "description": description,
            "imageURL": imageURL
            ])
    }
}


