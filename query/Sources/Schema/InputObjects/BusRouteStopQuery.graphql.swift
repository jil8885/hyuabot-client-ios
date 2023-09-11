// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct BusRouteStopQuery: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    stop: Int,
    route: Int
  ) {
    __data = InputDict([
      "stop": stop,
      "route": route
    ])
  }

  public var stop: Int {
    get { __data["stop"] }
    set { __data["stop"] = newValue }
  }

  public var route: Int {
    get { __data["route"] }
    set { __data["route"] = newValue }
  }
}
