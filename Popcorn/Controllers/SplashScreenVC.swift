//
//  SplashScreenVC.swift
//  Popcorn
//
//  Created by ilkay sever on 25.06.2020.
//  Copyright © 2020 ilkay sever. All rights reserved.
//

import UIKit
import Alamofire
import Reachability

class SplashScreenVC: UIViewController {
    
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var moveButton: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    let networkCheck = try! Reachability()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide NavigationBar in this viewController.
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show NavigationBar other viewController.
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if NetworkManager.shared.reachabilityManager?.isReachable == true {
            startIndicator()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.stopIndicator()
                self.logoImg.isHidden = false
            }
        } else {
            showAlert(titleInput: "HATA!", messageInput: "İnternet Bağlantınız Yok...")
        }
    }
    
    @IBAction func moveButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "SearchVC", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "SearchVC") as! SearchVC
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    func startIndicator(){
        spinner.startAnimating()
    }
    
    func stopIndicator(){
        spinner.stopAnimating()
        spinner.isHidden = true
    }
    
    func showAlert(titleInput: String, messageInput:String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

class NetworkManager {
    
    //shared instance
    
    static let shared = NetworkManager()
    
    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "http://omdbapi.com")
    
    func startNetworkReachabilityObserver() {
        
        switch reachabilityManager?.status {
            
        case .reachable(.cellular):
            print("Hücresel Veri Kullanılabilir...")
            
        case .reachable(.ethernetOrWiFi):
            print("Wi-fi Kullanılabilir...")
            
        case .notReachable:
            print("İnternet Erişiminiz Bulunmamaktadır...")
            
        default:
            break
        }
    }
}
