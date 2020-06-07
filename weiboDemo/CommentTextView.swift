//
//  CommentTextView.swift
//  weiboDemo
//
//  Created by Wenshuo on 2020/6/7.
//  Copyright © 2020 Wenshuo. All rights reserved.
//

import SwiftUI

struct CommentTextView: UIViewRepresentable {
    
    @Binding var text: String
    
    let beginEdittingOnAppear: Bool
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.backgroundColor = .systemGray6
        view.font = .systemFont(ofSize: 18)
        view.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        view.delegate = context.coordinator
        view.text = text
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        if beginEdittingOnAppear,
            uiView.window != nil,
            !context.coordinator.didBecomeFirstResponder,
            !uiView.isFirstResponder{
            context.coordinator.didBecomeFirstResponder = true
            uiView.becomeFirstResponder()
        }
    }
    
    class Coordinator : NSObject, UITextViewDelegate{
        let persent : CommentTextView
        var didBecomeFirstResponder: Bool = false
        init(_ view: CommentTextView){
            persent = view
        }
        
        func textViewDidChange(_ textView : UITextView){
            persent.text = textView.text
        }
    }
}

struct CommentTextView_Previews: PreviewProvider {
    static var previews: some View {
        CommentTextView(text: .constant(""), beginEdittingOnAppear: true)
    }
}
