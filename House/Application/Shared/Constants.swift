//
//  Constants.swift
//  House
//
//  Created by Сергей Майбродский on 15.07.2022.
//

import Foundation
import KeychainAccess

struct Constants {
    static let baseURL: URL = URL(string: "http://192.168.43.203:5000")!
    static let urlString: String = "http://192.168.43.203:5000"
    static let keychain = Keychain(service: "ru.axas.House")

}
