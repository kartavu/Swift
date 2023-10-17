//
//  ValidationViewModel.swift
//  Notely
//
//  Created by Tima Shchekochikhin on 28.09.2023.
//

import UIKit
import Foundation

class ValidationViewModel {
    
    public func checkValidLogin(_ value: String) -> String {
        let regularExpression = Constants.ValidationVC.mailRegularExpression
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        if value.count < Constants.ValidationVC.mailMinSymbols {
            return Strings.validation.mailErrorLessMinSymbols
        } else if value.count > Constants.ValidationVC.mailMaxSymbols {
            return Strings.validation.mailErrorMoreMaxSymbols
        }
        if predicate.evaluate(with: value) {
            return Constants.ValidationVC.correctValidStatus
        } else {
            return Strings.validation.mailErrorInvalid
        }
    }
    
    public func checkValidPassword (_ value: String) -> String {
        if value.count < Constants.ValidationVC.passwordMinSymbols {
            return Strings.validation.passwordErrorLessMinSymbols
        } else if value.count > Constants.ValidationVC.passwordMaxSymbols {
            return Strings.validation.passwordErrorMoreMaxSymbols
        }
        if !containsDigit(value) {
            return Strings.validation.passwordErrorNoDigit
        }
        if !containsChar(value) {
            return Strings.validation.passwordErrorNoChar
        }
        if !containsSymbol(value) {
            return Strings.validation.passwordErrorNoSymbol
        }
        if !containsSpace(value) {
            return Strings.validation.passwordErrorSpace
        }
        if value.count > value.withoutEmoji().count {
            return Strings.validation.passwordErrorEmoji
        }
        return Constants.ValidationVC.correctValidStatus
    }
    
    private func containsDigit(_ value: String) -> Bool {
        let regularExpression = Constants.ValidationVC.containDigitRegularExpression
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return predicate.evaluate(with: value)
    }
    
    private func containsChar(_ value: String) -> Bool {
        let regularExpression = Constants.ValidationVC.containCharRegularExpression
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return predicate.evaluate(with: value)
    }
    
    private func containsSymbol(_ value: String) -> Bool {
        let regularExpression = Constants.ValidationVC.containSymbolRegularExpression
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return predicate.evaluate(with: value)
    }
    
    private func containsSpace(_ value: String) -> Bool {
        let regularExpression = Constants.ValidationVC.containSpaceRegularExpression
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return predicate.evaluate(with: value)
    }
}
