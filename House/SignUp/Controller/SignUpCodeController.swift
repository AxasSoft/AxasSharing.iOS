//
//  SignUpCodeController.swift
//  House
//
//  Created by Сергей Майбродский on 15.07.2022.
//

import UIKit
import JMMaskTextField
import PromiseKit
import Toast_Swift

class SignUpCodeController: UIViewController {
    var userPhone = ""
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var codeTextField: JMMaskTextField!
    
    @IBOutlet weak var repeatCodeButton: UIButton!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    var repeatSend = false
    var timer = Timer()
    var seconds = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureToHideKeyboard()
        sendCode()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupUI()
    }
    
    func setupUI(){
        phoneLabel.text = JMStringMask.initWithMask("+0 (000) 000-00-00")?.maskString(userPhone)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(sendRepeatTimer), userInfo: nil, repeats: true)
        nextButton.setOval()
    }
    
    // MARK: BACK TO PHONE
    @IBAction func close(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: SEND CODE
    func sendCode(){
        firstly{
            SignUpModel.fetchVerificationCode(phone: userPhone)
        }.done { data in
            // if ok
            if (data.message.lowercased() == "ok") {
                self.spinner.stopAnimating()
            } else {
                self.spinner.stopAnimating()
                self.view.makeToast(data.errorDescription)
            }
        }.catch{ error in
            self.spinner.stopAnimating()
            print(error.localizedDescription)
            self.view.makeToast(error.localizedDescription)
        }
    }
    
    
    // MARK: REPEAT SEND
    @IBAction func repeatSendCode(_ sender: Any) {
        if repeatSend {
            seconds = 60
            repeatSend = false
            sendCode()
        }
    }
    
    // timer parametres
    @objc func sendRepeatTimer(){
        seconds -= 1
        if seconds > 0{
            timerLabel.text = "(\(seconds))"
        }
        if seconds == 0 {
            repeatSend = true
            timerLabel.text = ""
        }
    }
    
    
    // MARK: SIGN IN
    @IBAction func signIn(_ sender: UIButton) {
        spinner.startAnimating()
        firstly{
            SignUpModel.fetchLogin(phone: userPhone, code: codeTextField.unmaskedText ?? "")
        }.done { data in
            
            // if ok
            if (data.message!.lowercased() == "ok") {
                
                UserDefaults.standard.set(data.data?.user?.id, forKey: "id")
                UserDefaults.standard.set(data.data?.tokens?.access?.value, forKey: "accessToken")

                do {
                   try Constants.keychain.set((data.data?.tokens?.access?.value)!, key: "accessToken")
                    try Constants.keychain.set((data.data?.tokens?.refresh?.value)!, key: "refreshToken")
                }
                
                print("registered")
                
                self.spinner.stopAnimating()
                UserDefaults.standard.set(true, forKey: "isRegistration")
                    let nextSBoard = UIStoryboard(name: "TabBar", bundle: .main)
                    let vc = nextSBoard.instantiateViewController(withIdentifier: "TabBarVC")
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                
                
                
            } else {
                self.spinner.stopAnimating()
                self.view.makeToast("\(data.errorDescription ?? "")")
            }
        }.catch{ error in
            self.spinner.stopAnimating()
            print(error.localizedDescription)
            self.view.makeToast(error.localizedDescription, point: .init(x: self.view.bounds.width / 2, y: self.view.bounds.height - 120), title: .none, image: .none) { _ in
            }
            return
        }
    }
    
}
