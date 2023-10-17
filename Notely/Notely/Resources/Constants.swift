//
//  Constants.swift
//  Notely
//
//  Created by Данил Соколов on 13.09.2023.
//
import Foundation

import UIKit

enum Constants {
    enum ProfileInfo {
        static let name = "name"
        static let surname = "surname"
        static let about = "about"
    }
    
    enum NotelyTextView {
        static let padding = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 6)
        static let limitHeight = 100.0
    }
    
    enum NotelyTextField {
        static let padding = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        
        static let bgColor = UIColor(red: 0.95, green: 0.95, blue: 0.96, alpha: 1)
        static let fontSize = 16.0
        static let cornerRadius = 10.0
        static let borderWidth = 0.5
        static let borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.12).cgColor
        static let placeholderColor = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 1)
    }
    
    enum ProfileEditVC {
        enum profileIcon {
            static let imageName = "person.circle.fill"
            static let size = 33
            static let bottomOffset = 10
            static let trailingOffset = 16
        }
        
        enum profileSaveButton {
            static let cornerRadius = 14.0
            static let color = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1).cgColor
            static let leadingTrailingOffset = 16
            static let bottomOffset = 66
            static let height = 56
        }
        
        enum tableView {
            enum cell {
                enum textField {
                    static let bottomOffset = 12
                    static let topOffset = 8
                    static let height = 44
                    static let backgroundColorError = UIColor(red: 0.98, green: 0.922, blue: 0.922, alpha: 1)
                    static let borderColorError = UIColor(red: 0.902, green: 0.275, blue: 0.275, alpha: 1).cgColor
                }
                enum label {
                    static let topOffset = 12
                    static let color = UIColor(red: 0.427, green: 0.471, blue: 0.522, alpha: 1)
                    static let fontSize = 14.0
                }
                enum errorLabel {
                    static let bottomOffset = 12
                    static let textColor = UIColor(red: 0.902, green: 0.275, blue: 0.275, alpha: 1)
                    static let font = UIFont.systemFont(ofSize: 13)
                }
                static let leadingTrailingOffset = 16
                
            }
            static let topOffset = 26
            static let inCellSpacing = 8.0
        }
    }
    
    enum PublicProfile {
        enum pageView {
            static let color = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
        enum containerView {
            static let color = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            static let topOffset = 12
            static let leftOffset = 16
            static let rightOffset = -16
        }
        
        enum profileIcon {
            enum profileIconView {
                static let color = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
                static let cornerRadius = 20.0
                static let size = 40
            }
            
            enum iconProfile {
                static let color = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
                static let font = UIFont.systemFont(ofSize: 15)
            }
        }
        
        enum nameStackView {
            static let spacing = 2.0
        }
        
        enum numberOfNotesLabel {
            static let font = UIFont.systemFont(ofSize: 12)
            static let color = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.6)
        }
        
        enum infoAboutMeLabel {
            static let numberOfLines = 0
            static let topOffset = 12
            static let leftOffset = 16
            static let rightOffset = -16
            static let bottomOffset = -16
        }
    }
    
    enum CollectionView {
        static let topOffset = 12
        
        enum NoteCell {
            enum noteView {
                static let color = UIColor(red: 0.949, green: 0.949, blue: 0.969, alpha: 1)
                static let cornerRadius = 11.0
            }
            
            enum previewTitle {
                static let font = UIFont.boldSystemFont(ofSize: 20)
                static let color = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
                static let numberOfLines = 0
                static let trailingInset = 16
            }
            
            enum previewText {
                static let font = UIFont.systemFont(ofSize: 16)
                static let color = UIColor(red: 0.267, green: 0.267, blue: 0.267, alpha: 1)
                static let numberOfLines = 2
                static let topOffset = 2
                static let heightMultipliedBy = 0.5
            }
            
            enum dateCreated {
                static let font = UIFont.systemFont(ofSize: 14)
                static let color = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 1)
                static let minimumScaleFactor = 0.5
                static let bottomOffset = -16
                static let widthMultipliedBy = 0.5
            }
            
            enum optionsIcon {
                static let imageName = "ellipsis"
                static let color = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
                static let size = 20
                static let topOffset = 16
                static let trailing = -16
            }
        }
        
        enum FolderCell {
            enum folderView {
                static let color = UIColor(red: 0.949, green: 0.949, blue: 0.969, alpha: 1)
                static let cornerRadius = 11.0
            }
            
            enum folderImage {
                static let imageName = "folder"
                static let color = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
                static let size = 24
                static let topOffset = 16
                static let leading = 16
            }
            
            enum titleFolder {
                static let font = UIFont.boldSystemFont(ofSize: 20)
                static let color = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
                static let numberOfLines = 0
                static let leading = 16
                static let trailing = -16
                static let bottomOffset = 2
            }
            
            enum numberOfNotes {
                static let font = UIFont.systemFont(ofSize: 16)
                static let color = UIColor(red: 0.267, green: 0.267, blue: 0.267, alpha: 1)
                static let leading = 16
                static let bottomOffset = -16
            }
            
            enum optionsIcon {
                static let imageName = "ellipsis"
                static let color = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
                static let topOffset = 16
                static let trailing = -16
            }
        }
    }
    
    enum AutharizationVC {
        static let centerXOffset = 16
        
        enum authSegmentedControl {
            static let height = 32
            static let topYOffset = 1
        }
        enum authEnterButton {
            static let height = 56
            static let botYOffset = 32
            static let botYOffsetSmall = 1
            static let topYOffset = 2
            static let backgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1).cgColor
            static let cornerRadius = 14.0
            static let fontText = UIFont.systemFont(ofSize: 17, weight: .semibold)
        }
        enum infoLabel {
            static let topYOffset = 17
            static let textColor = UIColor(red: 0.427, green: 0.471, blue: 0.522, alpha: 1)
            static let textFont = UIFont(name: "Arial", size: 15)
        }
        enum tableView {
            static let topYOffset = 34
        }
    }
    
    enum MainVC {
        enum personButton {
            static let imageName = "person.circle.fill"
            static let size = 33
            static let bottomInset = 10
            static let trailingInset = 64
        }
        
        enum menuButton {
            static let imageName = "ellipsis.circle.fill"
            static let size = 33
            static let bottomInset = 10
            static let trailingInset = 16
        }
        
        enum addButton {
            static let imageName = "plus.circle.fill"
            static let size = 65
            static let bottomOffset = -28
        }
        
        enum segmentedControl {
            static let selectedSegmentIndex = 0
            static let trailingInset = 16
            static let topOffset = 10
        }
        
        enum noContentView {
            static let topOffset = 73
            static let edgesInset = 32
        }
        
        enum switchMenuButton {
            static let imageName = "square.grid.2x2"
            static let size = 24
            static let leading = 16
            static let top = 25
        }
        
        enum numberOfElements {
            static let size = 18
            static let trailing = -16
            static let top = 28
            static let textOfSize: CGFloat = 15
        }
    }
    
    enum NoContentVC {
        enum noteView {
            static let imageName = "note"
            static let size = 48
            static let top = 4
        }
        
        enum titleLable {
            static let numberOfLines = 1
            static let textOfSize: CGFloat = 20
            static let topOffset = 16
        }
        
        enum descriptionLable {
            static let numberOfLines = 2
            static let textOfSize: CGFloat = 16
            static let topOffset = 8
            static let trailingInset = 16
            static let bottomInset = 8
        }
    }
    
    enum NoteVC {
        enum titleTextField {
            static let font = UIFont.boldSystemFont(ofSize: 27)
            static let topOffset = 16
            static let leadingOffset = 24
            static let trailingOffset = 24
            static let height = 41
        }
        
        enum dateLabel {
            static let font = UIFont.systemFont(ofSize: 13)
        }
        
        enum stackView {
            static let topOffset = 16
            static let leadingOffset = 24
            static let trailingOffset = 24
            static let height = 16
        }
        
        enum textView {
            static let font = UIFont.systemFont(ofSize: 17)
            static let topOffset = 16
            static let leadingOffset = 20
            static let trailingOffset = 20
            static let bottomOffser = 16
            
            enum placeholder {
                static let tag = 100
                static let topOffset = 8
                static let leadingOffset = 4
            }
        }
        
        static let optionButtonName = "ellipsis"
    }
    
    enum ValidationVC {
        static let mailMinSymbols = 4
        static let mailMaxSymbols = 40
        static let passwordMinSymbols = 6
        static let passwordMaxSymbols = 12
        static let correctValidStatus = "OK"
        static let mailRegularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        static let containDigitRegularExpression = ".*[0-9]+.*"
        static let containCharRegularExpression = ".*[a-zA-Z]+.*"
        static let containSymbolRegularExpression = ".*[!#$%&'*+-/=?^_`{|}~]+.*"
        static let containSpaceRegularExpression = "^\\S*$"
    }
    
    enum Firebase {
        static let defaultFolderName = "Default"
        enum notesCollection {
            static let name = "notes"
            enum fields {
                static let title = "title"
                static let text = "text"
                static let authorID = "authorID"
                static let folderID = "folderID"
                static let isPublic = "isPublic"
                static let date = "date"
            }
        }
        
        enum usersCollection {
            static let name = "users"
            enum fields {
                static let name = "name"
                static let surname = "surname"
                static let about = "about"
            }
        }
        
        enum foldersCollection {
            static let name = "folders"
            enum fields {
                static let authorID = "authorID"
                static let name = "name"
            }
        }
    }
}
