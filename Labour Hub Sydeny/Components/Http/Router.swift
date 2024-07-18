//
//  Router.swift
//  Labour Hub Sydeny
//
//  Created by mac on 30/03/23.
//

import Foundation

enum Router: String {
    
    static let BASE_SERVICE_URL = "https://labourhubsydney.com.au/LabourHubSydney/webservice/"
    static let BASE_IMAGE_URL = "https://labourhubsydney.com.au/LabourHubSydney/uploads/images/"
    static let BASE_URL_POSTCODE = ""
    

    case logIn
    case clientSignUp
    case employeSignUp
    case AddProject
    case AddNewTimesheet
    case AddNewDocument
    case UpdateEmployeProfile
    case UpdateUserProfile
    case companyEmployeeProject
    case companyAssignedEmployee
    case ApproveStatus
    case ChangePassword
    
    public func url() -> String {
        switch self {
        case .clientSignUp:
            return Router.oAuthRoute(path: "user_signup")
        case .logIn:
            return Router.oAuthRoute(path: "login")
        case .AddProject:
            return Router.oAuthRoute(path: "add_project")
        case .AddNewTimesheet:
            return Router.oAuthRoute(path: "add_user_request_time_sheet")
        case .AddNewDocument:
            return Router.oAuthRoute(path: "add_user_document")
        case .UpdateEmployeProfile:
            return Router.oAuthRoute(path: "user_update_profile")
        case .UpdateUserProfile:
            return Router.oAuthRoute(path: "user_update_profile")
        case .companyEmployeeProject:
            return Router.oAuthRoute(path: "get_company_employee")
        case .employeSignUp:
            return Router.oAuthRoute(path: "employee_signup")
        case .companyAssignedEmployee:
            return Router.oAuthRoute(path: "assign_request_by_company")
        case .ApproveStatus:
            return Router.oAuthRoute(path: "set_approve")
        case .ChangePassword:
            return Router.oAuthRoute(path: "change_password")
        }
    }
    
    private static func oAuthRoute(path: String) -> String {
        return Router.BASE_SERVICE_URL + path
    }
}
