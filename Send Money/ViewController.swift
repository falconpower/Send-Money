//
//  ViewController.swift
//  Send Money
//
//  Created by Pratheesh Bennet on 29/01/25.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    let vm = LoginViewModel()
    let vc = SendMoneyListViewController()
    self.navigationController?.pushViewController(vc, animated: true)
  }


}

