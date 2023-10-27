//
//  ViewController.swift
//  HelloWorld
//
//  Created by Jei Yang on 2023-10-16.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    var images = ["1", "2", "3", "4"]
    var currentImage = 0
    
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func leftButtonTapped(_ sender: Any) {
        shiftImage(isLeft: true)
    }
    @IBAction func rightButtonTapped(_ sender: Any) {
        shiftImage(isLeft: false)
    }
    
    func shiftImage(isLeft: Bool) {
        if (isLeft) {
            currentImage -= 1
            if (currentImage < 0) {
                currentImage = 3
            }
        } else {
            currentImage += 1
            if (currentImage > 3) {
                currentImage = 0
            }
        }
        imageView.image = UIImage(named: images[currentImage])
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "default")
        //let request = NSURLRequest(url: NSURL(string: "https://www.bcit.ca")! as URL)
        let url = URL(string: "https://www.bcit.ca")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Ooops! Something went wrong: \(error)")
            } else if let data = data {
                if let str = String(data: data, encoding: .utf8) {
                    print(str)
                }
            }
        }
        task.resume()
        
        let fileName = "Test"
        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
        print("FilePath: \(fileURL.path)")
        let writeString = "Testing creation of a file in Swift"
        
        do {
            try writeString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print("Failed writing to URL: \(fileURL), Error: " + error.localizedDescription)
        }
        var readString = ""
        do {
            readString = try String(contentsOf: fileURL)
        } catch let error as NSError {
            print("Failed reading from URL: \(fileURL), Error: " + error.localizedDescription)
        }
        print("File Text: \(readString)")

    }
}

