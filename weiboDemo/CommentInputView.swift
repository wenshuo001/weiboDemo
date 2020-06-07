//
//  CommentInputView.swift
//  weiboDemo
//
//  Created by Wenshuo on 2020/6/7.
//  Copyright © 2020 Wenshuo. All rights reserved.
//

import SwiftUI

struct CommentInputView: View {
    
    let post: Post
    
    @EnvironmentObject var userData : UserData
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var text: String = ""
    
    //ObservedObject 和 EnvironmentObject（环境对象差不多）不同的是这里必须要赋值
    @ObservedObject private var keyboardResponder = KeyboardResponder()
    
    var body: some View {
        VStack(spacing: 0){
            CommentTextView(text: $text, beginEdittingOnAppear: true)
            
            HStack(spacing: 0){
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss() // 销毁弹出界面
                    print("")
                }){
                    Text("取消").padding()
                }
                 
                Spacer()
                
                Button(action: {
                    print(self.text)
                    self.presentationMode.wrappedValue.dismiss() // 销毁弹出界面
                    var post = self.post
                    post.commentCount += 1
                    self.userData.update(post)
                }){
                    Text("发送").padding()
                }
            }
        }.padding(.bottom, keyboardResponder.keyBoardHeight)
            //判断是否显示安全区域
            .edgesIgnoringSafeArea(keyboardResponder.keyboardShow() ?.bottom : [])
        
    }
}

struct CommentInputView_Previews: PreviewProvider {
    static var previews: some View {
       CommentInputView(post: UserData().recommendPostList.list[0])
    }
}
