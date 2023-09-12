// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CafeteriaQuery: GraphQLQuery {
  public static let operationName: String = "CafeteriaQuery"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query CafeteriaQuery($date: Date) { cafeteria(date: $date, campus: 2) { __typename id name menu { __typename food price slot } } }"#
    ))

  public var date: GraphQLNullable<Date>

  public init(date: GraphQLNullable<Date>) {
    self.date = date
  }

  public var __variables: Variables? { ["date": date] }

  public struct Data: QueryAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { QueryAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("cafeteria", [Cafeterium].self, arguments: [
        "date": .variable("date"),
        "campus": 2
      ]),
    ] }

    public var cafeteria: [Cafeterium] { __data["cafeteria"] }

    /// Cafeterium
    ///
    /// Parent Type: `CafeteriaItem`
    public struct Cafeterium: QueryAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { QueryAPI.Objects.CafeteriaItem }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", Int.self),
        .field("name", String.self),
        .field("menu", [Menu].self),
      ] }

      public var id: Int { __data["id"] }
      public var name: String { __data["name"] }
      public var menu: [Menu] { __data["menu"] }

      /// Cafeterium.Menu
      ///
      /// Parent Type: `MenuItem`
      public struct Menu: QueryAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { QueryAPI.Objects.MenuItem }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("food", String.self),
          .field("price", String.self),
          .field("slot", String.self),
        ] }

        public var food: String { __data["food"] }
        public var price: String { __data["price"] }
        public var slot: String { __data["slot"] }
      }
    }
  }
}
