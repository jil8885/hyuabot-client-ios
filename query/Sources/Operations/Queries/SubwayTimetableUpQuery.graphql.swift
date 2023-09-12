// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SubwayTimetableUpQuery: GraphQLQuery {
  public static let operationName: String = "SubwayTimetableUpQuery"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query SubwayTimetableUpQuery($station: [String!]!) { subway(station: $station, start: "00:00") { __typename timetable { __typename up { __typename destinationID destinationName weekday time } } } }"#
    ))

  public var station: [String]

  public init(station: [String]) {
    self.station = station
  }

  public var __variables: Variables? { ["station": station] }

  public struct Data: QueryAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { QueryAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("subway", [Subway].self, arguments: [
        "station": .variable("station"),
        "start": "00:00"
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
        .field("timetable", Timetable.self),
      ] }

      public var timetable: Timetable { __data["timetable"] }

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
        ] }

        public var up: [Up] { __data["up"] }

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
      }
    }
  }
}
