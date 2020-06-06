//
//  PostListView.swift
//  weiboDemo
//
//  Created by Wenshuo on 2020/5/24.
//  Copyright © 2020 Wenshuo. All rights reserved.
//

import SwiftUI

struct PostListView: View {
    let cateGory : PostListCategory
     
    @EnvironmentObject var userdata: UserData
    
    var body: some View {
        List{
            //ForEach(postList.list,id: \.id){post in。
            //因为在模型类中写了Identifiable 这里可以将 id 省略
            ForEach(userdata.postList(for: cateGory).list){post in
                ZStack{  //去除NavigationView 默认箭头样式
                     PostCell(post: post)
                    NavigationLink(destination: PostDetailView(post: post)){ // item 点击事件跳转
                      EmptyView()
                    }.hidden()
                }.listRowInsets(EdgeInsets()) //去除 列表样式不正常 ，如不正常边距
            }
        }
        
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{ //页面跳转
            PostListView(cateGory: .recommend)
            .navigationBarTitle("Title")// 必须设置title 才能隐藏bar
            .navigationBarHidden(true)
        }.environmentObject(UserData())
        
    }
}
