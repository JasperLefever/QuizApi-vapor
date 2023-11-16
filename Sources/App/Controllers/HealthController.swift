//
//  File.swift
//  
//
//  Created by Jasper Lefever on 16/11/2023.
//
import Fluent
import Vapor

struct HealthController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let health = routes.grouped("health")
        
        health.get("ping", use: ping)
        
    }

    func ping(req: Request) async throws -> String {
        return "pong"
    }

}
