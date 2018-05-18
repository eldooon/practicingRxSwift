//
//  ViewController.swift
//  PracticingWithRxSwift
//
//  Created by Eldon Chan on 5/17/18.
//  Copyright © 2018 ByEldon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var userNameTextfield: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    
    var isValid : Observable<Bool> {
        return Observable.combineLatest(userNameTextfield.rx.text.asObservable(),   passwordTextField.rx.text.asObservable(), resultSelector: { (usernameText, passwordText) in
            (usernameText?.count)! >= 5 && (passwordText?.count)! >= 5
        })
    }
    let disposebag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        isValid.subscribe(onNext:{ [unowned self] isValid in
            self.logInButton.setTitleColor(isValid ? .green : .red, for: .normal)
            self.logInButton.setTitle(isValid ? "Valid": "Invalid", for: .normal)
            print("Fields are: ", isValid)
        }).disposed(by: disposebag)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}

