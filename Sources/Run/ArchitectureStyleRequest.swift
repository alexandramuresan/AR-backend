//
//  ArchitectureStyleRequest.swift
//  ar-backendPackageDescription
//
//  Created by Alexandra Muresan on 01/04/2018.
//

import Foundation
import Vapor
import FluentProvider

final class ArchitectureStyleRequest {

    // MARK: - Private properties

    private var drop: Droplet

    // MARK: - Lifecycle

    init(drop: Droplet) {
        self.drop = drop
    }

    func getStyles() {
        drop.get("/styles/get") { request in
            return try JSON(node: ArchitectureStyle.all())
        }
    }
}
