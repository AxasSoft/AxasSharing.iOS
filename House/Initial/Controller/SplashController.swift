//
//  SplashController.swift
//  House
//
//  Created by Сергей Майбродский on 15.07.2022.
//

import UIKit

class SplashController: UIViewController {

//    @IBOutlet weak var logo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        logo.alpha = 0
        DispatchQueue.main.async {
            sleep(3)
            var sBoard = UIStoryboard(name: "SignUp", bundle: .main)
            
            if UserDefaults.standard.bool(forKey: "isRegistration"){
                sBoard = UIStoryboard(name: "TabBar", bundle: .main)
            }
            
            let vc = sBoard.instantiateInitialViewController()
            
            vc?.modalPresentationStyle = .fullScreen
            vc?.modalTransitionStyle = .crossDissolve
            self.present(vc!, animated: true, completion: nil)
        }

    }
}
