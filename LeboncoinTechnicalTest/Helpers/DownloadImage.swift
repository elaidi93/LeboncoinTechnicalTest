//
//  Extension+UIImage.swift
//  LeboncoinTechnicalTest
//
//  Created by hamza on 09/01/2022.
//

import UIKit
import Combine

class ImageLoader {
    
    static let shared = ImageLoader()
    
    func load(from url: String, completion: @escaping (Data?, Error?) -> Void) {
        
        guard let url = URL(string: url)
        else { return }
        
        // Compute a path to the URL in the cache
        let fileCachePath = FileManager.default.temporaryDirectory
            .appendingPathComponent(
                url.lastPathComponent,
                isDirectory: false
            )
        
        // load the image from the cache and exit
        if let data = try? Data(contentsOf: URL(fileURLWithPath: fileCachePath.path)) {
            completion(data, nil)
            return
        }
        
        // download the image If does not exist in the cache
        download(url: url, toFile: fileCachePath) { error in
            let data = try? Data(contentsOf: URL(fileURLWithPath: fileCachePath.path))
            completion(data, error)
        }
    }
    
    private func download(url: URL, toFile file: URL, completion: @escaping (Error?) -> Void) {
        // Download the remote URL to a file
        let task = URLSession.shared.downloadTask(with: url) {
            (tempURL, response, error) in
            // Early exit on error
            guard let tempURL = tempURL else {
                completion(error)
                return
            }

            do {
                // Remove any existing document at file
                if FileManager.default.fileExists(atPath: file.path) {
                    try FileManager.default.removeItem(at: file)
                }

                // Copy the tempURL to file
                try FileManager.default.copyItem(
                    at: tempURL,
                    to: file
                )

                completion(nil)
            }

            // Handle potential file system errors
            catch {
                completion(error)
            }
        }

        // Start the download
        task.resume()
    }
}
