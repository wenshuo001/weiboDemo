//
//  PostCellToolBarButtom.swift
//  weiboDemo
//
//  Created by Wenshuo on 2020/5/24.
//  Copyright © 2020 Wenshuo. All rights reserved.
//

import SwiftUI

struct PostCellToolBarButtom: View {
    let image :String
    let text :String
    let color :Color
    let action : () ->Void // 闭包 类似于 function  可以有参数 ，有则写在括号中
    
    var body: some View {
        Button(action:action){
            HStack(spacing: 5){
                Image(systemName: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width:18,height: 18)
            }
            Text(text).font(.system(size: 15))
        }.foregroundColor(color)
        .buttonStyle(BorderlessButtonStyle())
    }
}

struct PostCellToolBarButtom_Previews: PreviewProvider {
    static var previews: some View {
        PostCellToolBarButtom(image: "heart", text: "点赞", color: Color.red, action: {
            print("点赞成功")
        })
    }
}
