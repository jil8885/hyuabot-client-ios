// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class ReadingRoomQuery: GraphQLQuery {
  public static let operationName: String = "ReadingRoomQuery"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query ReadingRoomQuery { readingRoom(campus: 2) { __typename id name seats { __typename active occupied total available } status { __typename reservable } } }"#
    ))

  public init() {}

  public struct Data: QueryAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { QueryAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("readingRoom", [ReadingRoom].self, arguments: ["campus": 2]),
    ] }

    public var readingRoom: [ReadingRoom] { __data["readingRoom"] }

    /// ReadingRoom
    ///
    /// Parent Type: `ReadingRoomItem`
    public struct ReadingRoom: QueryAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { QueryAPI.Objects.ReadingRoomItem }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", Int.self),
        .field("name", String.self),
        .field("seats", Seats.self),
        .field("status", Status.self),
      ] }

      public var id: Int { __data["id"] }
      public var name: String { __data["name"] }
      public var seats: Seats { __data["seats"] }
      public var status: Status { __data["status"] }

      /// ReadingRoom.Seats
      ///
      /// Parent Type: `ReadingRoomSeat`
      public struct Seats: QueryAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { QueryAPI.Objects.ReadingRoomSeat }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("active", Int.self),
          .field("occupied", Int.self),
          .field("total", Int.self),
          .field("available", Int.self),
        ] }

        public var active: Int { __data["active"] }
        public var occupied: Int { __data["occupied"] }
        public var total: Int { __data["total"] }
        public var available: Int { __data["available"] }
      }

      /// ReadingRoom.Status
      ///
      /// Parent Type: `ReadingRoomInformation`
      public struct Status: QueryAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { QueryAPI.Objects.ReadingRoomInformation }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("reservable", Bool.self),
        ] }

        public var reservable: Bool { __data["reservable"] }
      }
    }
  }
}
