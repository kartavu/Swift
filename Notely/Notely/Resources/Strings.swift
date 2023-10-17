//
//  Strings.swift
//  Notely
//
//  Created by Данил Соколов on 13.09.2023.
//

import Foundation

enum Strings {
    enum main {
        static let appName = NSLocalizedString("main.appName", comment: "")
        
        enum profileEditVC {
            static let title = NSLocalizedString("main.profileEditVC.title", comment: "")
            static let saveButtonTitle = NSLocalizedString("main.profileEditVC.saveButtonTitle", comment: "")
        }
        
        enum profileInfoVM {
            enum editCell {
                enum title {
                    static let name = NSLocalizedString("main.profileInfoVM.editCell.title.name", comment: "")
                    static let surname = NSLocalizedString("main.profileInfoVM.editCell.title.surname", comment: "")
                    static let about = NSLocalizedString("main.profileInfoVM.editCell.title.about", comment: "")
                }
                enum placeholder {
                    static let name = NSLocalizedString("main.profileInfoVM.editCell.placeholder.name", comment: "")
                    static let surname = NSLocalizedString("main.profileInfoVM.editCell.placeholder.surname", comment: "")
                    static let about = NSLocalizedString("main.profileInfoVM.editCell.placeholder.about", comment: "")
                }
            }
        }
        
        enum PublicProfile {
            static let labelText = NSLocalizedString("main.PublicProfile.noNotesLabel.labelText", comment: "")
        }
        
        enum mainVC {
            static let segmentedControlItemFirst = NSLocalizedString("main.MainVC.segmentedControl.itemFirst", comment: "")
            static let segmentedControlItemSecond = NSLocalizedString("main.MainVC.segmentedControl.itemSecond", comment: "")
            static let actionSheetTitle = NSLocalizedString("main.MainVC.actionSheet.title", comment: "")
            static let actionAddFolderTitle = NSLocalizedString("main.MainVC.actionAddFolder.title", comment: "")
            static let actionSortAlphTitle = NSLocalizedString("main.MainVC.actionSort.alphTitle", comment: "")
            static let actionSortDateTitle = NSLocalizedString("main.MainVC.actionSort.dateTitle", comment: "")
            static let cancelActionTitle = NSLocalizedString("main.MainVC.cancelAction.title", comment: "")
            static let cancelActionValueForKey = NSLocalizedString("main.MainVC.cancelAction.setValue.forKey", comment: "")
            static let alertControllerTitle = NSLocalizedString("main.MainVC.alertController.title", comment: "")
            static let alertControllerPlaceholder = NSLocalizedString("main.MainVC.alertController.textField.placeholder", comment: "")
            static let addActionTitle = NSLocalizedString("main.MainVC.addAction.title", comment: "")
            static let notes = NSLocalizedString("main.MainVC.notes.lable", comment: "")
            static let folders = NSLocalizedString("main.MainVC.folders.lable", comment: "")
            static let oneNote = NSLocalizedString("main.MainVC.nounDeclensionOne.lable", comment: "")
            static let twoNote = NSLocalizedString("main.MainVC.nounDeclensionTwo.lable", comment: "")
            static let manyNote = NSLocalizedString("main.MainVC.nounDeclensionMany.lable", comment: "")
        }
        
        enum NoContentView {
            static let titleLableText = NSLocalizedString("main.NoContentView.titleLable.lableText", comment: "")
            static let descriptionLableText = NSLocalizedString("main.NoContentView.descriptionLable.lableText", comment: "")
        }
        
        enum NoteVC {
            static let titleTextFieldPlaceholder = NSLocalizedString("main.NoteVC.titleTextField.placeholder", comment: "")
            static let textViewPlaceholder = NSLocalizedString("main.NoteVC.textView.placeholder", comment: "")
        }
    }
    enum auth {
        
