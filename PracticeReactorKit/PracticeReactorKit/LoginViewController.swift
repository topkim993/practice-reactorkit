//
//  ViewController.swift
//  PracticeReactorKit
//
//  Created by 김정상 on 2022/12/07.
//

import UIKit

import Then
import RxCocoa
import SnapKit

class LoginViewController: UIViewController {
  
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
  }
  
  // MARK: - Privates
  
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
}

