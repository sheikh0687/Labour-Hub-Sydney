//
//  Constant.swift
//  Labour Hub Sydeny
//
//  Created by Techimmense Software Solutions on 23/05/23.
//

import UIKit

struct k {
    
    static let appName                                      =      "Labour Hub Sydney"
    static var iosRegisterId                                =      "123456"
    static let emptyString                                  =      ""
    static let userDefault                                  =      UserDefaults.standard
    static let userType                                     =      "USER"
    static let employeType                                  =      "EMPLOYEE"
    static let currency                                     =      "$"
    static let themeColor                                   =      ""
    static let navigationColor                              =      ""
    
    struct languages
    {
        struct english
        {
            
            static let urlTermsCondition                    =      ""
            static let urlPrivacyPolicy                     =      ""
            static let urlAboutus                           =      ""
            static let urlhelp                              =      ""
            static let urlEULA                              =      ""
            
        }
    }
    
    struct session {
        static let status                                   =      "status"
        static let userId                                   =      "user_id"
        static let userName                                 =      "user_name"
        static let userEmail                                =      "email"
        static let userType                                 =      "type"
        static let commonCompanyCode                        =      "company_code"
        static let stripeCustomerId                         =      ""
        static let catShortCode                             =      ""
        static let onlineStatus                             =      ""
        static let categoryId                               =      "category_id"
        static let subCategoryId                            =      "sub_cat_id"
        static let userImage                                =      "user_image"
        static let interestedRestId                         =      "interested_rest_id"
        static let lat                                      =      "lat"
        static let lon                                      =      "lon"
        static let restaurantName                           =      ""
        static let userLogin                                =      ""
        
        static let ads                                      =      ""
        static let gambling                                 =      ""
        static let malware                                  =      ""
        static let phishing                                 =      ""
        static let spyware                                  =      ""
        
        static let language                                 =      ""
        static let rejectCount                              =      ""
        static let currentCompanyId                         =      ""
    }
    
    
    struct google {
        static let googleApiKey                             =      ""
        static let googleClientId                           =      ""
    }
    
    struct facebook {
        static let facebookId                               =      ""
    }
    
    static var menuWidth: CGFloat                           =      0.0
    static var topMargin: CGFloat                           =      0.0
}

