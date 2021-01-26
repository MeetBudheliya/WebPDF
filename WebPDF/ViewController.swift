//
//  ViewController.swift
//  WebPDF
//
//  Created by MAC on 26/01/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var web: UIWebView!
    let path = "https://www.google.com/search?q=meet+budheliya&rlz=1C5CHFA_enIN922IN924&oq=meet&aqs=chrome.2.69i57j69i59l2j0i67i395j0i67i395i433j69i61j69i60l2.4147j1j4&sourceid=chrome&ie=UTF-8"
var bounds = CGRect()
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: path)
        let urlReques = URLRequest(url: url!)
        web.loadRequest(urlReques)
    }
    @IBAction func SaveAsPDF(_ sender: UIButton) {
        let pdfFilePath = self.web.exportAsPdfFromWebView()
        print(pdfFilePath)
        let urll: URL! = URL(string: pdfFilePath)
        web.loadRequest(URLRequest(url: urll))
    }
    
   
  }



extension UIWebView {
    
    // Call this function when WKWebView finish loading
    func exportAsPdfFromWebView() -> String {
        let pdfData = createPdfFile(printFormatter: self.viewPrintFormatter())
        return self.saveWebViewPdf(data: pdfData)
    }
    
    func createPdfFile(printFormatter: UIViewPrintFormatter) -> NSMutableData {
        
        let originalBounds = self.bounds
        self.bounds = CGRect(x: originalBounds.origin.x, y: bounds.origin.y, width: self.bounds.size.width, height: self.scrollView.contentSize.height)
        let pdfPageFrame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.scrollView.contentSize.height)
        let printPageRenderer = UIPrintPageRenderer()
        printPageRenderer.addPrintFormatter(printFormatter, startingAtPageAt: 0)
        printPageRenderer.setValue(NSValue(cgRect: UIScreen.main.bounds), forKey: "paperRect")
        printPageRenderer.setValue(NSValue(cgRect: pdfPageFrame), forKey: "printableRect")
        self.bounds = originalBounds
        return printPageRenderer.generatePdfData()
    }
    
    // Save pdf file in document directory
    func saveWebViewPdf(data: NSMutableData) -> String {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDirectoryPath = paths[0]
        let pdfPath = docDirectoryPath.appendingPathComponent("webViewPdf.pdf")
        if data.write(to: pdfPath, atomically: true) {
            return pdfPath.path
        } else {
            return ""
        }
    }
}

extension UIPrintPageRenderer {
    
    func generatePdfData() -> NSMutableData {
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, self.paperRect, nil)
        self.prepare(forDrawingPages: NSMakeRange(0, self.numberOfPages))
        let printRect = UIGraphicsGetPDFContextBounds()
        for pdfPage in 0 ..< self.numberOfPages {
            UIGraphicsBeginPDFPage()
            self.drawPage(at: pdfPage, in: printRect)
        }
        UIGraphicsEndPDFContext();
        return pdfData
    }
}
