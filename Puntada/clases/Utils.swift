//
//  Utils.swift
//  InWifi
//
//  Created by Softhink on 25/08/15.
//  Copyright (c) 2015 Softhink. All rights reserved.
//

import Foundation
import  SwiftyJSON

class Utils{
    static func shadowButton(boton:UIButton){
        
        boton.layer.shadowColor = UIColor.black.cgColor
        boton.layer.shadowOffset = CGSize(width: 2, height: 2)
        boton.layer.shadowRadius = 5
        boton.layer.shadowOpacity = 1.0
    }
    static func shadowView(view:UIView){
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 1.0
    }
   static func doLogin(response:JSON ){
          Utils.setData(data: response["result"]["access_token"].string ?? "" , key: "access_token")
        actualizarDatosUsuario(response: response)
        
         
    }
    static func actualizarDatosUsuario(response:JSON ){
         Utils.setData(data: response["result"]["user_data"]["usu_nombre"].string ?? "", key: "usu_nombre")
         Utils.setData(data: response["result"]["user_data"]["usu_apellido"].string ?? "", key: "usu_apellido")
         Utils.setData(data: response["result"]["user_data"]["usu_imagen"].string ?? "", key: "usu_imagen")
         Utils.setData(data: response["result"]["user_data"]["usu_correo"].string ?? ""  , key: "usu_correo")
         Utils.setData(data: String(response["result"]["user_data"]["usu_mes_nacimiento"].int ?? 1)  , key: "usu_mes_nacimiento")
         Utils.setData(data: String(response["result"]["user_data"]["usu_dia_nacimiento"].int ?? 1)  , key: "usu_dia_nacimiento")
         Utils.setData(data: response["result"]["user_data"]["usu_telefono"].string ?? ""  , key: "usu_telefono")
         Utils.setData(data: response["result"]["user_data"]["additional_data"]["dat_tarjeta"].string ?? ""  , key: "dat_tarjeta")
         Utils.setData(data: String(response["result"]["user_data"]["additional_data"]["total_card_points"].int ?? 0) , key: "total_card_points")
          
         
         
          
     }
    static func isValidEmail(_ testStr:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    static func getInt(_ object : AnyObject) -> Int{
        
        if let stringResult = object as? NSString {
            if let myNumber = NumberFormatter().number(from: stringResult as String){
                return myNumber.intValue;
            }
        }
        
            return 0;
        
    }
    
    
    static func getDate(_ object: AnyObject,dateFormat:String) -> Date{
        let dateFormatter = Foundation.DateFormatter()
        dateFormatter.dateFormat = dateFormat
        if let stringDate = object as? String{
            if let date = dateFormatter.date(from: stringDate){
                return date
            }
        }
        return Date()
    }
    static func getString(_ object:AnyObject)->String{
        if let stringResult = object as? NSString{
            return Utils.textoDecode(stringResult as String)
        }
        
        return "";
        
    }
    static func getId() -> String{
        let format = Foundation.DateFormatter()
        format.dateFormat="yyyyMMddHHmmss"
        let dt:Date = Date()
        return  format.string(from: dt)
    }
    static func setData(data:Any , key:String){
        let defaults = UserDefaults.standard;
        defaults.set(data, forKey: key)
        UserDefaults.standard.synchronize()
    }
    static func getData(key:String)->Any{
        let defaults = UserDefaults.standard;
        return defaults.value(forKey: key) as Any ;
    }
    static func getDataAsString(key:String)->String? {
        let defaults = UserDefaults.standard;
        return defaults.value(forKey: key)  as? String ;
    }
    static func textoDecode(_ vParametro:String)->String{
        let vRetorno = vParametro.replacingOccurrences(of: "+", with: " ", options: NSString.CompareOptions.literal, range: nil).replacingOccurrences(of: "%27", with: "'", options: NSString.CompareOptions.literal, range: nil)
        return vRetorno;
    }
    static func runAfterDelay(_ delay: TimeInterval, block: @escaping ()->()) {
        let time = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time, execute: block)
    }
    
}
