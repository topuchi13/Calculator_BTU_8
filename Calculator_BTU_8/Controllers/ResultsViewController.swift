//
//  ResultsViewController.swift
//  ResultsViewController
//
//  Created by Nika Topuria on 29.09.21.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet var historyView: UILabel!
    
    var historyContainer: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyView.text = historyContainer.joined(separator: "\n")
    }

}
