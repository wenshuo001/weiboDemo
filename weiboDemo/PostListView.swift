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
     
    var postList: PostList{
        switch cateGory {
        case .recommend:
            return loadPostListData("PostListData_recommend_1.json")
        case .hot:
            return loadPostListData("PostListData_hot_1.json")
        }
    }
     
    var body: some View {
        List{
            //ForEach(postList.list,id: \.id){post in。
            //因为在模型类中写了Identifiable 这里可以将 id 省略
            ForEach(postList.list){post in
                ZStack{  //去除NavigationView 默认箭头样式
                     PostCell(post: post)
                    NavigationLink(destination: Text("detail")){ // item 点击事件跳转
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
            .navigationBarTitle("111")// 必须设置title 才能隐藏bar
            .navigationBarHidden(true)
        }
        
    }
}