        static let authInfoText = NSLocalizedString("auth.infoLabel.authText", comment: "")
        static let regInfoText = NSLocalizedString("auth.infoLabel.regText", comment: "")
        static let navigationTitle = NSLocalizedString("auth.navigation.title", comment: "")
        
        enum segmentedControlItems {
            static let firstItem = NSLocalizedString("auth.segmentedControl.firstItem", comment: "")
            static let secondItem = NSLocalizedString("auth.segmentedControl.secondItem", comment: "")
        }
        
        enum enterButton {
            static let logText = NSLocalizedString("auth.enterButton.logText", comment: "")
            static let regText = NSLocalizedString("auth.enterButton.regText", comment: "")
        }
        
        enum autharizationVM {
            enum editCell {
                enum title {
                    static let mail = NSLocalizedString("auth.autharizationVM.editCell.title.mail", comment: "")
                    static let password = NSLocalizedString("auth.autharizationVM.editCell.title.password", comment: "")
                }
                enum placeholder {
                    static let mail = NSLocalizedString("auth.autharizationVM.editCell.placeholder.mail", comment: "")
                    static let password = NSLocalizedString("auth.autharizationVM.editCell.placeholder.password", comment: "")
                }
            }
        }
        
        enum registrationVM {
            enum editCell {
                enum title {
                    static let mail = NSLocalizedString("auth.registrationVM.editCell.title.mail", comment: "")
                    static let password = NSLocalizedString("auth.registrationVM.editCell.title.password", comment: "")
                    static let name = NSLocalizedString("auth.registrationVM.editCell.title.name", comment: "")
                    static let surname = NSLocalizedString("auth.registrationVM.editCell.title.surname", comment: "")
                    static let about = NSLocalizedString("auth.registrationVM.editCell.title.about", comment: "")
                }
                enum placeholder {
                    static let mail = NSLocalizedString("auth.registrationVM.editCell.placeholder.mail", comment: "")
                    static let password = NSLocalizedString("auth.registrationVM.editCell.placeholder.password", comment: "")
                    static let name = NSLocalizedString("auth.registrationVM.editCell.placeholder.name", comment: "")
                    static let surname = NSLocalizedString("auth.registrationVM.editCell.placeholder.surname", comment: "")
                    static let about = NSLocalizedString("auth.registrationVM.editCell.placeholder.about", comment: "")
                }
            }
        }
    }
    
    enum validation {
        static let containDigitRegularExpression = NSLocalizedString("valid.containDigitRegularExpression", comment: "")
        static let containCharRegularExpression = NSLocalizedString("valid.containCharRegularExpression", comment: "")
        static let containSymbolRegularExpression = NSLocalizedString("valid.containSymbolRegularExpression", comment: "")
        static let containSpaceRegularExpression = NSLocalizedString("valid.containSpaceRegularExpression", comment: "")
        
        static let mailErrorLessMinSymbols = NSLocalizedString("valid.mailErrorLessMinSymbols", comment: "")
        static let mailErrorMoreMaxSymbols = NSLocalizedString("valid.mailErrorMoreMaxSymbols", comment: "")
        static let mailErrorInvalid = NSLocalizedString("valid.mailErrorInvalid", comment: "")
        
        static let passwordErrorLessMinSymbols = NSLocalizedString("valid.passwordErrorLessMinSymbols", comment: "")
        static let passwordErrorMoreMaxSymbols = NSLocalizedString("valid.passwordErrorMoreMaxSymbols", comment: "")
        static let passwordErrorNoDigit = NSLocalizedString("valid.passwordErrorNoDigit", comment: "")
        static let passwordErrorNoChar = NSLocalizedString("valid.passwordErrorNoChar", comment: "")
        static let passwordErrorNoSymbol = NSLocalizedString("valid.passwordErrorNoSymbol", comment: "")
        static let passwordErrorSpace = NSLocalizedString("valid.passwordErrorSpace", comment: "")
        static let passwordErrorEmoji = NSLocalizedString("valid.passwordErrorEmoji", comment: "")
    }
}
