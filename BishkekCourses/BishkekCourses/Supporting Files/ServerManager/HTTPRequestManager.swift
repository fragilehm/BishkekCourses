////
////  HTTPRequestManager.swift
////  CafeService
////
////  Created by ITLabAdmin on 7/19/17.
////  Copyright © 2017 NeoBis. All rights reserved.
////
//import Foundation
//import Alamofire
//import SwiftyJSON
//import SystemConfiguration
//
//class HTTPRequestManager {
//
//    typealias SuccessHandler = (JSON) -> Void
//    typealias FailureHandler = (String)-> Void
//    typealias Parameter = [String: Any]?
//
//    private func request(method: HTTPMethod, endpoint: String, parameters: Parameter, header: String, completion: @escaping SuccessHandler, error: @escaping FailureHandler) {
//        if !isConnectedToNetwork() {
//            error(Constants.Network.ErrorMessage.NO_INTERNET_CONNECTION)
//            return
//        }
//        let apiUrl = ApiAddressLink(endpoint: endpoint).getURLString()
//        let head: HTTPHeaders = [:]
////        if let token = UserDefaults.standard.string(forKey: "token") {
////            head = ["Authorization" : "Bearer \(token)"]
////        }
////        if header != "" {
////            head.updateValue(header, forKey: "language")
////        }
//        print(apiUrl)
//        Alamofire.request(apiUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!, method: method, parameters: parameters, encoding: JSONEncoding.default , headers: head).responseJSON { (response:DataResponse<Any>) in
//            guard response.response != nil else {
//                error(Constants.Network.ErrorMessage.UNABLE_LOAD_DATA)
//                return
//            }
//            guard let statusCode = response.response?.statusCode else {
//                error(Constants.Network.ErrorMessage.NO_HTTP_STATUS_CODE)
//                return
//            }
//            print("\(statusCode) - \(apiUrl)")
//
//            switch(statusCode) {
//            case HttpStatusCode.unauthorized.statusCode:
//                error(Constants.Network.ErrorMessage.UNAUTHORIZED)
//                break
//            case HttpStatusCode.ok.statusCode,
//                 HttpStatusCode.accepted.statusCode,
//                 HttpStatusCode.created.statusCode:
//
//                let json = JSON(data: response.data!)
//                if !json["error"].stringValue.isEmpty{
//                    error(json["error"].stringValue)
//                } else {
//                    completion(json)
//                }
//                break
//            default:
//
//                let json = JSON(data: response.data!)
//                if !json.isEmpty {
//                    let message = json["error"].stringValue
//                    error(message)
//                } else {
//                    if let data = response.data {
//                        let json = String(data: data, encoding: String.Encoding.utf8)
//                        error(json!)
//                    } else {
//                        error("")
//                    }
//                }
//            }
//        }
//    }
//
//    internal func post(endpoint: String, parameters: Parameter, header: String = "", completion: @escaping SuccessHandler, error: @escaping FailureHandler) {
//        request(method: .post, endpoint: endpoint, parameters: parameters, header: header, completion: completion, error: error)
//    }
//    internal func put(endpoint: String, parameters: Parameter, header: String = "", completion: @escaping SuccessHandler, error: @escaping FailureHandler) {
//        request(method: .put, endpoint: endpoint, parameters: parameters, header: header, completion: completion, error: error)
//    }
//    internal func get(endpoint: String, header: String = "", completion: @escaping SuccessHandler, error: @escaping FailureHandler) {
//        request(method: .get, endpoint: endpoint, parameters: nil, header: header, completion: completion, error: error)
//    }
//    internal func get(endpoint: String, parameters: Parameter, completion: @escaping SuccessHandler, error: @escaping FailureHandler) {
//        let header = ""
//        request(method: .get, endpoint: endpoint, parameters: parameters, header: header, completion: completion, error: error)
//    }
//    internal func delete(endpoint: String, completion: @escaping SuccessHandler, error: @escaping FailureHandler) {
//        let header = ""
//        request(method: .delete, endpoint: endpoint, parameters: nil, header: header, completion: completion, error: error)
//    }
//    internal func patch(endpoint: String, parameters: Parameter, completion: @escaping SuccessHandler, error: @escaping FailureHandler) {
//        let header = ""
//        request(method: .patch, endpoint: endpoint, parameters: parameters, header: header, completion: completion, error: error)
//    }
//
//
//    // MARK: - Internet Connectivity
//
//    func isConnectedToNetwork() -> Bool {
//
//        var zeroAddress = sockaddr_in()
//        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
//        zeroAddress.sin_family = sa_family_t(AF_INET)
//
//        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
//            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
//                SCNetworkReachabilityCreateWithAddress(nil, $0)
//            }
//        }) else {
//            return false
//        }
//
//        var flags: SCNetworkReachabilityFlags = []
//        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
//            return false
//        }
//
//        let isReachable = flags.contains(.reachable)
//        let needsConnection = flags.contains(.connectionRequired)
//
//        return (isReachable && !needsConnection)
//    }
//
//
//}

