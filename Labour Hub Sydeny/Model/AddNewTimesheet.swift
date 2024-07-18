//
//  AddNewTimesheet.swift
//  Labour Hub Sydeny
//
//  Created by mac on 14/04/23.
//

import Foundation

struct NewTimesheet : Codable {
    let result : ResNewTimeSheet?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(ResNewTimeSheet.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct ResNewTimeSheet : Codable {
    let id : String?
    let request_id : String?
    let request_service_id : String?
    let assign_id : String?
    let client_id : String?
    let worker_id : String?
    let site_manager_name : String?
    let lunch_break_duration : String?
    let signature_image : String?
    let status : String?
    let date_time : String?
    let date : String?
    let start_time : String?
    let end_time : String?
    let total_time : String?
    let total_time_min : String?
    let extra_total_time : String?
    let extra_total_time_min : String?
    let total_amount : String?
    let hr_rate : String?
    let gST : String?
    let discount : String?
    let gst_amount : String?
    let discount_amount : String?
    let signature : String?
    let start_date : String?
    let signature_status : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case request_id = "request_id"
        case request_service_id = "request_service_id"
        case assign_id = "assign_id"
        case client_id = "client_id"
        case worker_id = "worker_id"
        case site_manager_name = "site_manager_name"
        case lunch_break_duration = "lunch_break_duration"
        case signature_image = "signature_image"
        case status = "status"
        case date_time = "date_time"
        case date = "date"
        case start_time = "start_time"
        case end_time = "end_time"
        case total_time = "total_time"
        case total_time_min = "total_time_min"
        case extra_total_time = "extra_total_time"
        case extra_total_time_min = "extra_total_time_min"
        case total_amount = "total_amount"
        case hr_rate = "hr_rate"
        case gST = "GST"
        case discount = "discount"
        case gst_amount = "gst_amount"
        case discount_amount = "discount_amount"
        case signature = "signature"
        case start_date = "start_date"
        case signature_status = "signature_status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        request_id = try values.decodeIfPresent(String.self, forKey: .request_id)
        request_service_id = try values.decodeIfPresent(String.self, forKey: .request_service_id)
        assign_id = try values.decodeIfPresent(String.self, forKey: .assign_id)
        client_id = try values.decodeIfPresent(String.self, forKey: .client_id)
        worker_id = try values.decodeIfPresent(String.self, forKey: .worker_id)
        site_manager_name = try values.decodeIfPresent(String.self, forKey: .site_manager_name)
        lunch_break_duration = try values.decodeIfPresent(String.self, forKey: .lunch_break_duration)
        signature_image = try values.decodeIfPresent(String.self, forKey: .signature_image)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        start_time = try values.decodeIfPresent(String.self, forKey: .start_time)
        end_time = try values.decodeIfPresent(String.self, forKey: .end_time)
        total_time = try values.decodeIfPresent(String.self, forKey: .total_time)
        total_time_min = try values.decodeIfPresent(String.self, forKey: .total_time_min)
        extra_total_time = try values.decodeIfPresent(String.self, forKey: .extra_total_time)
        extra_total_time_min = try values.decodeIfPresent(String.self, forKey: .extra_total_time_min)
        total_amount = try values.decodeIfPresent(String.self, forKey: .total_amount)
        hr_rate = try values.decodeIfPresent(String.self, forKey: .hr_rate)
        gST = try values.decodeIfPresent(String.self, forKey: .gST)
        discount = try values.decodeIfPresent(String.self, forKey: .discount)
        gst_amount = try values.decodeIfPresent(String.self, forKey: .gst_amount)
        discount_amount = try values.decodeIfPresent(String.self, forKey: .discount_amount)
        signature = try values.decodeIfPresent(String.self, forKey: .signature)
        start_date = try values.decodeIfPresent(String.self, forKey: .start_date)
        signature_status = try values.decodeIfPresent(String.self, forKey: .signature_status)
    }

}
