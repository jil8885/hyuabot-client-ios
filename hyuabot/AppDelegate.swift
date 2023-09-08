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
    // Query Data from GraphQL
    let shuttleRealtimeQuery = BehaviorSubject<[ShuttleRealtimeQuery.Data.Shuttle.Stop]>(value: [])
    
    // Data formatter
    let showShuttleRemainingTime = BehaviorSubject<Bool>(value: false)
    
    // Query to move timetable page
    let shuttleTimetableQueryParams = BehaviorSubject<ShuttleTimetableQueryParams?>(value: nil)
    
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter
    }()
    
    var window: UIWindow?

    override init() {
        super.init()
        UIFont.overrideInitialize()
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
    
    func queryShuttleRealtimePage() {
        let startTime = dateFormatter.string(from: Date())
        Network.shared.apollo.fetch(query: ShuttleRealtimeQuery(start: startTime)) { result in
            switch result {
            case .success(let graphQLResult):
                self.shuttleRealtimeQuery.onNext(graphQLResult.data?.shuttle.stop ?? [])
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func toggleShowShuttleRemainingTime() {
        if let value = try? showShuttleRemainingTime.value() {
            showShuttleRemainingTime.onNext(!value)
        }
    }
}
