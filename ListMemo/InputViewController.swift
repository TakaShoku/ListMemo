//
//  InputViewController.swift
//  ListMemo
//
//  Created by 曽和寛貴 on 2018/10/24.
//  Copyright © 2018 曽和寛貴. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications

class InputViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var categoryTextField: UITextField!
    
    
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
        categoryTextField.text = list.category

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
            self.list.category = self.categoryTextField.text!
            self.realm.add(self.list, update: true)
            
        }
        
        setNotification(list: list)
        
        super.viewWillDisappear(animated)
    }
    
//    タスクのローカル通知を登録する
    func setNotification(list: List) {
        
        let content = UNMutableNotificationContent()
//        タイトルと内容を設定(中身がない場合メッセージ無しで音だけの通知になるので「(xxなし)」を表示する)
        if list.title == "" {
            content.title = "(タイトルなし)"
        } else {
            content.title = list.title
        }
        
        if list.contents == "" {
            content.body = "(内容なし)"
        } else {
            content.body = list.contents
        }
        
        if list.category == "" {
            content.title = "(タイトルなし)"
        } else {
            content.title = list.category
        }
        
        content.sound = UNNotificationSound.default
        
//        ローカル通知が発動するtrigger（日付マッチ）を作成
        let calender = Calendar.current
        let dateConponents = calender.dateComponents([.year, .month, .day, .hour, .minute], from: list.date)
        let trigger = UNCalendarNotificationTrigger.init(dateMatching: dateConponents, repeats: false)
        
//        identifier, content, triggerからローカル通知を作成（identifierが同じだとローカル通知を上書き保存）
        let request = UNNotificationRequest.init(identifier: String(list.id), content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
//            error が nil ならローカル通知の登録に成功したと表示します。errorが存在すればerrorを表示します。
            print(error ?? "ローカル通知登録 OK")
        }
        
//        未通知のローカル通知一覧をログ出力
        center.getPendingNotificationRequests{ (requests: [UNNotificationRequest])  in for request in requests {
            print("/---------------")
            print(request)
            print("---------------/")
            }
            
        }
        
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

