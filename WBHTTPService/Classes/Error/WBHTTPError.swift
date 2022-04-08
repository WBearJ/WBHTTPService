//
//  HTTPService.swift
//  HTTPService
//
//  Created by WBear on 2022/3/18.
//

import Foundation

public enum WBRequestError: Error, LocalizedError {
    ///请求超时
    case timeout
    
    /// 请求错误/参数错误
    case requestError
    
    /// 服务器错误
    case internalError
    
    /// token过期
    case tokenExpired
    
    /// 格式化失败
    case decodeFailure
    
    /// 未知错误
    case unknow
    
    static func requestError(code: WBResponseCode) throws -> Void {
        switch code {
        case .tokenExpired:
            throw WBRequestError.tokenExpired
        case .decodeFailure:
            throw WBRequestError.decodeFailure
        case .unknow:
            throw WBRequestError.unknow
        case .success:
            break
        case .requestError:
            throw WBRequestError.requestError
        case .internalError:
            throw WBRequestError.internalError
        }
    }
    
    var errorDescription: String! {
        switch self {
        case .timeout:
            return "请求超时，请稍后重试"
        case .internalError:
            return "服务器错误"
        case .decodeFailure:
            return "数据格式化失败，请稍后重试"
        case .tokenExpired:
            return "登录过期，请重新登录"
        case .unknow:
            return "未知错误"
        case .requestError:
            return "参数错误"
        }
    }
}
