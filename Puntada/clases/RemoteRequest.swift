//
//  RemoteRequest.swift
//  teammatch
//
//  Created by Softhink on 05/12/16.
//  Copyright © 2016 softhink. All rights reserved.
//
import Foundation
import Alamofire
import SwiftyJSON
import Messages
import UIKit
import KVNProgress
import Alamofire_SwiftyJSON
import AlamofireImage
class RemoteRequest {
    static func DownLoadImage( urlStr:String, imagen:UIImageView){
        Alamofire.request(urlStr ).responseImage { response in
           
            if case .success(let image) = response.result {
                imagen.image = image;
            }
             
        }
    }
    static func executePost(theURL :String, parameters :AnyObject?,
                     onCompleteCallback : @escaping (NSDictionary?) ->(),
                     onErrorCallback : @escaping () -> ()) {
        var url = URLRequest(url: NSURL(string:theURL)! as URL)
        url.httpMethod = "POST"
        url.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
        url.httpBody = try! JSONSerialization.data(withJSONObject: parameters as Any)
    
        Alamofire.request(url)
            .validate(statusCode: 200..<300)
            .responseJSON(completionHandler: { response in
                switch response.result {
                    case .success:
                        do {
                        if let json = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
                            let returnData : NSDictionary = json.object(forKey: "result") as!   NSDictionary
                            onCompleteCallback (returnData)
                        }
                        }catch let ex as Error{
                            onErrorCallback()
                            debugPrint(ex)
                        }
                    case .failure(let error):
                        print("problem encoding server info")
                        print(error.localizedDescription)
                        onErrorCallback()
                    
                }
            }
        );
    }
    }
//    requestUrl	URL	"http://softhink.mx/teammatch/PlayerTeamWS/FindPlayerTeam/"	
    static func jsonByRequestPost(requestUrl:URL,parameters:[String : Any],completeHandler:@escaping (_ jsonResult:JSON?) ->() ,errorHandler:((_ stringError:String?) ->())? ,loadingMessage:String?,view:UIView?,showDialogs:Bool){
        if showDialogs{
            KVNProgress.show(withStatus: loadingMessage == nil ? "Loading please wait...":loadingMessage,on:view)
        }
        do {
            var request = URLRequest(url:requestUrl)
            request.httpMethod = "POST"
            print(parameters)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
           
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
            debugPrint(parameters)
            Alamofire.request(request).responseSwiftyJSON(completionHandler:  { response in
                if showDialogs{
                    OperationQueue.main.addOperation {
                        KVNProgress.dismiss()
                    }
                }
                if let responsecode = response.response?.statusCode {
                    if (responsecode == 200){
                        let responseJSON:JSON = response.value!;
//                        print(response.value)
//                        print(responseJSON["result"]["message"])
                        if(responseJSON["result"]["success"].bool ?? false == false){
                            if showDialogs{OperationQueue.main.addOperation {
                                KVNProgress.showError(withStatus: responseJSON["result"]["message"].string,on:view)
                                return ;
                               }}
                            if(errorHandler != nil){
                                errorHandler!(responseJSON["result"]["message"].string);
                            }
                        }else{
                            completeHandler(responseJSON);
                            
                        }
                        
                    }else{
                        var error = ""
                        if(responsecode == 404){
                            error = "Servidor No Disponible."
                        }else{
                            error = String(data: response.data!, encoding: String.Encoding.utf8)!
                        }
                        if(errorHandler != nil){
                            errorHandler!(error)
                        }else{
                             if showDialogs{OperationQueue.main.addOperation {
                                KVNProgress.showError(withStatus: error,on:view)
                                }}
                        }
                    }
                }
            })
        }catch let ex as Error{
            if showDialogs{OperationQueue.main.addOperation {
                KVNProgress.dismiss()
                }}
            let error  =  ex.localizedDescription
            if(errorHandler != nil){
                errorHandler!(error)
            }else{
                if showDialogs{OperationQueue.main.addOperation {
                    KVNProgress.showError(withStatus: error,on:view)
                }}
                
            }
            return
        }
        
        
        
        
    }
    static func jsonByRequestSecurePost(requestUrl:URL,parameters:[String : Any],completeHandler:@escaping (_ jsonResult:JSON?) ->() ,errorHandler:((_ stringError:String?) ->())? ,loadingMessage:String?,view:UIView?,showDialogs:Bool){
        if showDialogs{
            KVNProgress.show(withStatus: loadingMessage == nil ? "Loading please wait...":loadingMessage,on:view)
        }
        do {
            var request = URLRequest(url:requestUrl)
            request.httpMethod = "POST"
            print(parameters)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let token:String = Utils.getDataAsString(key: "access_token")!
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
            
            Alamofire.request(request).responseSwiftyJSON(completionHandler:  { response in
                if showDialogs{
                    OperationQueue.main.addOperation {
                        KVNProgress.dismiss()
                    }
                }
                if let responsecode = response.response?.statusCode {
                    if (responsecode == 200){
                        let responseJSON:JSON = response.value!;
//                        print(response.value)
//                        print(responseJSON["result"]["message"])
                        if(responseJSON["result"]["success"].bool ?? false == false){
                            if showDialogs{OperationQueue.main.addOperation {
                                KVNProgress.showError(withStatus: responseJSON["result"]["message"].string,on:view)
                                return ;
                               }}
                            if(errorHandler != nil){
                                errorHandler!(responseJSON["result"]["message"].string);
                            }
                        }else{
                            completeHandler(responseJSON);
                            
                        }
                        
                    }else{
                        var error = ""
                        if(responsecode == 404){
                            error = "Servidor no disponible, Favor de intentar Mms tarde."
                        }else{
                            error = String(data: response.data!, encoding: String.Encoding.utf8)!
                        }
                        if(errorHandler != nil){
                            errorHandler!(error)
                        }else{
                             if showDialogs{OperationQueue.main.addOperation {
                                KVNProgress.showError(withStatus: error,on:view)
                                }}
                        }
                    }
                }
            })
        }catch let ex as Error{
            if showDialogs{OperationQueue.main.addOperation {
                KVNProgress.dismiss()
                }}
            let error  =  ex.localizedDescription
            if(errorHandler != nil){
                errorHandler!(error)
            }else{
                if showDialogs{OperationQueue.main.addOperation {
                    KVNProgress.showError(withStatus: error,on:view)
                }}
                
            }
            return
        }
        
        
        
    }
    
    
}
