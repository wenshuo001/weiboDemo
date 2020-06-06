//
//  HomeView.swift
//  weiboDemo
//
//  Created by Wenshuo on 2020/5/28.
//  Copyright © 2020 Wenshuo. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @State var leftPercent: CGFloat = 0
    
    init() {
        // 去除UITableView 默认的 分割线
               UITableView.appearance().separatorStyle = .none
               // 去除UITableViewCell 默认选中样式
               UITableViewCell.appearance().selectionStyle = .none
    }
    var body: some View {
        NavigationView{ 
        
            GeometryReader{ geometry in
                HScrollViewController(pageWidth: geometry.size.width, contentSize:  CGSize(width: geometry.size.width * 2,height: geometry.size.height),leftPerent: self.$leftPercent)
                {
                    HStack(spacing: 0){
                           PostListView(cateGory: .recommend)
                                           .frame(width:UIScreen.main.bounds.width)
                            PostListView(cateGory: .hot)
                                           .frame(width:UIScreen.main.bounds.width)
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)// 忽略底部的安全区域
            .navigationBarItems(leading: HomeNavigationBar(leftPercent: $leftPercent))
                .navigationBarTitle("首页",displayMode: .inline) //隐藏默认的头部导航栏
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(UserData())
    }
}
