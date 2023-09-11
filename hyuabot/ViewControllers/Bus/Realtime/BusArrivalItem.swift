import QueryAPI

struct BusArrivalItem {
    let realtime: BusRealtimeArrivalItem?
    let timetable: BusRealtimeQuery.Data.Bus.Timetable?
}

struct BusRealtimeArrivalItem {
    let routeName: String
    let realtime: BusRealtimeQuery.Data.Bus.Realtime?
}
