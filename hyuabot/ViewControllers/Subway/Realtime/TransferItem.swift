import QueryAPI

struct TransferItem {
    let upFrom: SubwayRealtimeQuery.Data.Subway.Realtime.Up?
    let upTo: SubwayRealtimeQuery.Data.Subway.Timetable.Up?
    let downFrom: SubwayRealtimeQuery.Data.Subway.Realtime.Down?
    let downTo: SubwayRealtimeQuery.Data.Subway.Timetable.Down?
}
