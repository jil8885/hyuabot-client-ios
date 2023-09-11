// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SubwayRealtimeQuery: GraphQLQuery {
  public static let operationName: String = "SubwayRealtimeQuery"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query SubwayRealtimeQuery($station: [String!]!, $start: Time) { subway(station: $station, start: $start) { __typename id realtime { __typename up { __typename destinationID destinationName remainingTime remainingStation isExpress } down { __typename destinationID destinationName remainingTime remainingStation isExpress } } timetable { __typename up { __typename destinationID destinationName weekday time } down { __typename destinationID destinationName weekday time } } } }"#
    ))

  public var station: [String]
  public var start: GraphQLNullable<Time>

  public init(
    station: [String],
    start: GraphQLNullable<Time>
  ) {
    self.station = station
    self.start = start
  }

  public var __variables: Variables? { [
    "station": station,
    "start": start
  ] }

  public struct Data: QueryAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { QueryAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("subway", [Subway].self, arguments: [
        "station": .variable("station"),
        "start": .variable("start")
      ]),
    ] }

    public var subway: [Subway] { __data["subway"] }

    /// Subway
    ///
    /// Parent Type: `StationItem`
    public struct Subway: QueryAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { QueryAPI.Objects.StationItem }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", String.self),
        .field("realtime", Realtime.self),
        .field("timetable", Timetable.self),
      ] }

      public var id: String { __data["id"] }
      public var realtime: Realtime { __data["realtime"] }
      public var timetable: Timetable { __data["timetable"] }

      /// Subway.Realtime
      ///
      /// Parent Type: `RealtimeListResponse`
      public struct Realtime: QueryAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { QueryAPI.Objects.RealtimeListResponse }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("up", [Up].self),
          .field("down", [Down].self),
        ] }

        public var up: [Up] { __data["up"] }
        public var down: [Down] { __data["down"] }

        /// Subway.Realtime.Up
        ///
        /// Parent Type: `RealtimeItemResponse`
        public struct Up: QueryAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { QueryAPI.Objects.RealtimeItemResponse }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("destinationID", String.self),
            .field("destinationName", String.self),
            .field("remainingTime", Int.self),
            .field("remainingStation", Int.self),
            .field("isExpress", Bool.self),
          ] }

          public var destinationID: String { __data["destinationID"] }
          public var destinationName: String { __data["destinationName"] }
          public var remainingTime: Int { __data["remainingTime"] }
          public var remainingStation: Int { __data["remainingStation"] }
          public var isExpress: Bool { __data["isExpress"] }
        }

        /// Subway.Realtime.Down
        ///
        /// Parent Type: `RealtimeItemResponse`
        public struct Down: QueryAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { QueryAPI.Objects.RealtimeItemResponse }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("destinationID", String.self),
            .field("destinationName", String.self),
            .field("remainingTime", Int.self),
            .field("remainingStation", Int.self),
            .field("isExpress", Bool.self),
          ] }

          public var destinationID: String { __data["destinationID"] }
          public var destinationName: String { __data["destinationName"] }
          public var remainingTime: Int { __data["remainingTime"] }
          public var remainingStation: Int { __data["remainingStation"] }
          public var isExpress: Bool { __data["isExpress"] }
        }
      }

      /// Subway.Timetable
      ///
      /// Parent Type: `TimetableListResponse`
      public struct Timetable: QueryAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { QueryAPI.Objects.TimetableListResponse }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("up", [Up].self),
          .field("down", [Down].self),
        ] }

        public var up: [Up] { __data["up"] }
        public var down: [Down] { __data["down"] }

        /// Subway.Timetable.Up
        ///
        /// Parent Type: `TimetableItemResponse`
        public struct Up: QueryAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { QueryAPI.Objects.TimetableItemResponse }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("destinationID", String.self),
            .field("destinationName", String.self),
            .field("weekday", String.self),
            .field("time", QueryAPI.Time.self),
          ] }

          public var destinationID: String { __data["destinationID"] }
          public var destinationName: String { __data["destinationName"] }
          public var weekday: String { __data["weekday"] }
          public var time: QueryAPI.Time { __data["time"] }
        }

        /// Subway.Timetable.Down
        ///
        /// Parent Type: `TimetableItemResponse`
        public struct Down: QueryAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { QueryAPI.Objects.TimetableItemResponse }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("destinationID", String.self),
            .field("destinationName", String.self),
            .field("weekday", String.self),
            .field("time", QueryAPI.Time.self),
          ] }

          public var destinationID: String { __data["destinationID"] }
          public var destinationName: String { __data["destinationName"] }
          public var weekday: String { __data["weekday"] }
          public var time: QueryAPI.Time { __data["time"] }
        }
      }
    }
  }
}
