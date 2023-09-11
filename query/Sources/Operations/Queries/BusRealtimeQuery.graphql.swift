// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class BusRealtimeQuery: GraphQLQuery {
  public static let operationName: String = "BusRealtimeQuery"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query BusRealtimeQuery($stopList: [BusRouteStopQuery!]!, $date: Date, $start: Time) { bus(routeStop: $stopList, date: $date, start: $start) { __typename stopID stopName routeID routeName realtime { __typename remainingStop remainingTime remainingSeat } timetable { __typename weekday time } } }"#
    ))

  public var stopList: [BusRouteStopQuery]
  public var date: GraphQLNullable<Date>
  public var start: GraphQLNullable<Time>

  public init(
    stopList: [BusRouteStopQuery],
    date: GraphQLNullable<Date>,
    start: GraphQLNullable<Time>
  ) {
    self.stopList = stopList
    self.date = date
    self.start = start
  }

  public var __variables: Variables? { [
    "stopList": stopList,
    "date": date,
    "start": start
  ] }

  public struct Data: QueryAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { QueryAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("bus", [Bus].self, arguments: [
        "routeStop": .variable("stopList"),
        "date": .variable("date"),
        "start": .variable("start")
      ]),
    ] }

    public var bus: [Bus] { __data["bus"] }

    /// Bus
    ///
    /// Parent Type: `BusRouteStopItem`
    public struct Bus: QueryAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { QueryAPI.Objects.BusRouteStopItem }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("stopID", Int.self),
        .field("stopName", String.self),
        .field("routeID", Int.self),
        .field("routeName", String.self),
        .field("realtime", [Realtime].self),
        .field("timetable", [Timetable].self),
      ] }

      public var stopID: Int { __data["stopID"] }
      public var stopName: String { __data["stopName"] }
      public var routeID: Int { __data["routeID"] }
      public var routeName: String { __data["routeName"] }
      public var realtime: [Realtime] { __data["realtime"] }
      public var timetable: [Timetable] { __data["timetable"] }

      /// Bus.Realtime
      ///
      /// Parent Type: `BusRealtime`
      public struct Realtime: QueryAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { QueryAPI.Objects.BusRealtime }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("remainingStop", Int.self),
          .field("remainingTime", Int.self),
          .field("remainingSeat", Int.self),
        ] }

        public var remainingStop: Int { __data["remainingStop"] }
        public var remainingTime: Int { __data["remainingTime"] }
        public var remainingSeat: Int { __data["remainingSeat"] }
      }

      /// Bus.Timetable
      ///
      /// Parent Type: `BusTimetable`
      public struct Timetable: QueryAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { QueryAPI.Objects.BusTimetable }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("weekday", String.self),
          .field("time", QueryAPI.Time.self),
        ] }

        public var weekday: String { __data["weekday"] }
        public var time: QueryAPI.Time { __data["time"] }
      }
    }
  }
}
