// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class BusTimetableQuery: GraphQLQuery {
  public static let operationName: String = "BusTimetableQuery"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query BusTimetableQuery($stopList: [BusRouteStopQuery!]!) { bus(routeStop: $stopList, weekdays: ["weekdays", "saturday", "sunday"]) { __typename timetable { __typename weekday time } } }"#
    ))

  public var stopList: [BusRouteStopQuery]

  public init(stopList: [BusRouteStopQuery]) {
    self.stopList = stopList
  }

  public var __variables: Variables? { ["stopList": stopList] }

  public struct Data: QueryAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { QueryAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("bus", [Bus].self, arguments: [
        "routeStop": .variable("stopList"),
        "weekdays": ["weekdays", "saturday", "sunday"]
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
        .field("timetable", [Timetable].self),
      ] }

      public var timetable: [Timetable] { __data["timetable"] }

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
