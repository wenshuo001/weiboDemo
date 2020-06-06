//
//  UserData.swift
//  weiboDemo
//
//  Created by Wenshuo on 2020/5/28.
//  Copyright © 2020 Wenshuo. All rights reserved.
//
import Combine

// 环境对象必须遵循 ObservableObject 协议
class UserData : ObservableObject{
   @Published var recommendPostList : PostList = loadPostListData("PostListData_recommend_1.json")
   @Published var hotPostList : PostList = loadPostListData("PostListData_hot_1.json")
    
    private var recommendPostDic:[Int:Int]=[:] //key: id ,value:index 存的是这条微博在id里面的序号
    private var hotPostDic:[Int:Int]=[:]   // 一个 [:]  表示一个空的字典

    init(){
        for i in 0..<recommendPostList.list.count{
            let post = recommendPostList.list[i]
            recommendPostDic[post.id] = i
        }
        for i in 0..<hotPostList.list.count{
            let post = hotPostList.list[i]
            hotPostDic[post.id] = i
        }
    }
}

enum PostListCategory{
    case recommend,hot
}

//extension 类扩展 有点像Kotlin 的扩展
extension UserData{
    func postList(for category: PostListCategory) -> PostList{
        switch category {
        case .recommend:
            return recommendPostList
        case .hot:
            return hotPostList
        }
    }
    
    func post(forId id: Int) -> Post?{
        if let index = recommendPostDic[id] {  // 判断 index 不为空的情况下返回此条微博
           return recommendPostList.list[index]
        }
        if let index = hotPostDic[id] {  // 判断 index 不为空的情况下返回此条微博
           return hotPostList.list[index]
        }
        return nil
    }
    
    func update(_ post: Post){
        if let index = recommendPostDic[post.id]{
            recommendPostList.list[index] = post
        }
        
        if let index = hotPostDic[post.id]{
            hotPostList.list[index] = post
        }
    }
}
