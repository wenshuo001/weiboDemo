//
//  HScrollViewController.swift
//  weiboDemo
//
//  Created by Wenshuo on 2020/5/31.
//  Copyright © 2020 Wenshuo. All rights reserved.
// 水平滑动的ScrollView
//

import SwiftUI

struct HScrollViewController<Content: View>: UIViewControllerRepresentable {
    let pageWidth : CGFloat
    let contentSize : CGSize
    let content:Content
    @Binding var leftPerent:CGFloat  //0 滑动到左边 1 右边
    
    init(pageWidth : CGFloat,contentSize : CGSize,leftPerent: Binding<CGFloat>,@ViewBuilder content:() -> Content){
        self.pageWidth = pageWidth
        self.contentSize = contentSize
        self.content = content()
        self._leftPerent = leftPerent
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = context.coordinator
        context.coordinator.scrollview = scrollView
        let vc = UIViewController()
        vc.view.addSubview(scrollView)
         //UIHostingController 把一个view 转换成 ViewController
        let host = UIHostingController(rootView: content)
        vc.addChild(host)
        
        scrollView.addSubview(host.view)
        host.didMove(toParent: vc)
        context.coordinator.host = host
        return vc
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        let scrollview = context.coordinator.scrollview!
        scrollview.frame = CGRect(x: 0,y: 0,width: pageWidth,height: contentSize.height)
        scrollview.contentSize = contentSize
        scrollview.setContentOffset(CGPoint(x: leftPerent * (contentSize.width - pageWidth),y : 0), animated: true)
        
        context.coordinator.host.view.frame = CGRect(origin: .zero, size: contentSize)
        
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        let parent: HScrollViewController
        var scrollview : UIScrollView!
        var host : UIHostingController<Content>!
        
        init(_ parent:HScrollViewController){
            self.parent = parent
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            withAnimation{
                 parent.leftPerent = scrollView.contentOffset.x < parent.pageWidth * 0.5 ? 0 : 1
            }
           
        }
    }
}
 
