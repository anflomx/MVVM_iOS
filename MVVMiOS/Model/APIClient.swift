//
//  APIClient.swift
//  MVVMiOS
//
//  Created by Antonio Flores on 25/02/24.
//

import Foundation

enum BackendError: String, Error{
    case invalidEmail = "Wrong Email"
    case invalidPassword = "Wrong Password"
}

final class APIClient {
    func login(withEmail email: String, withPassword password: String) async throws -> User {
            try await Task.sleep(nanoseconds: NSEC_PER_SEC * 2)
            return try simulateBackendLogic(email: email, password: password)
        }
    
    func simulateBackendLogic(email: String, password: String) throws -> User {
        guard email == "test@mail.com" else {
            throw BackendError.invalidEmail
        }
        guard password == "12345" else {
            throw BackendError.invalidPassword
        }
        
        return .init(name: "test@mail.com",
                     token: "12345",
                     sessionStart: Date())
    }
}
