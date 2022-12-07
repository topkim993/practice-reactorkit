//
//  LoginReactor.swift
//  PracticeReactorKit
//
//  Created by 김정상 on 2022/12/07.
//

import Foundation

import ReactorKit

final class LoginViewReactor: Reactor {
  let initialState = State()
}

extension LoginViewReactor {
  enum Action {
    case updateID(String)
    case updatePassword(String)
    case login
  }
  
  enum Mutation {
    case setLoading(Bool)
    case setID(String)
    case setPassword(String)
    case login(Bool)
  }
  
  struct State {
    var isLoading = false
    var id = ""
    var password = ""
    var isLogined = false
  }
}

extension LoginViewReactor {
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .updateID(let string):
      return Observable.just(
        Mutation.setID(string)
      )
    case .updatePassword(let string):
      return Observable.just(
        Mutation.setPassword(string)
      )
    case .login:
      return Observable.concat(
        Observable.just(
          Mutation.setLoading(true)
        ),
        login(
          id: currentState.id,
          password: currentState.password
        )
        .map { Mutation.login($0) },
        Observable.just(
          Mutation.setLoading(false)
        )
      )
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    switch mutation {
    case .setLoading(let bool):
      state.isLoading = bool
    case .setID(let string):
      state.id = string
    case .setPassword(let string):
      state.password = string
    case .login(let bool):
      state.isLogined = bool
    }
    return state
  }
}

extension LoginViewReactor {
  private func login(id: String, password: String) -> Observable<Bool> {
    return Observable
      .just(id.isEmpty.not() && password.isEmpty.not())
      .delay(
        .milliseconds(500),
        scheduler: MainScheduler.instance
      )
  }
}

fileprivate extension Bool {
  func not() -> Bool {
    return !self
  }
}
