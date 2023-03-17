//
//  Extensions.swift
//  iTunesMusicExplorer
//
//  Created by Matthew Ogtong on 3/16/23.
//

import SwiftUI

extension View {
    func tabBarBackground(color: UIColor) -> some View {
        self.modifier(TabBarAppearance(backgroundColor: color))
    }
}
