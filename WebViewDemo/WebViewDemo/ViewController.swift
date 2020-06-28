//
//  ViewController.swift
//  WebViewDemo
//
//  Created by YueWen on 2020/5/28.
//  Copyright © 2020 YueWen. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(webView)
        
        var request = URLRequest(url: URL(string: "https://jdjdkfk.com")!)
        request.addValue("hahaha1", forHTTPHeaderField: "header1")
        print(request.allHTTPHeaderFields)
        webView.load(request)
        print(request.allHTTPHeaderFields)
    }


}

