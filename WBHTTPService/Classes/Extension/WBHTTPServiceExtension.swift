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
        var jsonDic = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
        if let result = jsonDic?["result"] as? [String: Any], result.isEmpty {
            // 框架在空数据会创建一个空对象
            jsonDic?.removeValue(forKey: "result")
        }
        
        #if DEBUG
            print("==============服务器请求结果:===============\n\(jsonDic!)")
        #endif
        
        if let model = JSONDeserializer<T>.deserializeFrom(dict: jsonDic) {
            return model
        }
        let errorData: [String: Any] = ["message": "数据格式化失败", "code": WBResponseCode.decodeFailure.rawValue]
        return JSONDeserializer<T>.deserializeFrom(dict: errorData, designatedPath: nil)!
    }
}
