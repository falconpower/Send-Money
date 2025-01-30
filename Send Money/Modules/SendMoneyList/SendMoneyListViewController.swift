//
//  SendMoneyListViewController.swift
//  Send Money
//
//  Created by Pratheesh Bennet on 30/01/25.
//

import UIKit

class SendMoneyListViewController: UIViewController {
  
  private var tableView: UITableView!
  private var viewModel = SendMoneyListViewModel()
  private var floatingButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    setupFloatingButton()
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    self.title = "sendMoneyRequest".localized
    tableView.reloadData()
  }
  
  private func setupTableView() {
    tableView = UITableView(frame: view.bounds, style: .plain)
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(SendMoneyCell.self, forCellReuseIdentifier: "SendMoneyCell")
    view.addSubview(tableView)
  }
  
  private func setupFloatingButton() {
    floatingButton = UIButton(type: .system)
    floatingButton.setTitle("+", for: .normal)
    floatingButton.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
    floatingButton.backgroundColor = .systemBlue
    floatingButton.layer.cornerRadius = 30
    floatingButton.tintColor = .white
    floatingButton.translatesAutoresizingMaskIntoConstraints = false
    floatingButton.addTarget(self, action: #selector(didTapFloatingButton), for: .touchUpInside)
    view.addSubview(floatingButton)
    
    NSLayoutConstraint.activate([
      floatingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
      floatingButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
      floatingButton.widthAnchor.constraint(equalToConstant: 60),
      floatingButton.heightAnchor.constraint(equalToConstant: 60)
    ])
  }
  
  @objc private func didTapFloatingButton() {
    let viewModel = SendMoneyViewModel()
    let viewController = SendMoneyViewController(viewModel: viewModel)
    navigationController?.pushViewController(viewController, animated: true)
  }
}

extension SendMoneyListViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.data.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let model = viewModel.data[indexPath.row]
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "SendMoneyCell", for: indexPath) as? SendMoneyCell else {
      return UITableViewCell()
    }
    cell.configure(with: model.first)
    return cell
  }
}

extension SendMoneyListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let model = viewModel.data[indexPath.row]
    let exportModel = ExportableSendMoneyModel(from: model)
    if let jsonData = try? JSONEncoder().encode(exportModel) {
      if let jsonString = String(data: jsonData, encoding: .utf8) {
        let alertController = UIAlertController(title: "Exported Model", message: jsonString, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
      }
    }
  }
}
