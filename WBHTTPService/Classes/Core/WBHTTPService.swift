//
//  HTTPService.swift
//  HTTPService
//
//  Created by WBear on 2022/3/18.
//

import Foundation
import RxSwift
import Moya
import HandyJSON

public struct WBHTTPService {
    
    private static let disposeBag = DisposeBag()
    
    public static let ErrorObservable = PublishSubject<WBRequestError>()
    
    public typealias RequestSingleResult<T: WBHTTPResultCodable> = (Result<T, WBRequestError>) -> Void
    public typealias RequestListResult<T: WBHTTPResultCodable> = (Result<[T], WBRequestError>) -> Void
    
    public static func singleDataRequest<T: WBHTTPResultCodable, U: WBTargetType>(target: U, modelType: T.Type, _ result: @escaping RequestSingleResult<T>) {
        
        let provider = MoyaProvider<U>(endpointClosure: endPointClosure(), requestClosure: requestClosure, plugins: plugins)
        provider.rx
            .request(target)
            .asObservable()
            .mapModel(WBResultModel<T>.self)
            .subscribe(onNext: { element in
                do {
                    try WBRequestError.requestError(code: element.code)
                    if let data = element.result {
                        result(.success(data))
                    }else {
                        result(.failure(.unknow))
                    }
                }catch {
                    let requestError = error as! WBRequestError
  
                    ErrorObservable.onNext(requestError)
                }
            }).disposed(by: disposeBag)
    }
    
    public static func listDataRequest<T: WBHTTPResultCodable, U: WBTargetType>(target: U, modelType: T.Type, _ result: @escaping RequestListResult<T>) {
        
        let provider = MoyaProvider<U>(endpointClosure: endPointClosure(), requestClosure: requestClosure, plugins: plugins)
        provider.rx.request(target)
            .asObservable()
            .mapModel(WBResultListModel<T>.self)
            .subscribe(onNext: { element in
                do {
                    try WBRequestError.requestError(code: element.code)
                    if let data = element.result {
                        result(.success(data))
                    }else {
                        result(.failure(.unknow))
                    }
                }catch {
                    let requestError = error as! WBRequestError
                    ErrorObservable.onNext(requestError)
                }
            }).disposed(by: disposeBag)
    }
}

extension WBHTTPService {
    
    static func endPointClosure<T: WBTargetType>() -> (T) -> Endpoint {
        return { target in
            return Endpoint(
                url: target.baseURL.absoluteString + target.path,
                sampleResponseClosure: { .networkResponse(200, target.sampleData)},
                method: target.method,
                task: target.task,
                httpHeaderFields: target.headers
            )
        }
    }
    
    static let requestClosure = { (endPoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
        do {
            var request = try endPoint.urlRequest()
            request.timeoutInterval = 15
            // 打印请求参数
            if let requestData = request.httpBody {
                debugPrint("请求地址===========" + "\(request.url!)")
                debugPrint("\(request.httpMethod ?? "")"+"发送参数"+"\(String(data: request.httpBody!, encoding: String.Encoding.utf8) ?? "")")
                debugPrint(request.allHTTPHeaderFields as Any)
            }else{
                debugPrint(request.allHTTPHeaderFields as Any)
                debugPrint("请求地址===========" + "\(request.url!)"+"============\(String(describing: request.httpMethod!))")
            }
            done(.success(request))
        } catch {
            done(.failure(MoyaError.underlying(error, nil)))
        }
    }
    
    static var plugins: [PluginType] {
        let activityPlugin = NetworkActivityPlugin { change, target in
            if let wbTarget = target as? WBTargetType {
                switch change {
                case .began:
                    if wbTarget.showLoading {
                        
                    }
                case .ended:
                    if wbTarget.showLoading {
                        
                    }
                }
            }
        }
        return [activityPlugin]
    }
}
