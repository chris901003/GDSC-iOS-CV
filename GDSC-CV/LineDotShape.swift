// Created for GDSC-CV in 2024
// Using Swift 5.0
//
//
// Created by HongYan on 2024/4/6.
// Copyright © 2024 HongYan. All rights reserved.


import SwiftUI

enum LineStyle {
    case bottomHalf, full, topHalf
}

struct LineDotShape: Shape {
    var lineWidth: CGFloat = 10
    var dotSize: CGFloat = 30
    var style: LineStyle = .full

    // 一開始的x, y可以先直接使用絕對的資料，並且透過preview來說明使用固定的值會發生的問題
    // 之後再使用rect來獲取正確的位置，並且稍微計算一下怎麼放比較正確
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addEllipse(in: CGRect(
            x: rect.midX - dotSize / 2,
            y: rect.midY - dotSize / 2,
            width: dotSize,
            height: dotSize
        ))
        path.addRect(CGRect(
            x: rect.midX - (lineWidth / 2),
            y: style == .bottomHalf ? rect.midY : rect.minY,
            width: lineWidth,
            height: style == .full ? rect.height : rect.height / 2
        ))
        return path
    }
}

#Preview {
    VStack(spacing: 0) {
        LineDotShape(style: .bottomHalf).background { Color.yellow }
        LineDotShape(style: .full).background { Color.blue }
        LineDotShape(style: .topHalf).background { Color.yellow }
    }
}
