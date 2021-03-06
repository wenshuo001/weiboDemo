//
//  PostCell.swift
//  weiboDemo
//
//  Created by Wenshuo on 2020/5/20.
//  Copyright © 2020 Wenshuo. All rights reserved.
//

import SwiftUI

struct PostCell: View {
    
    let post : Post
    
    @State var presentComment: Bool = false
    var bindingPost : Post{ // 只读属性
        userData.post(forId: post.id)!
    }
    
    @EnvironmentObject var userData: UserData
    
     
    
    var body: some View {
        var post = bindingPost
        return VStack{
            HStack(spacing: 5){
                Image(uiImage: UIImage(named:post.avatar)!)
                    .resizable() // 可缩放
                    .scaledToFill() // 等比填充
                    .frame(width:50,height: 50)
                    .clipShape(Circle()) // 裁剪为圆形图片
                    .overlay(
                        PostVIPBadge(vip :post.vip)
                        .offset(x: 16, y: 16) //偏移 调整位置
                )
                    
                //alignment:.leading 左对齐
                //spacing 俩个空间之间的距离
                VStack(alignment:.leading,spacing: 5){
                    Text(post.name)
                        .font(Font.system(size:16))
                        .foregroundColor(Color.orange)
                        .lineLimit(1)
                    Text(post.date)
                        .font(Font.system(size:11))
                        .foregroundColor(Color.gray)
                        .lineLimit(1)
                }.padding(.leading,10)
                
                 Spacer() // 填充控件之间的全部空隙
                //判断达到条件 隐藏控件 如果没有关注则绘制显示
                if !post.isFollowed{
                
                    Button(action: {
                        post.isFollowed = true
                        self.userData.update(post)
                    }){
                       Text("关注")
                        .font(Font.system(size:14))
                        .foregroundColor(Color.orange)
                        .frame(width:50,height:26)
                        .overlay(RoundedRectangle(cornerRadius: 13)
                        .stroke(Color.orange,lineWidth: 1))
                    }.buttonStyle(BorderlessButtonStyle()) // 去除item的 按钮抢占点击事件。
                }
            }
            
            Text(post.text).font(.system(size: 17))
            
            if !post.images.isEmpty{
                
                PostImageCell(images: post.images, width: UIScreen.main.bounds.width-30)
                
               
                
            }
            Divider() // 添加分割线
    
            HStack(spacing: 0){
                Spacer()
                PostCellToolBarButtom(image: "message", text: post.commentCountText, color: .black){
                     self.presentComment = true
                }.sheet(isPresented: $presentComment){
                    // 推出哪一个View
                    CommentInputView(post: post).environmentObject(self.userData)
                }
                
                
                 Spacer()
                PostCellToolBarButtom(image: post.isLiked ? "heart.fill" : "heart", text: post.likeCountText, color: post.isLiked ? .red : .black){
                    if post.isLiked{
                        post.isLiked = false
                        post.likeCount -= 1
                    }else{
                        post.isLiked = true
                        post.likeCount += 1
                    
                    }
                    self.userData.update(post)
                }
                 Spacer()
            }
            Rectangle() //填充分割线
                .padding(.horizontal,-15)
                .frame(height:10)
                .foregroundColor(Color(red:238/255,green:238/255,blue :238/255))
        }.padding(.horizontal,15)
            .padding(.top,15)
    }
}

struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        let userData = UserData()
        return  PostCell(post: userData.recommendPostList.list[0]).environmentObject(userData)
        
         
    }
}
