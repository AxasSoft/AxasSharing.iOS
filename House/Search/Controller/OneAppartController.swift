//
//  OneAppartController.swift
//  House
//
//  Created by Сергей Майбродский on 16.07.2022.
//

import UIKit
import PromiseKit

class OneAppartController: UIViewController {
    
    var id = 0
    @IBOutlet weak var appartTable: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var appart: Appart?
    @IBOutlet weak var appartTitle: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchApparts()
    }
    
    // MARK: GET APPART
    func fetchApparts(){
        firstly{
            SearchModel.fetchOneAppart(id: id)
        }.done { data in
            // if ok
            if (data.message!.lowercased() == "ok") {
                self.appart = data.data
                self.spinner.stopAnimating()
                self.appartTitle.text = self.appart?.title
                self.appartTable.reloadData()
            } else {
                self.spinner.stopAnimating()
                self.view.makeToast(data.errorDescription)
            }
        }.catch{ error in
            self.spinner.stopAnimating()
            print(error.localizedDescription)
            self.view.makeToast(error.localizedDescription)
        }
    }
}


//MARK: TABLE VIEW
extension OneAppartController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let appartCell = tableView.dequeueReusableCell(withIdentifier: "appartCell", for: indexPath) as! AppartTableViewCell
        
        if appart?.pictures.count == 0 {
            appartCell.mediaCollecctionView.isHidden = true
        } else {
            appartCell.mediaCollecctionView.isHidden = false
        }
        appartCell.address.text = appart?.address
        appartCell.date.text = appart?.address
        appartCell.price.text = "\(appart?.priceShort ?? 0) ₽"
        appartCell.pageControl.numberOfPages = appart?.pictures.count ?? 0
        appartCell.appart = appart
        appartCell.reloadCollectionView()
        
        return appartCell
    }
    
}

