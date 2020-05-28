//
//  HomeNavigationBar.swift
//  weiboDemo
//
//  Created by Wenshuo on 2020/5/28.
//  Copyright © 2020 Wenshuo. All rights reserved.
//

import SwiftUI
let KLableWidth: CGFloat = 60
let KButtonHeight:CGFloat = 24

struct HomeNavigationBar: View {
    
    
    @State var leftPercent:CGFloat
    var body: some View {
        HStack(alignment: .top, spacing: 0){
            Button(action:{
                print("click_camera_btn")
            }){
                Image(systemName: "camera")
                    .resizable()
                    .scaledToFit()
                    .frame(width:KButtonHeight,height: KButtonHeight)
                    .padding(.horizontal,15)
                    .padding(.top,5)
                    .foregroundColor(.black)
                     
            }
            
            Spacer()
            
            VStack(spacing: 3){
                HStack(spacing:0){
                           Text("推荐")
                               .bold()
                               .frame(width:KLableWidth,height: KButtonHeight)
                               .padding(.top,5)
                               .opacity(Double(1 - leftPercent * 0.5))
                               .onTapGesture {
                                withAnimation{ //动画
                                    self.leftPercent = 0
                                }
                                
                               }
                           
                           Spacer()
                           
                           Text("热门")
                           .bold()
                           .frame(width:KLableWidth,height: KButtonHeight)
                           .padding(.top,5)
                           .opacity(Double(0.5 + leftPercent * 0.5))
                           .onTapGesture {
                              withAnimation{
                                   self.leftPercent = 1
                               }
                           }
                       }.font(.system(size: 20))
                
                
                GeometryReader{ geometry in  // GeometryReader 可以获取父容器的宽高 也就是上一级
                    RoundedRectangle(cornerRadius: 2)
                                  .foregroundColor(.orange)
                                  .frame(width:30,height: 4)
                        .offset(x:geometry.size.width * (self.leftPercent - 0.5) + KLableWidth * (0.5 - self.leftPercent))
                    }.frame(height: 6)
                    

            }.frame(width:UIScreen.main.bounds.width*0.5)
            
            Spacer()
            
            Button(action:{
                           print("click_add_btn")
                       }){
                           Image(systemName: "plus.circle.fill")
                               .resizable()
                               .scaledToFit()
                               .frame(width:KButtonHeight,height: KButtonHeight)
                               .padding(.horizontal,15)
                               .padding(.top,5)
                               .foregroundColor(.orange)
                       }
        }
        .frame(width:UIScreen.main.bounds.width)
    }
}

struct HomeNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        HomeNavigationBar(leftPercent: 0)
    }
}
