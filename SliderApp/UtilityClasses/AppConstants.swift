//
//  AppConstants.swift
//  IndustryPlatter
//
//  Created by Krati Agarwal on 12/05/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import Foundation

/************************************ Storyboards ************************************/

let mainStoryboardString                   = "Main"
let settingsStoryboardString               = "Settings"
let homeStoryboardString                   = "Home"
let menuStoryboardString                   = "Menu"

let servicesStoryboardString               = "Services"
let leadStoryboardString                   = "Lead"

/************************************ WEB API **************************************/
let pApiName                                = ""
let pMessage                                = "responseMessage"
//let pResponseCode                           = "responseCode"
//let pAction                                 = "action"
let pType                                   = "type"
let pFeedback                               = "feedback"
let pRating                                 = "rating"
let pNewPassword                            = "newpass"
let pOldPassword                            = "oldpass"
let pProductId                              = "id"
let pStatus                                 = "status"
let pPageSize                               = "pageSize"
let pPageNo                                 = "pageNo"


func TRIM_SPACE(str: Any) -> Any {
    return (str as AnyObject).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
}
