//
//  SVGView.swift
//  fakestagram
//
//  Created by LuisE on 3/16/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit
import WebKit

class SVGView: UIView, WKNavigationDelegate {
    let webSVGView: WKWebView = {
        let wkv = WKWebView()
        wkv.scrollView.isScrollEnabled = false
        wkv.scrollView.scrollsToTop = false
        wkv.scrollView.showsVerticalScrollIndicator = false
        wkv.scrollView.showsHorizontalScrollIndicator = false
        wkv.translatesAutoresizingMaskIntoConstraints = false
        return wkv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        webSVGView.navigationDelegate = self
        addSubview(webSVGView)
        NSLayoutConstraint.activate([
            webSVGView.topAnchor.constraint(equalTo: self.topAnchor),
            webSVGView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            webSVGView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            webSVGView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
    }
    
    public func loadContent(from url: URL, authorId : String) {
        let cache = SVGCache(filename: "imageSVG-\(authorId)")
        if let svg = cache.load(){
            loadContent(from: url, source: svg)
        } else {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    DispatchQueue.global(qos: .background).async  {
                        if let responseSVG = NSString(data: data!, encoding: String.Encoding.utf8.rawValue){
                            DispatchQueue.main.async {
                                self.loadContent(from: url, source: responseSVG as String)
                            }
                            _ = cache.save(svg: responseSVG as String)
                        }
                    }
            }
            task.resume()
        }
    }
    
    public func loadContent(from url: URL, source content: String) {
        webSVGView.loadHTMLString(content, baseURL: url)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let viewScriptHead = """
        var meta = document.createElement('meta');
        meta.setAttribute('name', 'viewport');
        meta.setAttribute('content', 'width=device-width');
        meta.setAttribute('initial-scale', '1.0');
        meta.setAttribute('maximum-scale', '1.0');
        meta.setAttribute('minimum-scale', '1.0');
        meta.setAttribute('user-scalable', 'no');
        document.getElementsByTagName('head')[0].appendChild(meta);
        """
        self.webSVGView.evaluateJavaScript(viewScriptHead, completionHandler: nil)
        //webView.evaluateJavaScript("window.scrollTo(85,0)", completionHandler: nil)
    }
    
    
}
