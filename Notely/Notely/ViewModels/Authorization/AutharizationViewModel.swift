//
//  AutharizationViewModel.swift
//  Notely
//
//  Created by Tima Shchekochikhin on 20.09.2023.
//

import UIKit

protocol AutharizationViewModel {
    var cellViewModels: [CellViewModel]? { get set }
    var userFirebase: UserFirebase { get }
    func authorization(vc: UIViewController)
}
