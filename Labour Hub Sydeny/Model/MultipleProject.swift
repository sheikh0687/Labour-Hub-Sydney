//
//  MultipleProject.swift
//  Labour Hub Sydeny
//
//  Created by Techimmense Software Solutions on 15/07/23.
//

import Foundation

struct ApiMultipleProject : Codable {
    let result : [ResMultipleProjects]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([ResMultipleProjects].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct ResMultipleProjects : Codable {
    let id : String?
    let request_id : String?
    let request_service_id : String?
    let client_id : String?
    let employee_id : String?
    let date_time : String?
    let project_details : Multiple_Project_details?
    let service_list : Multiple_Service_list?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case request_id = "request_id"
        case request_service_id = "request_service_id"
        case client_id = "client_id"
        case employee_id = "employee_id"
        case date_time = "date_time"
        case project_details = "project_details"
        case service_list = "service_list"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        request_id = try values.decodeIfPresent(String.self, forKey: .request_id)
        request_service_id = try values.decodeIfPresent(String.self, forKey: .request_service_id)
        client_id = try values.decodeIfPresent(String.self, forKey: .client_id)
        employee_id = try values.decodeIfPresent(String.self, forKey: .employee_id)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        project_details = try values.decodeIfPresent(Multiple_Project_details.self, forKey: .project_details)
        service_list = try values.decodeIfPresent(Multiple_Service_list.self, forKey: .service_list)
    }

}

struct Multiple_Project_details : Codable {
    let id : String?
    let user_id : String?
    let title : String?
    let company_code : String?
    let company_id : String?
    let cat_id : String?
    let cat_name : String?
    let start_date : String?
    let start_time : String?
    let end_date : String?
    let end_time : String?
    let no_of_worker : String?
    let provider_id : String?
    let accept_provider_id : String?
    let cart_id : String?
    let total_amount : String?
    let barber_amount : String?
    let admin_commission : String?
    let admin_VAT : String?
    let discount : String?
    let date : String?
    let time : String?
    let accept_one_hr : String?
    let time1 : String?
    let address : String?
    let lat : String?
    let lon : String?
    let address_id : String?
    let offer_id : String?
    let offer_code : String?
    let unique_code : String?
    let description : String?
    let time_slot : String?
    let required_hour : String?
    let required_worker : String?
    let payment_type : String?
    let payment_status : String?
    let emp_id : String?
    let emp_name : String?
    let emp_image : String?
    let emp_gender : String?
    let status : String?
    let date_time : String?
    let date_time_last : String?
    let date_time_two_hr : String?
    let timezone : String?
    let request_type : String?
    let reason_title : String?
    let reason_detail : String?
    let extra_service_name : String?
    let extra_service_price : String?
    let extra_service_payment_type : String?
    let extra_service_id : String?
    let payment_confirmation : String?
    let total_worker_count : String?
    let hired_worker_count : String?
    let total_time : String?
    let total_time_in_min : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case title = "title"
        case company_code = "company_code"
        case company_id = "company_id"
        case cat_id = "cat_id"
        case cat_name = "cat_name"
        case start_date = "start_date"
        case start_time = "start_time"
        case end_date = "end_date"
        case end_time = "end_time"
        case no_of_worker = "no_of_worker"
        case provider_id = "provider_id"
        case accept_provider_id = "accept_provider_id"
        case cart_id = "cart_id"
        case total_amount = "total_amount"
        case barber_amount = "barber_amount"
        case admin_commission = "admin_commission"
        case admin_VAT = "admin_VAT"
        case discount = "discount"
        case date = "date"
        case time = "time"
        case accept_one_hr = "accept_one_hr"
        case time1 = "time1"
        case address = "address"
        case lat = "lat"
        case lon = "lon"
        case address_id = "address_id"
        case offer_id = "offer_id"
        case offer_code = "offer_code"
        case unique_code = "unique_code"
        case description = "description"
        case time_slot = "time_slot"
        case required_hour = "required_hour"
        case required_worker = "required_worker"
        case payment_type = "payment_type"
        case payment_status = "payment_status"
        case emp_id = "emp_id"
        case emp_name = "emp_name"
        case emp_image = "emp_image"
        case emp_gender = "emp_gender"
        case status = "status"
        case date_time = "date_time"
        case date_time_last = "date_time_last"
        case date_time_two_hr = "date_time_two_hr"
        case timezone = "timezone"
        case request_type = "request_type"
        case reason_title = "reason_title"
        case reason_detail = "reason_detail"
        case extra_service_name = "extra_service_name"
        case extra_service_price = "extra_service_price"
        case extra_service_payment_type = "extra_service_payment_type"
        case extra_service_id = "extra_service_id"
        case payment_confirmation = "payment_confirmation"
        case total_worker_count = "total_worker_count"
        case hired_worker_count = "hired_worker_count"
        case total_time = "total_time"
        case total_time_in_min = "total_time_in_min"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        company_code = try values.decodeIfPresent(String.self, forKey: .company_code)
        company_id = try values.decodeIfPresent(String.self, forKey: .company_id)
        cat_id = try values.decodeIfPresent(String.self, forKey: .cat_id)
        cat_name = try values.decodeIfPresent(String.self, forKey: .cat_name)
        start_date = try values.decodeIfPresent(String.self, forKey: .start_date)
        start_time = try values.decodeIfPresent(String.self, forKey: .start_time)
        end_date = try values.decodeIfPresent(String.self, forKey: .end_date)
        end_time = try values.decodeIfPresent(String.self, forKey: .end_time)
        no_of_worker = try values.decodeIfPresent(String.self, forKey: .no_of_worker)
        provider_id = try values.decodeIfPresent(String.self, forKey: .provider_id)
        accept_provider_id = try values.decodeIfPresent(String.self, forKey: .accept_provider_id)
        cart_id = try values.decodeIfPresent(String.self, forKey: .cart_id)
        total_amount = try values.decodeIfPresent(String.self, forKey: .total_amount)
        barber_amount = try values.decodeIfPresent(String.self, forKey: .barber_amount)
        admin_commission = try values.decodeIfPresent(String.self, forKey: .admin_commission)
        admin_VAT = try values.decodeIfPresent(String.self, forKey: .admin_VAT)
        discount = try values.decodeIfPresent(String.self, forKey: .discount)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        time = try values.decodeIfPresent(String.self, forKey: .time)
        accept_one_hr = try values.decodeIfPresent(String.self, forKey: .accept_one_hr)
        time1 = try values.decodeIfPresent(String.self, forKey: .time1)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lon = try values.decodeIfPresent(String.self, forKey: .lon)
        address_id = try values.decodeIfPresent(String.self, forKey: .address_id)
        offer_id = try values.decodeIfPresent(String.self, forKey: .offer_id)
        offer_code = try values.decodeIfPresent(String.self, forKey: .offer_code)
        unique_code = try values.decodeIfPresent(String.self, forKey: .unique_code)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        time_slot = try values.decodeIfPresent(String.self, forKey: .time_slot)
        required_hour = try values.decodeIfPresent(String.self, forKey: .required_hour)
        required_worker = try values.decodeIfPresent(String.self, forKey: .required_worker)
        payment_type = try values.decodeIfPresent(String.self, forKey: .payment_type)
        payment_status = try values.decodeIfPresent(String.self, forKey: .payment_status)
        emp_id = try values.decodeIfPresent(String.self, forKey: .emp_id)
        emp_name = try values.decodeIfPresent(String.self, forKey: .emp_name)
        emp_image = try values.decodeIfPresent(String.self, forKey: .emp_image)
        emp_gender = try values.decodeIfPresent(String.self, forKey: .emp_gender)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        date_time_last = try values.decodeIfPresent(String.self, forKey: .date_time_last)
        date_time_two_hr = try values.decodeIfPresent(String.self, forKey: .date_time_two_hr)
        timezone = try values.decodeIfPresent(String.self, forKey: .timezone)
        request_type = try values.decodeIfPresent(String.self, forKey: .request_type)
        reason_title = try values.decodeIfPresent(String.self, forKey: .reason_title)
        reason_detail = try values.decodeIfPresent(String.self, forKey: .reason_detail)
        extra_service_name = try values.decodeIfPresent(String.self, forKey: .extra_service_name)
        extra_service_price = try values.decodeIfPresent(String.self, forKey: .extra_service_price)
        extra_service_payment_type = try values.decodeIfPresent(String.self, forKey: .extra_service_payment_type)
        extra_service_id = try values.decodeIfPresent(String.self, forKey: .extra_service_id)
        payment_confirmation = try values.decodeIfPresent(String.self, forKey: .payment_confirmation)
        total_worker_count = try values.decodeIfPresent(String.self, forKey: .total_worker_count)
        hired_worker_count = try values.decodeIfPresent(String.self, forKey: .hired_worker_count)
        total_time = try values.decodeIfPresent(String.self, forKey: .total_time)
        total_time_in_min = try values.decodeIfPresent(String.self, forKey: .total_time_in_min)
    }

}

struct Multiple_Service_list : Codable {
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
