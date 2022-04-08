//
//  HTTPResultTool.swift
//  HTTPService
//
//  Created by WBear on 2022/3/18.
//

import Foundation
import RxSwift
import Moya
import HandyJSON

public protocol WBHTTPResultCodable: HandyJSON {}
public protocol WBHTTPResultEnumCodable: HandyJSONEnum {}

enum WBResponseCode: Int, WBHTTPResultEnumCodable {
    /// 请求成功
    case success = 200
    /// 请求错误/参数错误
    case requestError = 400
    /// token过期
    case tokenExpired = 401
    /// 服务器内部错误
    case internalError = 500
    /// 格式化失败
    case decodeFailure = 1000
    /// 未知状态
    case unknow = -1000
}

public struct WBResultModel<T: WBHTTPResultCodable>: WBHTTPResultCodable {
    var code: WBResponseCode = .unknow
    var message: String = ""
    var result: T?
    
    public init() {
        
    }
}

public struct WBResultListModel<T: WBHTTPResultCodable>: WBHTTPResultCodable {
    var code: WBResponseCode = .unknow
    var message: String = ""
    var result: [T]?
    
    public init() {
        
    }
}
