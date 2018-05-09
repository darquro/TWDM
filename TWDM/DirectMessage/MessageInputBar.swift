//
//  MessageInputBar.swift
//  TWDM
//
//  Created by yuki.kuroda on 2018/04/27.
//  Copyright © 2018年 darquro. All rights reserved.
//

import UIKit

class MessageInputBar: UIView {

    @IBOutlet weak var inputTextView: UITextView! {
        didSet {
            inputTextView.delegate = self
            inputTextViewHightDefault = CGSize(width: inputTextView.frame.width, height: inputTextView.frame.height)
        }
    }
    
    private var inputTextViewHightDefault: CGSize = CGSize.zero
    private var inputTextViewHightConstraint: NSLayoutConstraint? {
        return inputTextView.constraints.first {
            $0.firstAttribute == .height
        }
    }
    
    private var postActionObserver: ((String?) -> Void)?
    
    func addObserverPostAction(_ block: @escaping (String?) -> Void) {
        postActionObserver = block
    }
    
    @IBAction func didTapPostButton(_ sender: Any) {
        postActionObserver?(inputTextView.text)
        inputTextView.text = ""
        let size = inputTextView.sizeThatFits(inputTextViewHightDefault)
        inputTextViewHightConstraint?.constant = size.height
    }
    
}

// MARK: - UITextViewDelegate

extension MessageInputBar: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let maxHeight: CGFloat = 200.0;
        
        // fit TextView height by its content
        if textView.frame.size.height < maxHeight {
            let size = textView.sizeThatFits(textView.frame.size)
            inputTextViewHightConstraint?.constant = size.height
        }
    }
}
