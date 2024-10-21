//
//  MediaStorage.swift
//  StressLess
//
//  Created by Xucheng Zhao on 10/20/24.
//

import SwiftUI

class MediaStorage {
    // Store image locally
    func saveImageLocally(image: UIImage) {
        if let data = image.pngData() {
            let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("sample_image.png")
            try? data.write(to: fileURL)
        }
    }

    // Load image from local storage
    func loadImageLocally() -> UIImage? {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("sample_image.png")
        if let data = try? Data(contentsOf: fileURL) {
            return UIImage(data: data)
        }
        return nil
    }
}
