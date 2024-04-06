// Created for GDSC-CV in 2024
// Using Swift 5.0
//
//
// Created by HongYan on 2024/4/6.
// Copyright © 2024 HongYan. All rights reserved.


import SwiftUI

struct ContactView: View {
    // 需說明Binding的作用
    @Binding var isShowing: Bool

    var body: some View {
        VStack {
            HStack {
                // 提供一下SFSymbol，說明apple提供給我們的內建icon庫
                Image(systemName: "phone.fill")
                    .resizable().aspectRatio(contentMode: .fit)
                    .foregroundStyle(.white)
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(.brown))
                    .padding(10)
                    .onTapGesture { openUrl(Resume.shared.phoneUrl) }

                ForEach(Resume.shared.socialMedia, id: \.name) { media in
                    Image(media.name.lowercased())
                        .resizable().aspectRatio(contentMode: .fit)
                        .padding(10)
                        .onTapGesture { openUrl(media.url) }
                }
            }

            Button("取消") { isShowing = false }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 20).foregroundStyle(Color(uiColor: UIColor.tertiarySystemBackground)))
        .padding()
        // 說明一下Color與UIColor
    }

    func openUrl(_ url: String) {
        if UIApplication.shared.canOpenURL(URL(string: url)!) {
            UIApplication.shared.open(URL(string: url)!)
        } else {
            print("✅ Can't open url: \(url)")
        }
    }
}

#Preview {
    // 需說明如果有使用到Binding，在preview中該怎麼辦
    ContactView(isShowing: .constant(true))
}
