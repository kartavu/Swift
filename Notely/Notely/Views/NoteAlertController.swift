//
//  NoteAlertController.swift
//  Notely
//
//  Created by Данил Соколов on 20.09.2023.
//

import UIKit

class NoteAlertController: UIAlertController {
    
    var deleteClosure: (() -> ())?
    var shareClosure: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let shareAction = UIAlertAction(title: "Поделиться", style: .default) { [weak self] (_) in
            guard let self = self else { return }
            self.shareClosure?()
        }
        addAction(shareAction)

        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { [weak self] (_) in
            guard let self = self else { return }
            self.deleteClosure?()
        }
        addAction(deleteAction)

        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        addAction(cancelAction)

    }
}
