//
//  AccountRepo.swift
//  fakestagram
//
//  Created by LuisE on 3/17/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

let KEY_ID = "uuidKey"
class AccountRepo {
    static let shared = AccountRepo()
    let restClient = RestClient<Account>(client: Client(), path: "/api/accounts")
    
    typealias accountResponse = (Account) -> Void
    func loadOrCreate(success: @escaping accountResponse) {
        if let account = load() {
            //UserDefaults.standard.set(account.id, forKey: KEY_ID)
            success(account)
            return
        }
        let newAccount = Account.initialize()
        create(newAccount) { account in
            AccountStorage.shared.item = account
            _ = AccountStorage.shared.save()
            success(account)
        }
    }

    func load() -> Account? {
        return AccountStorage.shared.item
    }
    
    func create(_ account: Account, success: @escaping (Account) -> Void) {
        restClient.create(codable: account, success: success)
    }
}
