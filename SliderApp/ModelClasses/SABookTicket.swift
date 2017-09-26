//
//  SABookTicket.swift
//  SliderApp
//
//  Created by Krati Agarwal on 10/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

class SABookTicket: NSObject {

    var netAmountString : String = ""
    var dateTime : Date!

    var dateString : String = ""
    var timeString : String = ""
    
    var weekNameString : String = ""
    var day : String = ""


    var ticketCount : Int = 01
    var totalAmount : String = ""
    var buyerName : String = ""
    var buyerEmail : String = ""
    var buyerMobileNumber : String = ""
    
    var ticketArray : NSMutableArray = ["10","20","30","40","50","60","70","80","90","100"]
    var shareArray : NSMutableArray = ["1","2","3","4","5"]

}
