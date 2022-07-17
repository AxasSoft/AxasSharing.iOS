//
//  SearchModel.swift
//  House
//
//  Created by Сергей Майбродский on 15.07.2022.
//

import Foundation
import PromiseKit

struct SearchModel{
    
    // fetch appart list
    static func fetchAppartList(search: String) -> Promise<AppartsResponse>{
        var url = Constants.baseURL.appendingPathComponent("/flats/")
        url = url.appending("search", value: "\(search)")
        return CoreNetwork.request(method: .GET(url: url))
    }
    // fetch one appart
    static func fetchOneAppart(id: Int) -> Promise<OneAppartsResponse>{
        let url = Constants.baseURL.appendingPathComponent("/flats/\(id)/")
        return CoreNetwork.request(method: .GET(url: url))
    }
}


// MARK: APPARTS RESPONSE
struct AppartsResponse: Codable {
    let message: String?
    let meta: Meta?
    let data: [Appart?]
    let errors: [ErrorData?]
    let errorDescription: String?

    enum CodingKeys: String, CodingKey {
        case message, meta, data, errors
        case errorDescription = "description"
    }
}

// MARK: ONE APPARTS RESPONSE
struct OneAppartsResponse: Codable {
    let message: String?
    let meta: Meta?
    let data: Appart?
    let errors: [ErrorData?]
    let errorDescription: String?

    enum CodingKeys: String, CodingKey {
        case message, meta, data, errors
        case errorDescription = "description"
    }
}

struct Appart: Codable {
    let id: Int?
    let title: String?
    let address: String?
    let priceShort: Int?
    let priceLong: Int?
    let pictures: [String?]
    let roomCount: Int?
    let hasBalcony: Bool?
    let hasLoggia: Bool?
    let lat: Double?
    let lon: Double?
    let area: Double?
    let children: Bool?
    let animals: Bool?
    let washingMachine: Bool?
    let fridge: Bool?
    let tv: Bool?
    let dishwasher: Bool?
    let airConditioner: Bool?
    let smoking: Bool?
    let noise: Bool?
    let party: Bool?
    let guestCount: Int?
    let bedCount: Int?
    let restroomCount: Int?

}





