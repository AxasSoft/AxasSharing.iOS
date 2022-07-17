//
//  RentTableViewCell.swift
//  House
//
//  Created by Сергей Майбродский on 17.07.2022.
//

import UIKit

class RentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var rentButton: UIButton!
    @IBOutlet weak var openDoor: UIButton!
    @IBOutlet weak var closeDoor: UIButton!
    
    @IBOutlet weak var doorStack: UIStackView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        rentButton.setSmallRadius()
        openDoor.setSmallRadius()
        closeDoor.setSmallRadius()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
