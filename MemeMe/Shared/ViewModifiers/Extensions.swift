//
//  Extensions.swift
//  MemeMe (iOS)
//
//  Created by RhaXiel on 31/5/22.
//

import Foundation
import UIKit
import SwiftUI

extension ContentView {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        
        view?.frame = CGRect(x: 0, y: CGFloat(Int.max), width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
        
        let targetSize = controller.view.bounds.size
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        
        return renderer.image { _ in
            view?.drawHierarchy(in: CGRect(origin: .zero, size: self.frameSize), afterScreenUpdates: true)
        }
    }
}
