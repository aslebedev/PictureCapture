//
//  Picture.swift
//  Project1
//
//  Created by alexander on 13.11.2019.
//

import Foundation

class Picture: Codable {

    var caption: String = ""
    var image: String = ""
    
    enum CodingKeys: CodingKey {
        case caption, image
    }
    
    init() { }
    
    init(caption: String, image: String) {
        self.caption = caption
        self.image = image
    }
    
/*
    @Published var caption: String = ""
    @Published var image: String = ""
    
    init() { }
    
    init(caption: String, image: String) {
        self.caption = caption
        self.image = image
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        caption = try container.decode(String.self, forKey: .caption)
        image = try container.decode(String.self, forKey: .image)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(caption, forKey: .caption)
        try container.encode(image, forKey: .image)
    }
*/
}
