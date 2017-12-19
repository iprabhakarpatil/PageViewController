//
//  PoliticsViewController.swift
//  Glynk
//
//  Created by Prabhakar Mac on 12/19/17.
//  Copyright © 2017 prabhakar. All rights reserved.
//

import UIKit

class PoliticsViewController: UIViewController {


    @IBOutlet weak var webView: UIWebView!
    let movieURL = URL(string: "https://timesofindia.indiatimes.com/elections")

    override func viewDidLoad() {
        super.viewDidLoad()
        loadTheMoviesURL()
    }

    @objc func loadTheMoviesURL() {
        let urlRequest = URLRequest(url: movieURL!)
        let sharedURLSession = URLSession.shared
        let sessionTask = sharedURLSession.dataTask(with: urlRequest) { (data, response, error) in

            if error == nil {
                DispatchQueue.main.async {
                    self.webView.loadRequest(urlRequest)
                }
            }else {
                print("Error While Reading Times Of India/Movies")
            }
        }
        sessionTask.resume()
    }


}
