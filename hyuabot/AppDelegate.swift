//
//  AppDelegate.swift
//  hyuabot
//
//  Created by 이정인 on 2023/09/03.
//

import UIKit
import RxSwift
import QueryAPI
import Apollo


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // Query Data from GraphQL
    let shuttleRealtimeQuery = BehaviorSubject<[ShuttleRealtimeQuery.Data.Shuttle.Stop]>(value: [])
    let shuttleTimetableQuery = BehaviorSubject<[ShuttleTimetableQuery.Data.Shuttle.Stop]>(value: [])
    let shuttleTimetablePeriod = BehaviorSubject<String?>(value: nil)
    
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
    
    func queryShuttleTimetablePage(stopID: String, destination: String, period: String? = nil) {
        var tags = [String]()
        switch stopID {
        case "dormitory_o":
            if destination == "shuttle_destination_subway" {
                tags = ["DH", "DJ", "C"]
            } else if destination == "shuttle_destination_terminal" {
                tags = ["DY", "C"]
            } else if destination == "shuttle_destination_jungang_station" {
                tags = ["DJ"]
            }
        case "shuttlecock_o":
            if destination == "shuttle_destination_subway" {
                tags = ["DH", "DJ", "C"]
            } else if destination == "shuttle_destination_terminal" {
                tags = ["DY", "C"]
            } else if destination == "shuttle_destination_jungang_station" {
                tags = ["DJ"]
            }
        case "station":
            if destination == "shuttle_destination_campus" {
                tags = ["DH", "DJ", "C"]
            } else if destination == "shuttle_destination_terminal" {
                tags = ["DY", "C"]
            } else if destination == "shuttle_destination_jungang_station" {
                tags = ["DJ"]
            }
        case "terminal":
            tags = ["DY", "C"]
        case "jungang_stn":
            tags = ["DJ", "C"]
        case "shuttlecock_i":
            tags = ["DH", "DY", "DJ", "C"]
        default:
            tags = []
        }
        
        if period == nil {
            Network.shared.apollo.fetch(query: ShuttleTimetableQuery(stop: stopID, tags: tags, period: nil)) { result in
                switch result {
                case .success(let graphQLResult):
                    self.shuttleTimetableQuery.onNext(graphQLResult.data?.shuttle.stop ?? [])
                    if (graphQLResult.data?.shuttle.params.period.count ?? 0 > 0) {
                        self.shuttleTimetablePeriod.onNext(graphQLResult.data?.shuttle.params.period[0])
                    }
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            let periodQuery: GraphQLNullable<[String]> = GraphQLNullable(arrayLiteral: period!)
            Network.shared.apollo.fetch(query: ShuttleTimetableQuery(stop: stopID, tags: tags, period: periodQuery)) { result in
                switch result {
                case .success(let graphQLResult):
                    self.shuttleTimetableQuery.onNext(graphQLResult.data?.shuttle.stop ?? [])
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func toggleShowShuttleRemainingTime() {
        if let value = try? showShuttleRemainingTime.value() {
            showShuttleRemainingTime.onNext(!value)
        }
    }
}
