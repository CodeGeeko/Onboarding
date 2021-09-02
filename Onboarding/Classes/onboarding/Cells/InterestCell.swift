//
//  ChipsCell.swift
//  Onboarding
//
//  Created by Kuldeep Bhatt on 2021/09/02.
//

import UIKit

class InterestCell: UICollectionViewCell {
    let sharedColour = UIColor(red: (74.0/255.0), green: (11.0/255.0), blue: (195.0/255.0), alpha: 1.0)
    @IBOutlet private weak var nameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpStyle()
    }

    func setUpStyle() {
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = sharedColour.cgColor
        contentView.layer.cornerRadius = 10.0
        contentView.layer.masksToBounds = true
        nameLbl.textColor = sharedColour
    }

    func configureInterest(with name: String) {
        nameLbl.text = name
    }

    func toggle() {
        if isSelected {
            contentView.backgroundColor = sharedColour
            nameLbl.textColor = .white
        } else {
            contentView.backgroundColor = .white
            nameLbl.textColor = sharedColour
        }
    }

}
