//
//  StatementPresenter.swift
//  DesafioSantander
//
//  Created by Israel Alves Santos Junior on 05/07/19.
//  Copyright (c) 2019 Israel Alves Santos Junior. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol StatementPresentationLogic
{
  func presentSomething(response: Statement.Something.Response)
}

class StatementPresenter: StatementPresentationLogic
{
  weak var viewController: StatementDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: Statement.Something.Response)
  {
    let viewModel = Statement.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
