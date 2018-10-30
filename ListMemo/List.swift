//
//  List.swift
//  ListMemo
//
//  Created by 曽和寛貴 on 2018/10/25.
//  Copyright © 2018 曽和寛貴. All rights reserved.
//

import RealmSwift

class List: Object {
    // 管理用 ID。プライマリーキー
    @objc dynamic var id = 0
    
    // タイトル
    @objc dynamic var title = ""
    
    // 内容
    @objc dynamic var contents = ""
    
    /// 日時
    @objc dynamic var date = Date()
    
//    カテゴリー（追加プロパティ）
    @objc dynamic var category: String = ""
    
    /**
     id をプライマリーキーとして設定
     */
    override static func primaryKey() -> String? {
        return "id"
    }
}
