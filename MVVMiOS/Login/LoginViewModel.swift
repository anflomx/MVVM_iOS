//
//  LoginViewModel.swift
//  MVVMiOS
//
//  Created by Antonio Flores on 25/02/24.
//

import Foundation
import Combine

class LoginViewModel {
    @Published var email = ""
    @Published var password = ""
    @Published var isEnabled = false
    @Published var showLoading = false
    @Published var errorModel: String = ""
    @Published var userModel: User?
    
    var cancellables = Set<AnyCancellable>()
    
    let apiClient: APIClient
        
    init(apiClient: APIClient) {
        self.apiClient = apiClient
        
        formValidation()
    }
    
    func formValidation() {
        Publishers.CombineLatest($email, $password)
            .filter { email, password in
                return email.count >= 5 && password.count >= 5
            }
            .sink { value in
                self.isEnabled = true
        }.store(in: &cancellables)
    }
    
    @MainActor
    func userLogin(withEmail email: String, withPassword password: String) {
        errorModel = ""
        showLoading = true
        Task {
            do {
                userModel = try await apiClient.login(withEmail: email, withPassword: password)
            } catch let error as BackendError {
                errorModel = error.rawValue
            }
            showLoading = false
        }
    }
}
