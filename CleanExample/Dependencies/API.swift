//
//  API.swift
//  CleanExample
//
//  Created by Chris on 04/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Combine
import Domain
import Foundation

class API: AnyAPI {
    func execute(request: URLRequest) -> AnyPublisher<Data, Error> {
        let exampleResponse = """
[
    {
        "id": "1",
        "name": "PlayStation 4"
    },
    {
        "id": "2",
        "name": "Xbox 360"
    },
    {
        "id": "3",
        "name": "Xbox One"
    },
    {
        "id": "4",
        "name": "PlayStation 3"
    },
    {
        "id": "5",
        "name": "Super Nintendo Entertainment System"
    },
    {
        "id": "6",
        "name": "Nintendo Entertainment System"
    },
    {
        "id": "7",
        "name": "Nintendo 64"
    },
    {
        "id": "8",
        "name": "Atari"
    },
    {
        "id": "9",
        "name": "Commodore 64"
    },
    {
        "id": "10",
        "name": "GameCube"
    },
    {
        "id": "11",
        "name": "Gameboy"
    },
    {
        "id": "12",
        "name": "Gameboy Color"
    },
    {
        "id": "13",
        "name": "Gameboy Advance"
    },
    {
        "id": "14",
        "name": "Nintendo DS"
    },
    {
        "id": "15",
        "name": "Nintendo 3DS"
    },
    {
        "id": "16",
        "name": "Nintendo Wii"
    },
    {
        "id": "17",
        "name": "Nintendo Wii U"
    },
    {
        "id": "18",
        "name": "PlayStation 2"
    },
    {
        "id": "19",
        "name": "PlayStation"
    },
    {
        "id": "20",
        "name": "PS One"
    },
    {
        "id": "21",
        "name": "Sega Master System"
    },
    {
        "id": "22",
        "name": "Sega Mega Drive"
    },
    {
        "id": "23",
        "name": "Sega Dreamcast"
    },
    {
        "id": "24",
        "name": "Nintendo Switch"
    }
]
"""
        let exampleData = exampleResponse.data(using: .utf8)!
        let result = Result<Data, Error>
            .success(exampleData)
            .publisher
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)

        return AnyPublisher(result)
    }
}
