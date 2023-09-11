import QueryAPI

struct SubwayArrivalItem {
    let upRealtime: SubwayRealtimeQuery.Data.Subway.Realtime.Up?
    let downRealtime: SubwayRealtimeQuery.Data.Subway.Realtime.Down?
    let timetable: SubwayTimetableArrivalItem?
}

struct SubwayTimetableArrivalItem {
    let destinationID: String
    let destinationName: String
    let time: String
}
