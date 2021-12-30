//
//  SafariView.swift
//  InvestmentTracker
//
//  Created by Roman Kavinskyi on 12/20/21.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {

    typealias UIViewControllerType = SFSafariViewController
    
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {}
}
