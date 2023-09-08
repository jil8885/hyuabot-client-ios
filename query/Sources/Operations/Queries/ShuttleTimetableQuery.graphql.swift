// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class ShuttleTimetableQuery: GraphQLQuery {
  public static let operationName: String = "ShuttleTimetableQuery"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query ShuttleTimetableQuery($stop: String!, $tags: [String!]!) { shuttle(stop: [$stop], weekday: [true, false], tag: $tags) { __typename stop { __typename stopName tag { __typename tagID timetable { __typename time weekdays } } } params { __typename period } } }"#
    ))

  public var stop: String
  public var tags: [String]

  public init(
    stop: String,
    tags: [String]
  ) {
    self.stop = stop
    self.tags = tags
  }

  public var __variables: Variables? { [
    "stop": stop,
    "tags": tags
  ] }

  public struct Data: QueryAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { QueryAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("shuttle", Shuttle.self, arguments: [
        "stop": [.variable("stop")],
        "weekday": [true, false],
        "tag": .variable("tags")
      ]),
    ] }

    public var shuttle: Shuttle { __data["shuttle"] }

    /// Shuttle
    ///
    /// Parent Type: `ShuttleItem`
    public struct Shuttle: QueryAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { QueryAPI.Objects.ShuttleItem }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("stop", [Stop].self),
        .field("params", Params.self),
      ] }

      public var stop: [Stop] { __data["stop"] }
      public var params: Params { __data["params"] }

      /// Shuttle.Stop
      ///
      /// Parent Type: `ShuttleStopItem`
      public struct Stop: QueryAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { QueryAPI.Objects.ShuttleStopItem }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("stopName", String.self),
          .field("tag", [Tag].self),
        ] }

        public var stopName: String { __data["stopName"] }
        public var tag: [Tag] { __data["tag"] }

        /// Shuttle.Stop.Tag
        ///
        /// Parent Type: `ShuttleTagStopItem`
        public struct Tag: QueryAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { QueryAPI.Objects.ShuttleTagStopItem }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("tagID", String.self),
            .field("timetable", [Timetable].self),
          ] }

          public var tagID: String { __data["tagID"] }
          public var timetable: [Timetable] { __data["timetable"] }

          /// Shuttle.Stop.Tag.Timetable
          ///
          /// Parent Type: `ShuttleArrivalTimeItem`
          public struct Timetable: QueryAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { QueryAPI.Objects.ShuttleArrivalTimeItem }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("time", QueryAPI.Time.self),
              .field("weekdays", Bool.self),
            ] }

            public var time: QueryAPI.Time { __data["time"] }
            public var weekdays: Bool { __data["weekdays"] }
          }
        }
      }

      /// Shuttle.Params
      ///
      /// Parent Type: `ShuttleQueryItem`
      public struct Params: QueryAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { QueryAPI.Objects.ShuttleQueryItem }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("period", [String].self),
        ] }

        public var period: [String] { __data["period"] }
      }
    }
  }
}
