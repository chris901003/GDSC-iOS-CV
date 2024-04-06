// Created for GDSC-CV in 2024
// Using Swift 5.0
//
//
// Created by HongYan on 2024/4/6.
// Copyright © 2024 HongYan. All rights reserved.

import Foundation

typealias Experience = (title: String, company: String, start: String, end: String)

struct Resume {
    static let shared = Resume()
    let name     = "Hong Yan"
    let title    = "iOS Developer"
    let location = "位置：台灣"
    let bio      = "學習Swift中，並且希望可以帶各位進入Swift與iOS開發的世界中。"
    let skills   = ["python", "swift", "mySQL", "xd"]
    let experiences: [Experience] = [("Synology iOS App Intern",
                                      "Synology",
                                      "2023 年 7 月",
                                      "現在"),
                                     ("xxx 職位",
                                      "xxx 公司",
                                      "2020 年 5 月",
                                      "2022 年 7 月"),
                                     ("yyy 職位",
                                      "yyy 公司",
                                      "2020 年 1 月",
                                      "2021 年 5 月")]
    let phoneUrl = "tel://0987999103"
    let socialMedia: [(name: String, url: String)] = [("LinkedIn","https://www.linkedin.com"),
                                                      ("Line","https://line.me"),
                                                      ("YouTube","https://www.youtube.com")]
}

