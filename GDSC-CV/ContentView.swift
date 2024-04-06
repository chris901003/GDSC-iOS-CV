// Created for GDSC-CV in 2024
// Using Swift 5.0
//
//
// Created by HongYan on 2024/4/6.
// Copyright © 2024 HongYan. All rights reserved.


import SwiftUI

struct ContentView: View {
    // 一開始先使用var，之後再加上State
    // 說明加上State後該變數會被做成特別的管理，所以在不會受到sturct的限制
    @State var isShowing: Bool = false
    let me = Resume.shared

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                HStack {
                    Image("avatar")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(width: 200)
                    
                    VStack(spacing: 20) {
                        Text(me.name)
                            .font(.title2)
                            .bold()
                        Text(me.title)
                            .fontWeight(.semibold)
                        
                        //                    HStack {
                        //                        Image(systemName: "location.fill")
                        //                        Text(me.location)
                        //                    }
                        //                    .foregroundStyle(Color.secondary)
                        Label(
                            title: { Text(me.location) },
                            icon: { Image(systemName: "location.fill") }
                        )
                        .foregroundStyle(Color.secondary)
                    }
                }
                
                Text(me.bio)
                    .lineSpacing(8)
                    .font(.title3)
                
                // 將其改成Button
//                Text("Contact Me")
//                    .foregroundStyle(.white)
//                    .font(.title2.weight(.bold))
//                    .padding(.vertical, 10)
//                    .frame(maxWidth: .infinity)
//                    .background(RoundedRectangle(cornerRadius: 20).foregroundStyle(.brown))

                // 要顯示Contact Me的時候才開啟
                Button {
                    isShowing = true
//                    isShowing.toggle()
                } label: {
                    Text("Contact Me")
                        .foregroundStyle(.white)
                        .font(.title2.weight(.bold))
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 20).foregroundStyle(.brown))
                }
                
                Text("Skills")
                    .bold().font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // 先照著這樣做，然後說明我們不會這樣，因為會有太多重複的code，會改使用for each的方式來呈現
                //            VStack {
                //                Image(me.skills[0])
                //                    .resizable()
                //                    .aspectRatio(contentMode: .fit)
                //                    .frame(width: 50)
                //                Text(me.skills[0])
                //            }.frame(width: 80)
                
                // 需說明id的作用，這部分可能需要稍微提一下KeyPath大概是啥
                // fText(me[keyPath: \.name])，透過這樣的語法，可以直接提取出me當中的name屬性
                HStack {
                    ForEach(me.skills, id: \.self) { skill in
                        VStack {
                            Image(skill.lowercased())
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50)
                            Text(skill)
                        }.frame(width: 80)
                    }
                }
                
                Text("Experience")
                    .bold().font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // 第一步基礎的樣子
                // 此時會發現因為沒有scrollview所以導致後面顯示不完全，資訊開始亂跑，這時我們將scrollview加上
                /*
                VStack(spacing: 0) {
                    ForEach(me.experiences, id: \.title) { exp in
                        HStack {
                            // 最一開始先這樣做，後面使用path的作法來調整
//                            Rectangle().frame(width: 5)
//                                .background(Circle().frame(width: 10))
//                                .padding(.leading, 10)
                            
                            // 等待完成LineDotShape後換成此寫法
                            // 換成此階段後就可以到第二階段
                            LineDotShape(lineWidth: 5, dotSize: 10)
                                .frame(width: 70)
                                .foregroundStyle(.secondary)

                            VStack(spacing: 8) {
                                Group {
                                    Text("\(exp.start) - \(exp.end)").foregroundStyle(.secondary)
                                    Text(exp.title).bold()
                                    Text(exp.company).padding(.bottom, 30)
                                }.frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                }
                 */

                // 第二步，由於需要知道誰是頭以及誰是尾，所以改用indices來進行loop
                VStack(spacing: 0) {
                    ForEach(me.experiences.indices, id: \.self) { index in
                        HStack {
                            LineDotShape(lineWidth: 5, dotSize: 10, style: index == 0 ? .bottomHalf : index == me.experiences.count - 1 ? .topHalf : .full)
                                .frame(width: 70)
                                .foregroundStyle(.secondary)

                            let exp = me.experiences[index]
                            VStack(spacing: 8) {
                                Group {
                                    Text("\(exp.start) - \(exp.end)").foregroundStyle(.secondary)
                                    Text(exp.title).bold()
                                    Text(exp.company).padding(.bottom, 30)
                                }.frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                }
            }
        }
        .padding()
        .overlay {
            // 等到最後再來添加背景灰色
            Color.black.opacity(isShowing ? 0.5 : 0)
                .onTapGesture { isShowing = false }
        }
        .overlay(alignment: .top) {
            Group {
                if (isShowing) {
                    // 需要說明$isShowing與_isShowing是由State所創建出來的
                    // 並且$isShowing表示的是保存該狀態的地址
                    ContactView(isShowing: $isShowing)
                        .offset(y: UIScreen.main.bounds.height * 0.32)
                        .transition(.slide)
                }
            }
        }
        .animation(.spring(), value: isShowing)
    }
}

#Preview {
    ContentView()
}
