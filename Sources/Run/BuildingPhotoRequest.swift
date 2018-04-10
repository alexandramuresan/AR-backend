//
//  BuildingPhotoRequest.swift
//  ar-backendPackageDescription
//
//  Created by Alexandra Muresan on 23/03/2018.
//

import Foundation
import Vapor
import FluentProvider

final class BuildingPhotoRequest {

    // MARK: - Private properties

    private var drop: Droplet

    // MARK: - Lifecycle

    init(drop: Droplet) {
        self.drop = drop
    }

    func uploadPhoto() {
        drop.put("/photos/upload") { request in
            guard let image = request.data["image"]?.string, let date = request.data["date"]?.string, let latitude = request.data["latitude"]?.double, let longitude = request.data["longitude"]?.double else {
                return try JSON(node: ["message": "Something went wrong"])
            }
            let buildingPhoto = BuildingPhoto(image: image, date: date, latitude: latitude, longitude: longitude)
            try buildingPhoto.save()
            return try JSON(node: buildingPhoto)
        }
    }

    func getPhotos() {
        drop.get("/photos/get") { request in
            return try JSON(node: BuildingPhoto.all())
        }
    }
}
