//
//  ViewController.swift
//  PracticeReactorKit
//
//  Created by 김정상 on 2022/12/07.
//

import UIKit

import Then
import RxCocoa
import ReactorKit
import SnapKit

class LoginViewController: UIViewController, View {

  typealias Reactor = LoginViewReactor
  
  var disposeBag = DisposeBag()
  
  // MARK: - Init
  
  init() {
    super.init(nibName: nil, bundle: nil)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    fatalError("❗️Not Supported")
  }
  
  // MARK: - UI Component
  
  private let stackView = UIStackView().then {
    $0.axis = .vertical
    $0.alignment = .fill
    $0.distribution = .equalSpacing
    $0.spacing = 14
  }
  
  private let idTextField = UITextField().then {
    $0.placeholder = "ID"
    $0.textColor = .black
  }
  
  private let passwordTextField = UITextField().then {
    $0.placeholder = "Password"
    $0.textColor = .black
  }
  
  private let loginButton = UIButton().then {
    $0.setTitle("Login", for: .normal)
    $0.setTitleColor(.blue, for: .normal)
    $0.setTitleColor(.gray, for: .disabled)
  }
  
  // MARK: - Setup Views
  
  private func setupViews() {
    view.backgroundColor = .white
    
    view.addSubview(stackView)
    
    stackView.addArrangedSubview(idTextField)
    stackView.addArrangedSubview(passwordTextField)
    stackView.addArrangedSubview(loginButton)
    
    stackView.snp.makeConstraints {
      let guide = view.safeAreaLayoutGuide
      $0.top.equalTo(guide).offset(20)
      $0.leading.equalTo(guide).offset(20)
      $0.trailing.equalTo(guide).offset(-20)
    }
  }
  
  // MARK: - Binding
  
  func bind(reactor: Reactor) {
    idTextField.rx.text
      .compactMap { $0 }
      .map { Reactor.Action.updateID($0) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    passwordTextField.rx.text
      .compactMap { $0 }
      .map { Reactor.Action.updatePassword($0) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    loginButton.rx.tap
      .map { Reactor.Action.login }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    reactor.state.map { $0.id }
      .distinctUntilChanged()
      .bind(to: idTextField.rx.text)
      .disposed(by: disposeBag)
    
    reactor.state.map { $0.password }
      .distinctUntilChanged()
      .bind(to: passwordTextField.rx.text)
      .disposed(by: disposeBag)
    
    reactor.state.map { $0.isLoading }
      .map { $0.not() }
      .bind(to: loginButton.rx.isEnabled)
      .disposed(by: disposeBag)
    
    reactor.pulse(\.$isLogined)
      .filter { $0 }
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] _ in
        self?.showAlert(message: "Logined")
      })
      .disposed(by: disposeBag)
  }
  
  // MARK: - Privates
  
  private func showAlert(message: String) {
    let alertController = UIAlertController(
      title: nil,
      message: message,
      preferredStyle: .alert
    )
    alertController.addAction(UIAlertAction(
      title: "OK",
      style: .default,
      handler: nil
    ))
    self.present(alertController, animated: true)
  }
}
