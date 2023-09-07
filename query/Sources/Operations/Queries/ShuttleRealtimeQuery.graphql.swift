// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class ShuttleRealtimeQuery: GraphQLQuery {
  public static let operationName: String = "ShuttleRealtimeQuery"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query ShuttleRealtimeQuery($start: Time!) { shuttle(start: $start) { __typename stop { __typename stopName tag { __typename tagID timetable { __typename time remainingTime otherStops { __typename stopName } } } } } }"#
    ))

  public var start: Time

  public init(start: Time) {
    self.start = start
  }

  public var __variables: Variables? { ["start": start] }

  public struct Data: QueryAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { QueryAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("shuttle", Shuttle.self, arguments: ["start": .variable("start")]),
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
      ] }

      public var stop: [Stop] { __data["stop"] }

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
              .field("remainingTime", Double.self),
              .field("otherStops", [OtherStop].self),
            ] }

            public var time: QueryAPI.Time { __data["time"] }
            public var remainingTime: Double { __data["remainingTime"] }
            public var otherStops: [OtherStop] { __data["otherStops"] }

            /// Shuttle.Stop.Tag.Timetable.OtherStop
            ///
            /// Parent Type: `ShuttleArrivalOtherStopItem`
            public struct OtherStop: QueryAPI.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: ApolloAPI.ParentType { QueryAPI.Objects.ShuttleArrivalOtherStopItem }
              public static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("stopName", String.self),
              ] }

              public var stopName: String { __data["stopName"] }
            }
          }
        }
      }
    }
  }
}
