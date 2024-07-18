//
//  UserRequestInvoice.swift
//  Labour Hub Sydeny
//
//  Created by mac on 20/04/23.
//

import Foundation

struct GetUserRequestInvoice : Codable {
    let result : [ResRequestedInvoice]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([ResRequestedInvoice].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}
struct ResRequestedInvoice : Codable {
    let id : String?
    let user_id : String?
    let project_id : String?
    let company_id : String?
    let company_code : String?
    let invoicedate : String?
    let due_date : String?
    let invoicenumber : String?
    let companyname : String?
    let companyaddress : String?
    let projecttitle : String?
    let projectaddress : String?
    let subtotal : String?
    let totalgst : String?
    let totalaud : String?
    let status : String?
    let dare_time : String?
    let service_lis : [Requested_Service_lis]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case project_id = "project_id"
        case company_id = "company_id"
        case company_code = "company_code"
        case invoicedate = "invoicedate"
        case due_date = "due_date"
        case invoicenumber = "invoicenumber"
        case companyname = "companyname"
        case companyaddress = "companyaddress"
        case projecttitle = "projecttitle"
        case projectaddress = "projectaddress"
        case subtotal = "subtotal"
        case totalgst = "totalgst"
        case totalaud = "totalaud"
        case status = "status"
        case dare_time = "dare_time"
        case service_lis = "service_lis"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        project_id = try values.decodeIfPresent(String.self, forKey: .project_id)
        company_id = try values.decodeIfPresent(String.self, forKey: .company_id)
        company_code = try values.decodeIfPresent(String.self, forKey: .company_code)
        invoicedate = try values.decodeIfPresent(String.self, forKey: .invoicedate)
        due_date = try values.decodeIfPresent(String.self, forKey: .due_date)
        invoicenumber = try values.decodeIfPresent(String.self, forKey: .invoicenumber)
        companyname = try values.decodeIfPresent(String.self, forKey: .companyname)
        companyaddress = try values.decodeIfPresent(String.self, forKey: .companyaddress)
        projecttitle = try values.decodeIfPresent(String.self, forKey: .projecttitle)
        projectaddress = try values.decodeIfPresent(String.self, forKey: .projectaddress)
        subtotal = try values.decodeIfPresent(String.self, forKey: .subtotal)
        totalgst = try values.decodeIfPresent(String.self, forKey: .totalgst)
        totalaud = try values.decodeIfPresent(String.self, forKey: .totalaud)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        dare_time = try values.decodeIfPresent(String.self, forKey: .dare_time)
        service_lis = try values.decodeIfPresent([Requested_Service_lis].self, forKey: .service_lis)
    }
}

struct Requested_Service_lis : Codable {
    let id : String?
    let user_request_invoice_id : String?
    let request_service_id : String?
    let cat_id : String?
    let cat_name : String?
    let noOfWorker : String?
    let hrRate : String?
    let totalWorkHour : String?
    let extraTotalTime : String?
    let discount : String?
    let gst : String?
    let fianlPayAmount : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_request_invoice_id = "user_request_invoice_id"
        case request_service_id = "request_service_id"
        case cat_id = "cat_id"
        case cat_name = "cat_name"
        case noOfWorker = "NoOfWorker"
        case hrRate = "HrRate"
        case totalWorkHour = "TotalWorkHour"
        case extraTotalTime = "ExtraTotalTime"
        case discount = "Discount"
        case gst = "Gst"
        case fianlPayAmount = "FianlPayAmount"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_request_invoice_id = try values.decodeIfPresent(String.self, forKey: .user_request_invoice_id)
        request_service_id = try values.decodeIfPresent(String.self, forKey: .request_service_id)
        cat_id = try values.decodeIfPresent(String.self, forKey: .cat_id)
        cat_name = try values.decodeIfPresent(String.self, forKey: .cat_name)
        noOfWorker = try values.decodeIfPresent(String.self, forKey: .noOfWorker)
        hrRate = try values.decodeIfPresent(String.self, forKey: .hrRate)
        totalWorkHour = try values.decodeIfPresent(String.self, forKey: .totalWorkHour)
        extraTotalTime = try values.decodeIfPresent(String.self, forKey: .extraTotalTime)
        discount = try values.decodeIfPresent(String.self, forKey: .discount)
        gst = try values.decodeIfPresent(String.self, forKey: .gst)
        fianlPayAmount = try values.decodeIfPresent(String.self, forKey: .fianlPayAmount)
    }

}
