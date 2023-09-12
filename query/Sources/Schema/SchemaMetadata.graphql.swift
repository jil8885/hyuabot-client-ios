// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public typealias ID = String

public protocol SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == QueryAPI.SchemaMetadata {}

public protocol InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == QueryAPI.SchemaMetadata {}

public protocol MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == QueryAPI.SchemaMetadata {}

public protocol MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == QueryAPI.SchemaMetadata {}

public enum SchemaMetadata: ApolloAPI.SchemaMetadata {
  public static let configuration: ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

  public static func objectType(forTypename typename: String) -> Object? {
    switch typename {
    case "Query": return QueryAPI.Objects.Query
    case "CafeteriaItem": return QueryAPI.Objects.CafeteriaItem
    case "MenuItem": return QueryAPI.Objects.MenuItem
    case "StationItem": return QueryAPI.Objects.StationItem
    case "TimetableListResponse": return QueryAPI.Objects.TimetableListResponse
    case "TimetableItemResponse": return QueryAPI.Objects.TimetableItemResponse
    case "ReadingRoomItem": return QueryAPI.Objects.ReadingRoomItem
    case "ReadingRoomSeat": return QueryAPI.Objects.ReadingRoomSeat
    case "ReadingRoomInformation": return QueryAPI.Objects.ReadingRoomInformation
    case "RealtimeListResponse": return QueryAPI.Objects.RealtimeListResponse
    case "RealtimeItemResponse": return QueryAPI.Objects.RealtimeItemResponse
    case "BusRouteStopItem": return QueryAPI.Objects.BusRouteStopItem
    case "BusTimetable": return QueryAPI.Objects.BusTimetable
    case "ShuttleItem": return QueryAPI.Objects.ShuttleItem
    case "ShuttleStopItem": return QueryAPI.Objects.ShuttleStopItem
    case "ShuttleTagStopItem": return QueryAPI.Objects.ShuttleTagStopItem
    case "ShuttleArrivalTimeItem": return QueryAPI.Objects.ShuttleArrivalTimeItem
    case "ShuttleQueryItem": return QueryAPI.Objects.ShuttleQueryItem
    case "ShuttleArrivalOtherStopItem": return QueryAPI.Objects.ShuttleArrivalOtherStopItem
    case "BusRealtime": return QueryAPI.Objects.BusRealtime
    default: return nil
    }
  }
}

public enum Objects {}
public enum Interfaces {}
public enum Unions {}
