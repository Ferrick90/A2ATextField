//
//  ViewController.swift
//  A2ATextField_Example
//
//  Created by A2AGlobalNetwork on 27/07/2018.
//  Copyright © 2018 Ferrick90. All rights reserved.
//

import UIKit
import A2ATextField

class ViewController: UIViewController {

	@IBOutlet weak var userTextField: A2ATextField!
	@IBOutlet weak var passTextField: A2ATextField!
	@IBOutlet weak var emailTextField: A2ATextField!
	@IBOutlet weak var addressTextField: A2ATextField!
	@IBOutlet weak var submitBtn: UIButton!
	@IBOutlet weak var successLabel: UILabel!
	
	var nameSuccessButton: UIButton!
	var eyeButton: UIButton!
	var emailSuccessButton: UIButton!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		// userTextField
		//self.userTextField.font = UIFont.systemFont(ofSize: 20.0);
		//self.userTextField.placeholder = "Name"
		//self.userTextField.bottomBorderOnly = true
		//self.userTextField.placeholderInactiveColor = UIColor.green
		//self.userTextField.isMandatory = true
		//self.userTextField.errorText = "Please input a valid name"
		
		// userTextField custom right button
		nameSuccessButton = UIButton(type: .custom)
		nameSuccessButton.setImage(UIImage(named: "success"), for: .normal)
		nameSuccessButton.frame = CGRect(x: 0, y: 0, width: 30, height: self.userTextField.frame.size.height)
		nameSuccessButton.imageEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
		nameSuccessButton.isHidden = true
		self.userTextField.rightView = nameSuccessButton
		self.userTextField.rightViewMode = .always
		
		self.userTextField.setValidationBlock { (textField) -> Bool in
			if (!(textField?.text?.isEmpty)!) {
				self.nameSuccessButton.isHidden = false
				return true
			}
			
			self.nameSuccessButton.isHidden = true
			self.userTextField.error()
			
			return false;
		}
		
		
		
		// passTextField custom right button
		eyeButton = UIButton(type: .custom)
		eyeButton.setImage(UIImage(named: "view"), for: .normal)
		eyeButton.frame = CGRect(x: 0, y: 0, width: 30, height: self.passTextField.frame.size.height)
		eyeButton.imageEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
		eyeButton.addTarget(self, action: #selector(eyeButtonAction), for: .touchUpInside)
		self.passTextField.rightView = eyeButton
		self.passTextField.rightViewMode = .always
		
		// passTextField validation
		self.passTextField.setValidationBlock { (textField) -> Bool in
			if ((textField?.text?.count)! < 8) {
				self.passTextField.error()
				return false
			}
			
			return true
		}
		
		// emailTextField custom right button
		emailSuccessButton = UIButton(type: .custom)
		emailSuccessButton.setImage(UIImage(named: "success"), for: .normal)
		emailSuccessButton.frame = CGRect(x: 0, y: 0, width: 30, height: self.emailTextField.frame.size.height)
		emailSuccessButton.imageEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
		emailSuccessButton.isHidden = true
		self.emailTextField.rightView = emailSuccessButton
		self.emailTextField.rightViewMode = .always
		
		// emailTextField
		self.emailTextField.style = .email

		self.successLabel.isHidden = true
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func eyeButtonAction(_ sender: Any) {
		if (self.passTextField.isSecureTextEntry) {
			self.passTextField.isSecureTextEntry = false
			eyeButton.setImage(UIImage(named: "hide"), for: .normal)
		} else {
			self.passTextField.isSecureTextEntry = true
			eyeButton.setImage(UIImage(named: "view"), for: .normal)
		}
	}
	
	@IBAction func submitAction(_ sender: Any) {
		
		self.view.endEditing(true)
		
		var status: Bool = true
		
		if (!self.userTextField.validationSuccess()) {
			status = false
		}
		
		if (!self.passTextField.validationSuccess()) {
			status = false
		}
		
		if (!self.emailTextField.validationSuccess()) {
			status = false
		}
		
		// do somethings like call api or etc.
		if (status == true) {
			self.successLabel.isHidden = false
		} else {
			self.successLabel.isHidden = true
		}
	}
	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
