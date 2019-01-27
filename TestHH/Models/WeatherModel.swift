//
//  WeatherModel.swift
//  TestHH
//
//  Created by Anna Miksiuk on 27.01.2019.
//  Copyright © 2019 Anna Miksiuk. All rights reserved.
//

struct WeatherModel: Decodable {
    let coord: Coordinate
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int64
    let wind: Wind
    let clouds: Cloud
    let dt: Int64
    let sys: Sys
    let id: Int64
    let name: String
    let cod: Int64
}

struct Coordinate: Decodable {
    let lon: Double
    let lat: Double
}

struct Weather: Decodable {
    let id: Int64
    let main: String
    let description: String
    let icon: String
}

struct Main: Decodable {
    let temp: Double
    let pressure: Int64
    let humidity: Int64
    let tempMin: Double
    let tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case pressure
        case humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct Wind: Decodable {
    let speed: Double
    let deg: Double
}

struct Cloud: Decodable {
    let all: Int64
}

struct Sys: Decodable {
    let type: Int64
    let id: Int64
    let message: Double
    let country: String
    let sunrise: Int64
    let sunset: Int64
}
