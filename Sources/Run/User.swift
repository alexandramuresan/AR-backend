//
//  User.swift
//  Run
//
//  Created by Alexandra Muresan on 04/12/2017.
//

import Foundation
import Vapor
import FluentProvider

final class User: Model {
    
    // MARK: - Public properties
    
    var storage = Storage()
    var id: Node?
    var exists: Bool = false
    var fullName: String
    var city: String
    var username: String
    var password: String
    var token: String
    var profilePicture: String?
    
    // MARK: - Lifecycle
    
    init(username: String, password: String, token: String, fullName: String, city: String) {
        self.username = username
        self.fullName = fullName
        self.city = city
        self.password = password
        self.token = token
    }
    
    func makeRow() throws -> Row {
        var row = Row()
        try row.set("username", username)
        try row.set("password", password)
        try row.set("token", token)
        try row.set("fullName",fullName)
        try row.set("city",city)
        try row.set("profilePicture",profilePicture)

        return row
    }
    
    init(row: Row) throws {
        self.username = try row.get("username")
        self.password = try row.get("password")
        self.token = try row.get("token")
        self.fullName = try row.get("fullName")
        self.city = try row.get("city")
        self.profilePicture = try row.get("profilePicture")
    }
}

extension User: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(User.self, closure: { user in
            user.id()
            user.string("username")
            user.string("password")
            user.string("token")
            user.string("fullName")
            user.string("city")
            user.string("profilePicture")
        })
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}

extension User: NodeRepresentable {
    func makeNode(in context: Context?) throws -> Node {
        return try Node(node: [
            "username": username,
            "password": password,
            "token": token,
            "fullName": fullName,
            "city": city,
            "profilePicture": profilePicture
            ])
    }
}
