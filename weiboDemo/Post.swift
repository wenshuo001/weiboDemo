//
//  Post.swift
//  weiboDemo
//
//  Created by Wenshuo on 2020/5/24.
//  Copyright © 2020 Wenshuo. All rights reserved.
//

import SwiftUI

struct PostList:Codable {
    var list : [Post]
}

// 模型类
// let 声明常量。var 声明变量
//Identifiable 列表默认将id 作为唯一标识符
struct Post :Codable,Identifiable{
    let id: Int
    let avatar :String
    let vip: Bool
    let name:String
    let date:String
    
    var isFollowed : Bool
    
    let text :String
    let images :[String]
    
    var commentCount:Int
    var likeCount:Int
    var isLiked:Bool
    
   
}
 //extension 扩展某个类
extension Post{
    //只读属性 不能赋值
       var commentCountText:String{
           if commentCount <= 0 {return "评论"}
           if commentCount < 1000 {return "\(commentCount)"}
           return String(format: "%.1fk", Double(commentCount)/1000)
       }
       var likeCountText:String{
           if likeCount <= 0 {return "点赞"}
           if likeCount < 1000 {return "\(likeCount)"}
           return String(format: "%.1fk", Double(likeCount)/1000)
       }
}

let postList = loadPostListData("PostListData_recommend_1.json")

func loadPostListData(_ fileName: String)-> PostList{
    guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else{
        fatalError("Can not find \(fileName) in main bundle")
    }
    guard let data =  try? Data(contentsOf: url) else{
        fatalError("Can not find \(url)")
    }
    guard let list =  try? JSONDecoder().decode(PostList.self, from: data) else{
        fatalError("Can not parse post list json data")
    }
    return list
}
 
func loadImage(name :String) -> Image{
    return Image(uiImage: UIImage(named: name)!)
}
