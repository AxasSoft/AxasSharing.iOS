//
//  SignUpController.swift
//  House
//
//  Created by Сергей Майбродский on 15.07.2022.
//

import UIKit
import JMMaskTextField
import Toast_Swift

class SignUpController: UIViewController {

    @IBOutlet weak var phoneTF: JMMaskTextField!
    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var policyButton: UIButton!
    @IBOutlet weak var nextbutton: UIButton!
    
    
    var checkPolicy = false

    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureToHideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupUI()
    }
    
    func setupUI(){
        phoneTF.setOval()
        nextbutton.setOval()
    }

    
    @IBAction func confirmPolicy(_ sender: UIButton){
        if checkPolicy {
            checkboxButton.setImage(UIImage(systemName: "square"), for: .normal)
        } else {
            checkboxButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        }
        checkPolicy = !checkPolicy
    }

    //MARK: PHONE LOGIN
    @IBAction func signIn(_ sender: UIButton!){
        // check phone
        let phone = phoneTF.unmaskedText!.replacingOccurrences(of: "+[ ()]", with: "", options: .regularExpression, range: nil)
        if phone.count < 10 {
            self.view.makeToast("Номер телефона некорректный")
            return
        }
        if checkPolicy {
            performSegue(withIdentifier: "signInToCode", sender: nil)
        } else {
            self.view.makeToast("Необходимо принять условия пользовательского соглашения")
        }
        
        
    }
    
    
    
    //MARK: PREPARE SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signInToCode" {
            let destinationVC = segue.destination as! SignUpCodeController
            destinationVC.userPhone = phoneTF.unmaskedText!
        }
    }
    
}
