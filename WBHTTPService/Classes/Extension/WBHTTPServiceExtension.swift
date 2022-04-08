//
//  TNHTTPServiceExtension.swift
//  TNHTTPService
//
//  Created by WBear on 2022/4/1.
//

import Foundation
import RxSwift
import Moya
import HandyJSON

extension ObservableType where Element == Response {
    func mapModel<T: WBHTTPResultCodable>(_ type: T.Type) -> Observable<T> {
        flatMap { return Observable.just($0.mapModel(T.self)) }
    }
}

extension Response {
    func mapModel<T: WBHTTPResultCodable>(_ type: T.Type) -> T {
        let jsonStr = String(data: data, encoding: .utf8)
        #if DEBUG
        print("==============服务器请求结果:===============\(jsonStr!)")
        #endif
        if let model = JSONDeserializer<T>.deserializeFrom(json: jsonStr) {
            return model
        }
        let errorData: [String: Any] = ["message": "数据格式化失败", "code": WBResponseCode.decodeFailure.rawValue]
        return JSONDeserializer<T>.deserializeFrom(dict: errorData, designatedPath: nil)!
    }
}
