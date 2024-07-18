//
//  SaveRequestedInvoice.swift
//  Labour Hub Sydeny
//
//  Created by mac on 02/05/23.
//

import Foundation

struct SaveRequestedInvoice : Codable {
    let result : ResSaveRequestedInvoice?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(ResSaveRequestedInvoice.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct ResSaveRequestedInvoice : Codable {
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
    }

}
