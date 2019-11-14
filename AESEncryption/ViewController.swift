//
//  ViewController.swift
//  AESEncryption
//
//  Created by 정기욱 on 2019/11/14.
//  Copyright © 2019 kiwook. All rights reserved.
//

import UIKit
import CryptoSwift

class ViewController: UIViewController {
    
    
    @IBOutlet weak var originalTextField: UITextField!
    @IBOutlet weak var encryptLabel: UILabel!
    @IBOutlet weak var decryptLabel: UILabel!
    @IBOutlet weak var hashLabel: UILabel!
    
    @IBAction func encryption(_ sender: Any) {
        guard let originalText = originalTextField.text else {
            return
        }
        
        guard let encryptedText = try? AES(key: self.key, iv: self.iv, padding: .pkcs7).encrypt(originalText.bytes) else {
            return
        }
        self.encryptedStr = encryptedText
        
        DispatchQueue.main.async {
            self.encryptLabel.text = "암호화한 값 : " + encryptedText.toHexString()
        }
    }
    
    @IBAction func decryption(_ sender: Any) {
        
        guard let decryptedText = try? AES(key: self.key, iv: self.iv, padding: .pkcs7).decrypt(self.encryptedStr) else {
            return
        }
        
        if String(bytes: decryptedText, encoding: .utf8) != nil {
            let decryptedTextNotOptional = String(bytes: decryptedText, encoding: .utf8)!
            
            DispatchQueue.main.async {
                self.decryptLabel.text = "복호화한 값 : " + decryptedTextNotOptional
            }
        }
    }
    
    @IBAction func hashing(_ sender: Any) {
        DispatchQueue.main.async {
            self.hashLabel.text = "해쉬한 값 : " + (self.originalTextField.text?.sha1() ?? "")
        }
        
    }
    
    @IBAction func reset(_ sender: Any) {
        self.originalTextField.text = ""
    }
    
    let key: String = "passwordpasswordpasswordpassword" // 키 32자리
    let iv : String = "1234567890123456" // iv 16자리
    let plainText: String = "암호화 할 문장"
    var encryptedStr : [UInt8] = [UInt8]()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }



    
}

