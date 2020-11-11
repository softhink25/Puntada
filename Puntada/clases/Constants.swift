//
//  Constants.swift
//  Puntada
//
//  Created by José Ibarra Martínez on 06/11/20.
//  Copyright © 2020 Softhink. All rights reserved.
//

import UIKit

class Constants: NSObject {
    static var SERVER:String = "http://softhink.ddns.net:8888/PuntadaWeb/";
    static var WEBRESOURCES:String = "webresources/"
    static var USER_WS:String = SERVER+WEBRESOURCES+"UserWS/"
    static var LOGIN = USER_WS+"Login"
    static var FB_LOGIN = USER_WS+"FacebookRegister"
    
}
