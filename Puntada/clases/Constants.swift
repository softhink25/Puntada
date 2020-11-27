//
//  Constants.swift
//  Puntada
//
//  Created by José Ibarra Martínez on 06/11/20.
//  Copyright © 2020 Softhink. All rights reserved.
//

import UIKit

class Constants: NSObject {
    static var SERVER:String = "http://puntada.sft.com.mx/";
    static var WEBRESOURCES:String = "webresources/"
    static var USER_WS:String = SERVER+WEBRESOURCES+"UserWS/"
    static var PARAMETER_WS:String = SERVER+WEBRESOURCES+"ParameterWS/"
    static var LOGIN = USER_WS+"Login"
    static var CREATE_CODE = USER_WS+"CreateCode"
    static var CONFIRM_CODE = USER_WS+"ConfirmCode"
    static var ACCEPTAR = USER_WS+"Accept"
    static var FB_LOGIN = USER_WS+"FacebookRegister"
    static var CONSULTAR_DATOS_USUARIO = USER_WS+"GetUserData"
    static var GUARDAR_USUARIO = USER_WS+"UpdateProfile"
    
    static var OBTENER_PARAMETRO = PARAMETER_WS+"GetParameterValueOpen"
    static var CAMBIAR_CONTRASENA = USER_WS+"ChangePassword"
    static var PROMOCION_SERVLET = SERVER+"Promotion"
    static var OBTENER_PROMOCION_LOGO = PROMOCION_SERVLET+"?ACT=ObtenerLogo"
    static var OBTENER_PROMOCION_IMAGEN = PROMOCION_SERVLET+"?ACT=ObtenerImagen"
    static var PROMOCION_WS = SERVER+WEBRESOURCES+"PromotionsWS"
    static var OBTENER_PROMOCIONES = PROMOCION_WS+"/GetPromotions"
}
