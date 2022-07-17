//
//  Constants.swift
//  House
//
//  Created by Сергей Майбродский on 15.07.2022.
//

import Foundation
import KeychainAccess

struct Constants {
    static let baseURL: URL = URL(string: "http://10.254.200.112:5000")!
    static let urlString: String = "http://10.254.200.112:5000"
    static let keychain = Keychain(service: "ru.axas.House")

    static let conveninces = ["hisBalcony" : "Балкон",
                       "hasLoggia" : "Лоджия",
                       "children" : "Можно с детьми",
                       "animals" : "Можно с животными",
                       "washingMashine" : "Стиральная машина",
                       "fridge" : "Холодильник",
                       "tv" : "Телевизор",
                       "dishwasher" : "Посудомоечная машина",
                       "airConditioner" : "Кондиционер",
                       "smoking" : "Можно курить",
                       "noise" : "Можно шуметь",
                       "party" : "Можно вечеринки"]
}
