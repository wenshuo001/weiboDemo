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
    
    var body: some View {
        VStack{
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
                       print("点击了关注")
                    }){
                       Text("关注")
                        .font(Font.system(size:14))
                        .foregroundColor(Color.orange)
                        .frame(width:50,height:26)
                        .overlay(RoundedRectangle(cornerRadius: 13)
                        .stroke(Color.orange,lineWidth: 1))
                    }.buttonStyle(BorderlessButtonStyle())
                }
            }
            
            Text(post.text).font(.system(size: 17))
            
            if !post.images.isEmpty{
                loadImage(name:post.images[0])
                .resizable() //可缩放
                .scaledToFill()
                    .frame(width:UIScreen.main.bounds.width-30,height: (UIScreen.main.bounds.width-30)*0.75)
                .clipped()
                
            }
            Divider() // 添加分割线
    
            HStack(spacing: 0){
                Spacer()
                PostCellToolBarButtom(image: "message", text: post.commentCountText, color: .black){
                    print("Click comment button")
                }
                 Spacer()
                PostCellToolBarButtom(image: "heart", text: post.likeCountText, color: .black){
                    print("Click comment ,message")
                }
                 Spacer()
            }
            Rectangle()
                .padding(.horizontal,-15)
                .frame(height:10)
                .foregroundColor(Color(red:238/255,green:238/255,blue :238/255))
        }.padding(.horizontal,15)
            .padding(.top,15)
    }
}

struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        PostCell(post :postList.list[2])
    }
}
