//
//  LoginViewController.swift
//  Send Money
//
//  Created by Pratheesh Bennet on 30/01/25.
//

import UIKit
import Combine

class LoginViewController: SMTableViewController<SendMoneyCellModel> {
  private var cancellables = Set<AnyCancellable>()
  var loginViewModel: LoginViewModel? {
    return viewModel as? LoginViewModel
  }
  
  init(viewModel: LoginViewModel) {
    super.init(viewModel: viewModel)
    stickyButton.isHidden = true
    bindViewModel()
    refreshAndReload()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func bindViewModel() {
    loginViewModel?.loginStatusPublisher
      .receive(on: DispatchQueue.main)
      .sink { [weak self] success in
        if success {
          self?.navigateToMainScreen()
        } else {
          self?.showErrorAlert()
        }
      }
      .store(in: &cancellables)
  }
  
  private func navigateToMainScreen() {
    let viewModel = SendMoneyViewModel()
    let viewController = SendMoneyViewController(viewModel: viewModel)
    navigationController?.pushViewController(viewController, animated: true)
  }
  
  private func showErrorAlert() {
    let alert = UIAlertController(title: "Login Failed", message: "Invalid username or password.", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    present(alert, animated: true)
  }
  
  override func reloadUIForLanguageChange() {
    super.reloadUIForLanguageChange()
    view.setNeedsLayout()
       view.layoutIfNeeded()
    loginViewModel?.setupCellModels()
    refreshAndReload()
  }
  
}
