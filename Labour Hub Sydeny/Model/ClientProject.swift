//
//  ClientProject.swift
//  Labour Hub Sydeny
//
//  Created by mac on 17/04/23.
//

import Foundation

struct GetClientProject : Codable {
    let result : [ResClientProjectDetail]?
    let status : String?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case status = "status"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([ResClientProjectDetail].self, forKey: .result)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
}

struct ResClientProjectDetail : Codable {
    let id : String?
    let store_id : String?
    let first_name : String?
    let last_name : String?
    let store_name : String?
    let company_name : String?
    let company_code : String?
    let aBN_number : String?
    let mobile : String?
    let mobile_with_code : String?
    let email : String?
    let password : String?
    let country_id : String?
    let state_id : String?
    let state_name : String?
    let city_id : String?
    let city_name : String?
    let image : String?
    let type : String?
    let social_id : String?
    let lat : String?
    let lon : String?
    let address : String?
    let addresstype : String?
    let address_id : String?
    let gender : String?
    let gender_type : String?
    let wallet : String?
    let licence_image : String?
    let licence_id : String?
    let licence_issue_date : String?
    let licence_expire_date : String?
    let register_id : String?
    let ios_register_id : String?
    let status : String?
    let bank_account : String?
    let bank_branch : String?
    let approve_status : String?
    let available_status : String?
    let code : String?
    let date_time : String?
    let cat_id : String?
    let cat_name : String?
    let bank_name : String?
    let branch_name : String?
    let iban_id : String?
    let account_number : String?
    let skill : String?
    let bank_emirates : String?
    let owner_name : String?
    let tax_number : String?
    let store_logo : String?
    let store_cover_image : String?
    let about_store : String?
    let outdoor_service : String?
    let indoor_service : String?
    let note : String?
    let note_block : String?
    let block_unblock : String?
    let remove_status : String?
    let open_time : String?
    let close_time : String?
    let store_ope_closs_status : String?
    let hr_rate : String?
    let discount : String?
    let gST : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case store_id = "store_id"
        case first_name = "first_name"
        case last_name = "last_name"
        case store_name = "store_name"
        case company_name = "company_name"
        case company_code = "company_code"
        case aBN_number = "ABN_number"
        case mobile = "mobile"
        case mobile_with_code = "mobile_with_code"
        case email = "email"
        case password = "password"
        case country_id = "country_id"
        case state_id = "state_id"
        case state_name = "state_name"
        case city_id = "city_id"
        case city_name = "city_name"
        case image = "image"
        case type = "type"
        case social_id = "social_id"
        case lat = "lat"
        case lon = "lon"
        case address = "address"
        case addresstype = "addresstype"
        case address_id = "address_id"
        case gender = "gender"
        case gender_type = "gender_type"
        case wallet = "wallet"
        case licence_image = "licence_image"
        case licence_id = "licence_id"
        case licence_issue_date = "licence_issue_date"
        case licence_expire_date = "licence_expire_date"
        case register_id = "register_id"
        case ios_register_id = "ios_register_id"
        case status = "status"
        case bank_account = "bank_account"
        case bank_branch = "bank_branch"
        case approve_status = "approve_status"
        case available_status = "available_status"
        case code = "code"
        case date_time = "date_time"
        case cat_id = "cat_id"
        case cat_name = "cat_name"
        case bank_name = "bank_name"
        case branch_name = "branch_name"
        case iban_id = "Iban_id"
        case account_number = "account_number"
        case skill = "skill"
        case bank_emirates = "bank_emirates"
        case owner_name = "owner_name"
        case tax_number = "tax_number"
        case store_logo = "store_logo"
        case store_cover_image = "store_cover_image"
        case about_store = "about_store"
        case outdoor_service = "outdoor_service"
        case indoor_service = "indoor_service"
        case note = "note"
        case note_block = "note_block"
        case block_unblock = "block_unblock"
        case remove_status = "remove_status"
        case open_time = "open_time"
        case close_time = "close_time"
        case store_ope_closs_status = "store_ope_closs_status"
        case hr_rate = "hr_rate"
        case discount = "discount"
        case gST = "GST"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        store_id = try values.decodeIfPresent(String.self, forKey: .store_id)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        store_name = try values.decodeIfPresent(String.self, forKey: .store_name)
        company_name = try values.decodeIfPresent(String.self, forKey: .company_name)
        company_code = try values.decodeIfPresent(String.self, forKey: .company_code)
        aBN_number = try values.decodeIfPresent(String.self, forKey: .aBN_number)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        mobile_with_code = try values.decodeIfPresent(String.self, forKey: .mobile_with_code)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        country_id = try values.decodeIfPresent(String.self, forKey: .country_id)
        state_id = try values.decodeIfPresent(String.self, forKey: .state_id)
        state_name = try values.decodeIfPresent(String.self, forKey: .state_name)
        city_id = try values.decodeIfPresent(String.self, forKey: .city_id)
        city_name = try values.decodeIfPresent(String.self, forKey: .city_name)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        social_id = try values.decodeIfPresent(String.self, forKey: .social_id)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lon = try values.decodeIfPresent(String.self, forKey: .lon)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        addresstype = try values.decodeIfPresent(String.self, forKey: .addresstype)
        address_id = try values.decodeIfPresent(String.self, forKey: .address_id)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        gender_type = try values.decodeIfPresent(String.self, forKey: .gender_type)
        wallet = try values.decodeIfPresent(String.self, forKey: .wallet)
        licence_image = try values.decodeIfPresent(String.self, forKey: .licence_image)
        licence_id = try values.decodeIfPresent(String.self, forKey: .licence_id)
        licence_issue_date = try values.decodeIfPresent(String.self, forKey: .licence_issue_date)
        licence_expire_date = try values.decodeIfPresent(String.self, forKey: .licence_expire_date)
        register_id = try values.decodeIfPresent(String.self, forKey: .register_id)
        ios_register_id = try values.decodeIfPresent(String.self, forKey: .ios_register_id)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        bank_account = try values.decodeIfPresent(String.self, forKey: .bank_account)
        bank_branch = try values.decodeIfPresent(String.self, forKey: .bank_branch)
        approve_status = try values.decodeIfPresent(String.self, forKey: .approve_status)
        available_status = try values.decodeIfPresent(String.self, forKey: .available_status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        cat_id = try values.decodeIfPresent(String.self, forKey: .cat_id)
        cat_name = try values.decodeIfPresent(String.self, forKey: .cat_name)
        bank_name = try values.decodeIfPresent(String.self, forKey: .bank_name)
        branch_name = try values.decodeIfPresent(String.self, forKey: .branch_name)
        iban_id = try values.decodeIfPresent(String.self, forKey: .iban_id)
        account_number = try values.decodeIfPresent(String.self, forKey: .account_number)
        skill = try values.decodeIfPresent(String.self, forKey: .skill)
        bank_emirates = try values.decodeIfPresent(String.self, forKey: .bank_emirates)
        owner_name = try values.decodeIfPresent(String.self, forKey: .owner_name)
        tax_number = try values.decodeIfPresent(String.self, forKey: .tax_number)
        store_logo = try values.decodeIfPresent(String.self, forKey: .store_logo)
        store_cover_image = try values.decodeIfPresent(String.self, forKey: .store_cover_image)
        about_store = try values.decodeIfPresent(String.self, forKey: .about_store)
        outdoor_service = try values.decodeIfPresent(String.self, forKey: .outdoor_service)
        indoor_service = try values.decodeIfPresent(String.self, forKey: .indoor_service)
        note = try values.decodeIfPresent(String.self, forKey: .note)
        note_block = try values.decodeIfPresent(String.self, forKey: .note_block)
        block_unblock = try values.decodeIfPresent(String.self, forKey: .block_unblock)
        remove_status = try values.decodeIfPresent(String.self, forKey: .remove_status)
        open_time = try values.decodeIfPresent(String.self, forKey: .open_time)
        close_time = try values.decodeIfPresent(String.self, forKey: .close_time)
        store_ope_closs_status = try values.decodeIfPresent(String.self, forKey: .store_ope_closs_status)
        hr_rate = try values.decodeIfPresent(String.self, forKey: .hr_rate)
        discount = try values.decodeIfPresent(String.self, forKey: .discount)
        gST = try values.decodeIfPresent(String.self, forKey: .gST)
    }
}
