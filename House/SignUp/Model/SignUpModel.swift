//
//  SignUpModel.swift
//  House
//
//  Created by Сергей Майбродский on 15.07.2022.
//

import Foundation
import PromiseKit

struct SignUpModel{
    
    // autorization
    static func fetchLogin(phone: String, code: String) -> Promise<AutorizationRespose>{
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let param: [String: Encodable] = [
            "tel": phone,
            "code": code
        ]
        let wrappedDict = param.mapValues(NetCoreStruct.EncodableWrapper.init(wrapped:))
        let data: Data? = try? encoder.encode(wrappedDict)
        let url = Constants.baseURL.appendingPathComponent("/siw/tel/")
        return CoreNetwork.request(method: .POST(url: url, body: data!))
    }
    
    
    // get varification code
    static func fetchVerificationCode(phone: String) -> Promise<VerificationResponse>{
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data: Data? = try? encoder.encode(["tel": phone])
        let url = Constants.baseURL.appendingPathComponent("/tels/verify/")
        return CoreNetwork.request(method: .POST(url: url, body: data!))
    }
}


// MARK: - VERIFICATION STRUCT
struct VerificationResponse: Codable {
    let message: String
    let meta: Meta?
    let data: VerificationCode?
    let errors: [ErrorData?]
    let errorDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case message, meta, errors
        case errorDescription = "description"
        case data
    }
}

struct VerificationCode: Codable {
    let code: String?
}


// MARK: AUTORIZATION STRUCT
struct AutorizationRespose: Codable {
    let message: String?
    let meta: Meta?
    let data: AutorizationData?
    let errors: [ErrorData?]
    let errorDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case message, meta, data, errors
        case errorDescription = "description"
    }
}

struct AutorizationData: Codable {
    let user: User?
    let tokens: Tokens?
}


// MARK: TOKENS
struct Tokens: Codable {
    let access, refresh: Access?
}

struct Access: Codable {
    let value: String?
    let expireAt: Int?
    
    enum CodingKeys: String, CodingKey {
        case value
        case expireAt = "expireat"
    }
}


//MARK: USER RESPONSE
struct UserResponse: Codable {
    let message: String?
    let meta: Meta?
    let data: User?
    let errors: [ErrorData?]
    let errorDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case message, meta, data, errors
        case errorDescription = "description"
    }
}


// MARK: USER
struct User: Codable {
    let id: Int?
    let tel: String?
    let avatar: String?
    let name: String?
    let surname: String?
    let patronymic: String?
    let passport_issued: String?
    let issue_date: String?
    let department_code: String?
    let passport_series: String?
    let passport_num: String?
    let gender: String?
    let birthdate: String?
    let birthplace: String?
}
