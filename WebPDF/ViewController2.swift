//
//  ViewController2.swift
//  WebPDF
//
//  Created by MAC on 26/01/21.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var web: UIWebView!
    let urlString = ""
    override func viewDidLoad() {
        super.viewDidLoad()
      let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        web.loadRequest(request)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
