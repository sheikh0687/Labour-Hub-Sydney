//
//  AddExtraService.swift
//  Labour Hub Sydeny
//
//  Created by mac on 12/04/23.
//

import Foundation

struct AddExtraServices : Codable {
    let result : ResExtraService?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(ResExtraService.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}
struct ResExtraService : Codable {
    let id : String?
    let request_id : String?
    let cat_id : String?
    let cat_name : String?
    let no_of_worker : String?
    let hired_worker : String?
    let status : String?
    let date_time : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case request_id = "request_id"
        case cat_id = "cat_id"
        case cat_name = "cat_name"
        case no_of_worker = "no_of_worker"
        case hired_worker = "hired_worker"
        case status = "status"
        case date_time = "date_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        request_id = try values.decodeIfPresent(String.self, forKey: .request_id)
        cat_id = try values.decodeIfPresent(String.self, forKey: .cat_id)
        cat_name = try values.decodeIfPresent(String.self, forKey: .cat_name)
        no_of_worker = try values.decodeIfPresent(String.self, forKey: .no_of_worker)
        hired_worker = try values.decodeIfPresent(String.self, forKey: .hired_worker)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }

}
