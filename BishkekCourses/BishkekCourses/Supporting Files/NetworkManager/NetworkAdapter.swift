//
//  NetworkAdapter.swift
//  BishkekCourses
//
//  Created by Khasanza on 1/29/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import Moya
import SystemConfiguration

class NetworkAdapter {
    class var shared: NetworkAdapter {
        struct Static {
            static let instance = NetworkAdapter()
        }
        return Static.instance
    }
    let provider = MoyaProvider<NetworkManager>()
    func request(target: NetworkManager, success successCallback: @escaping (Response) -> Void, error errorCallback: @escaping (String) -> Void) {
        print("hey")
        if !self.isConnectedToNetwork() {
            errorCallback(Constants.Network.ErrorMessage.NO_INTERNET_CONNECTION)
        }
        else {
            print("here")
            provider.request(target) { (result) in
                switch result {
                case .success(let response):
                    guard response.response != nil else {
                        errorCallback(Constants.Network.ErrorMessage.UNABLE_LOAD_DATA)
                        return
                    }
                    guard let statusCode = response.response?.statusCode else {
                        errorCallback(Constants.Network.ErrorMessage.NO_HTTP_STATUS_CODE)
                        return
                    }
                    print("status code - ", statusCode)
                    switch(statusCode) {
                    case HttpStatusCode.unauthorized.statusCode:
                        errorCallback(Constants.Network.ErrorMessage.UNAUTHORIZED)
                        break
                    case HttpStatusCode.ok.statusCode,
                         HttpStatusCode.accepted.statusCode,
                         HttpStatusCode.created.statusCode:
                        successCallback(response)
    //                    let json = JSON(data: response.data!)
    //
    //                    if !json["error"].stringValue.isEmpty {
    //                        error(json["error"].stringValue)
    //                    } else {
    //                        completion(json)
    //                    }
                        break
                    default:
                        print("Some error")

                        errorCallback(Constants.Network.ErrorMessage.NOT_FOUND_ERROR)
    //                    let json = JSON(data: response.data!)
    //                    if !json.isEmpty {
    //                        let message = json["error"].stringValue
    //                        error(message)
    //                    } else {
    //                        if let data = response.data {
    //                            let json = String(data: data, encoding: String.Encoding.utf8)
    //                            error(json!)
    //                        } else {
    //                            error("")
    //                        }
    //                    }
                    }
                case .failure(let error):
                    print("failure")
                    errorCallback(error.errorDescription!)
                }
            }
        }
    }
    func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
}
