//
//  AdminProject.swift
//  Labour Hub Sydeny
//
//  Created by mac on 13/04/23.
//

import Foundation

struct GetAdminProject : Codable {
    let result : [ResAdminProject]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([ResAdminProject].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct ResAdminProject : Codable {
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
    let user_details : Admin_details?
    let user_request_images : [Company_User_request_images]?
    let service_list : [Admin_Service_list]?

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
        case user_details = "user_details"
        case user_request_images = "user_request_images"
        case service_list = "service_list"
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
        user_details = try values.decodeIfPresent(Admin_details.self, forKey: .user_details)
        user_request_images = try values.decodeIfPresent([Company_User_request_images].self, forKey: .user_request_images)
        service_list = try values.decodeIfPresent([Admin_Service_list].self, forKey: .service_list)
    }

}

struct Admin_details : Codable {
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
    let user_image : String?

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
        case user_image = "user_image"
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
        user_image = try values.decodeIfPresent(String.self, forKey: .user_image)
    }

}

struct Admin_Service_list : Codable {
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

struct Company_User_request_images : Codable {
    let id : String?
    let request_id : String?
    let image : String?
    let date_time : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case request_id = "request_id"
        case image = "image"
        case date_time = "date_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        request_id = try values.decodeIfPresent(String.self, forKey: .request_id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }

}
