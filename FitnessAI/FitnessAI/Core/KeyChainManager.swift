//
//  KeyChainManager.swift
//  FitnessAI
//
//  Created by Misha Fedorov on 14.12.2024.
//

import Foundation

struct KeychainManager {

    static let shared = KeychainManager()

    @discardableResult
    func saveToken(_ token: Token) -> Bool {
        guard let tokenData = token.value.data(using: .utf8) else { return false }

        // Удаляем старую запись, если она существует
        SecItemDelete([
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: token.key.key
        ] as CFDictionary)

        // Добавляем новую запись
        let status = SecItemAdd([
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: token.key.key,
            kSecValueData: tokenData
        ] as CFDictionary, nil)

        return status == errSecSuccess
    }

    @discardableResult
    func deleteToken(forKey key: TokenKey) -> Bool {
        let status = SecItemDelete([
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.key
        ] as CFDictionary)

        return status == errSecSuccess || status == errSecItemNotFound
    }

    @discardableResult
    func loadToken(forKey key: TokenKey) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.key,
            kSecReturnData as String: true
        ]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        guard status == errSecSuccess, let data = item as? Data else {
            print("Failed to load token from Keychain. Status: \(status)")
            return nil
        }

        return String(data: data, encoding: .utf8)
    }
}

