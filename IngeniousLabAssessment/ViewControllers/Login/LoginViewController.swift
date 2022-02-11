//
//  LoginViewController.swift
//  IngeniousLabAssessment
//
//  Created by Ban Er Win on 10/02/2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
    var isButtonTap : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupTextFields()
        
    }

    
    func setupView() {
        let image = UIImage(named: "app_logo")
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: view.frame.width / 3, y: view.frame.height / 9, width: view.bounds.width / 3, height: view.bounds.height / 6)
        view.addSubview(imageView)
        
        label.center = CGPoint(x: view.frame.width / 2, y: 320)
        label.textAlignment = .center
        label.text = "Inglab Assessment"
        view.addSubview(label)
        
        view.addSubview(signUpButton)
        signUpButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        signUpButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        signUpButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        signUpButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
        
        
    }
    
    
    let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Username"
        tf.borderStyle = .roundedRect
        tf.backgroundColor = UIColor(white: 0, alpha: 0.1)
        let image = UIImage(named: "icon_user")
        tf.leftView = UIImageView(image: image)
        tf.leftView?.frame = CGRect(x: 5, y: 5, width: 20 , height:20)
        tf.leftViewMode = .always
        return tf
        
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.borderStyle = .roundedRect
        tf.backgroundColor = UIColor(white: 0, alpha: 0.1)
        let image = UIImage(named: "icon_password")
        tf.leftView = UIImageView(image: image)
        tf.leftView?.frame = CGRect(x: 10, y: 5, width: 20 , height:20)
        tf.leftViewMode = .always
        
        let button = UIButton(frame: CGRect(x: -10, y: 5, width: 20, height: 20))
        button.setImage(UIImage(named: "icon_eye_close"), for: .normal)
        button.addTarget(self, action: #selector(showTextPassword(button:)), for: .touchUpInside)
        tf.rightView = button
        tf.rightViewMode = .always
        
        return tf
        
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("LOGIN", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 3
        button.backgroundColor = UIColor.blue
        
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()

    
    func setupTextFields() {
            
            let stackView = UIStackView(arrangedSubviews: [usernameTextField, passwordTextField])
            stackView.axis = .vertical
            stackView.spacing = 10
            stackView.distribution = .fillEqually
            stackView.translatesAutoresizingMaskIntoConstraints = false
            
            //add stack view as subview to main view with AutoLayout
            view.addSubview(stackView)
            stackView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 40).isActive = true
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
            stackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            
        }
    
    
    @objc func showTextPassword(button: UIButton) {
    if isButtonTap {
        isButtonTap = false
        button.setImage(UIImage(named: "icon_eye_close"), for: .normal)
        passwordTextField.isSecureTextEntry = true
        
    } else {
        isButtonTap = true
        button.setImage(UIImage(named: "icon_eye_open"), for: .normal)
        passwordTextField.isSecureTextEntry = false
    }
 }
    
    @objc func handleLogin() {
        validateForm()
    }
    
    func validateForm() {
        if (passwordTextField.text?.isEmpty)! || (usernameTextField.text?.isEmpty)! {
            showWarning(msg: "Please do not leave any fields empty", vc: self)
        } else {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let myController = storyBoard.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
            self.navigationController?.pushViewController(myController, animated: true)
        }
        
    }
        

}
