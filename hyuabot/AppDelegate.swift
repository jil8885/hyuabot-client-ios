//
//  AppDelegate.swift
//  hyuabot
//
//  Created by 이정인 on 2023/09/03.
//

import UIKit
import RxSwift
import QueryAPI


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    let shuttleRealtimeQuery = BehaviorSubject<[ShuttleRealtimeQuery.Data.Shuttle.Stop]>(value: [])
    
    var window: UIWindow?

    override init() {
        super.init()
        UIFont.overrideInitialize()
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
}
