//
//  TNHTTPServiceExtension.swift
//  TNHTTPService
//
//  Created by WBear on 2022/4/1.
//

import Foundation
import RxSwift
import Moya

public protocol WBTargetType: TargetType {
    /// 是否显示HUD
    var showLoading: Bool { get }
}

extension WBTargetType {
    public var showLoading: Bool { return false }
}
