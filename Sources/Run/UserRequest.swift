//
//  UserRequest.swift
//  Run
//
//  Created by Alexandra Muresan on 04/12/2017.
//

import Foundation
import Vapor
import FluentProvider

final class UserRequest {
    
    // MARK: - Private properties
    
    private var drop: Droplet
    
    // MARK: - Lifecycle
    
    init(drop: Droplet) {
        self.drop = drop
    }
    
    func signInRequest() {
        drop.post("/users/sign_in") { request in
            let email = request.data["username"]?.string
            let password = request.data["password"]?.string
            
            let user = try User.makeQuery().filter("username", email).filter("password", password).first()
            if user == nil {
                return try JSON(node: [
                    "message": "User not found"
                ])
            }
            return try JSON(node: user)
        }
    }

    func updateProfilePictureRequest() {
        drop.put("/users/update") { request in
            let username = request.data["username"]?.string
            let imageName = request.data["imageName"]?.string

            guard let user = try User.makeQuery().filter("username", username).first() else {
                return try JSON(node: ["message": "User not found"])
            }

            user.profilePicture = imageName
            try user.save()
            return try JSON(node: user)
        }
    }
}
