import QueryAPI

struct BusArrivalItem {
    let realtime: BusRealtimeArrivalItem?
    let timetable: BusTimetableArrivalItem?
}

struct BusRealtimeArrivalItem {
    let routeName: String
    let realtime: BusRealtimeQuery.Data.Bus.Realtime?
}

struct BusTimetableArrivalItem {
    let time: String
}
