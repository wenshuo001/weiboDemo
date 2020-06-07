//
//  KeyboardResponder.swift
//  weiboDemo
//
//  Created by Wenshuo on 2020/6/7.
//  Copyright © 2020 Wenshuo. All rights reserved.
//

import SwiftUI

class KeyboardResponder: ObservableObject {
    @Published var keyBoardHeight : CGFloat = 0
    
    func keyboardShow() -> Bool{
        if keyBoardHeight>0 {
          return true
        }
        return false
    }
    
    init(){// 虚拟键盘的监听
        NotificationCenter.default.addObserver(self, selector: #selector(keyboradWillShow(_:)) , name: UIWindow.keyboardWillShowNotification, object: nil)
        //键盘隐藏的通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboradWillHide(_:)) , name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    //键盘即将展示
    @objc private func keyboradWillShow(_ notification: Notification){
        guard let frame = notification.userInfo?[UIWindow.keyboardFrameEndUserInfoKey] as? CGRect else{  //guard 保证返回的是CGRect 否则return
            return
        }
        keyBoardHeight = frame.height
    }
    //键盘即将隐藏
    @objc private func keyboradWillHide(_ notification: Notification){
         keyBoardHeight = 0 
    }
}

 
