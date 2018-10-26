//
//  InputViewController.swift
//  ListMemo
//
//  Created by 曽和寛貴 on 2018/10/24.
//  Copyright © 2018 曽和寛貴. All rights reserved.
//

import UIKit
import RealmSwift

class InputViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    var list: List!
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        背景をタップしたらdismissKeyboardメソッドを呼ぶように設定する
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(dismisskeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        titleTextField.text = list.title
        contentsTextView.text = list.contents
        datePicker.date = list.date

        // Do any additional setup after loading the view.
    }
    
    @objc func dismisskeyboard() {
//        キーボードを閉じる
        view.endEditing(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        try! realm.write {
            self.list.title = self.titleTextField.text!
            self.list.contents = self.contentsTextView.text
            self.list.date = self.datePicker.date
            self.realm.add(self.list, update: true)
            
        }
        
        super.viewWillDisappear(animated)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
