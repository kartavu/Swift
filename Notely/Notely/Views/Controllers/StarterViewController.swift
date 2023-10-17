//
//  StarterViewController.swift
//  Notely
//
//  Created by Миша Кацуро on 21.09.2023.

import Foundation
import UIKit
import SnapKit
import SystemConfiguration

class StartViewController: UIViewController {
    
    let activityIndicatorView = UIActivityIndicatorView(style: .large)
    let containerView = UIView()
    let photoVector = UIImageView()
    let photoUnion = UIImageView()
    let textLabel = UILabel()
    var userFirebase: UserFirebase?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        makeConstraints()
        
        activityIndicatorView.startAnimating()
        if isConnectedToNetwork() {
            userFirebase = UserFirebase { [weak self] userVM in
                DispatchQueue.main.async {
                    if let userVM = userVM as? UserFirebase {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self!.navigateToMainViewController()
                        }
                    }
                }
            }
        }
        else {
            showNoInternetAlert()
        }
    }
    private func isConnectedToNetwork() -> Bool {
        
        self.activityIndicatorView.startAnimating()
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)

        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                zeroSockAddress in SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }) else {
            return false
        }
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags()

        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }

        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)

        return isReachable && !needsConnection
    }

    private func showNoInternetAlert() {
        let alertController = UIAlertController(
            title: "Отсутствует подключение к интернету",
            message: "Пожалуйста, проверьте ваше сетевое подключение и повторите попытку.",
            preferredStyle: .alert
        )
        
        self.activityIndicatorView.stopAnimating()
         activityIndicatorView.isHidden = false
        
        let retryAction = UIAlertAction(title: "Повторить", style: .default) { [weak self] (_) in
            if self?.isConnectedToNetwork() == true {
                self?.userFirebase = UserFirebase { [weak self] userVM in
                    DispatchQueue.main.async {
                        if let userVM = userVM as? UserFirebase {
                            self?.navigateToMainViewController()
                        }
                    }
                }
            } else {
                self?.showNoInternetAlert()
            }
        }
        alertController.addAction(retryAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func configure() {
        view.backgroundColor = .white

        configureContainerView()
        configurePhoto()
        configurePhotoUnion()
        configureLabel()
        configureIndicator()
    }
    
    private func configureContainerView() {
        containerView.backgroundColor = .white
        view.addSubview(containerView)
    }
    
    private func configurePhoto() {
        photoVector.image = UIImage(named: "Vector 5")
        photoVector.contentMode = .scaleAspectFit
        containerView.addSubview(photoVector)
    }
    
    private func configurePhotoUnion() {
        photoUnion.image = UIImage(named: "Union")
        photoUnion.contentMode = .scaleAspectFit
        containerView.addSubview(photoUnion)
    }
    
    private func configureLabel() {
        textLabel.text = "Notely"
        textLabel.font = UIFont.boldSystemFont(ofSize: 48)
        textLabel.textColor = .black
        containerView.addSubview(textLabel)
    }
    
    private func configureIndicator() {
        activityIndicatorView.color = .black
        containerView.addSubview(activityIndicatorView)
    }
    
    private func makeConstraints() {
        makeConteinerViewConstraints()
        makePhotoConstraints()
        makePhotoUnionConstraints()
        makeLabelConstraints()
        makeIndicatorConstraints()
    }
    
    private func makeConteinerViewConstraints() {
        containerView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(188)
            make.centerX.equalToSuperview()
            make.width.equalTo(279)
            make.height.equalTo(279)
            
        }
    }
    
    private func makePhotoConstraints() {
        photoVector.snp.makeConstraints { (make) in
            make.width.equalTo(122)
            make.height.equalTo(61)
            make.left.equalTo(containerView).offset(67)
            make.top.equalTo(containerView).offset(136)
        }
    }
    
    private func makePhotoUnionConstraints() {
        photoUnion.snp.makeConstraints { (make) in
            make.width.equalTo(87)
            make.height.equalTo(161)
            make.left.equalTo(containerView).offset(177)
            make.top.equalTo(containerView).offset(12)
        }
    }
    
    private func makeLabelConstraints() {
        textLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(containerView)
            make.bottom.equalTo(containerView).offset(-27)
        }
    }
    
    private func makeIndicatorConstraints() {
        activityIndicatorView.snp.makeConstraints { (make) in
            make.top.equalTo(textLabel.snp.bottom).offset(109)
            make.centerX.equalTo(containerView)
            make.width.equalTo(44)
            make.height.equalTo(44.3)
        }
    }

    private func navigateToMainViewController() {
        let mainViewController = MainViewController(userViewModel: userFirebase!)
            navigationController?.setViewControllers([mainViewController], animated: true)
    }
}
