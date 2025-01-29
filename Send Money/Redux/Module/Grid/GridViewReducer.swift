//import Foundation
//
//class GridViewReducer {
//  static let shared = GridViewReducer()
//  var store: Store?
//  private init() {
//    store = Store(reducer: gridViewReducer, state: nil)
//  }
//  func gridViewReducer(_ action: Action, _ state: State?) -> State {
//    var newState = state as? GridReduxState ?? GridReduxState()
//    guard let actionReceived = action as? GridAction else { return newState }
//    newState.didSelectedState = actionReceived.didSelected
//    newState.indexPath = actionReceived.indexPath
//    newState.selectedObject = actionReceived.selectedObject
//    newState.actionType = actionReceived.actionType
//    return newState
//  }
//}
