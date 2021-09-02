//
//  VideoCell.swift
//  Onboarding-Onboarding
//
//  Created by Kuldeep Bhatt on 2021/08/23.
//

import UIKit

class VideoCell: UITableViewCell {
    @IBOutlet private weak var thumbIconImage: UIImageView!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var topicLabel: UILabel!
    @IBOutlet private weak var viewsIcon: UIImageView!
    @IBOutlet private weak var viewsLabel: UILabel!
    @IBOutlet private weak var likesIcon: UIImageView!
    @IBOutlet private weak var likesLabel: UILabel!
    @IBOutlet private weak var gradeIcon: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }
    
    func configureCell(videoInfo: Tutorial) {
        populateValues(videoInfo: videoInfo)
    }
}
private extension VideoCell {
    func setUp() {
        let viewsImage = UIImage.bundledImage(for: VideoCell.self, with: "viewsIcon", bundleName: "Onboarding")
        viewsIcon.image = viewsImage
        let kudosImage = UIImage.bundledImage(for: VideoCell.self, with: "likesIcon", bundleName: "Onboarding")
        likesIcon.image = kudosImage
    }

    func populateValues(videoInfo: Tutorial) {
        authorLabel.text = videoInfo.teacherName
        topicLabel.text = videoInfo.topicName
        viewsLabel.text = String(format: "%d", videoInfo.views)
        likesLabel.text = String(format: "%d", videoInfo.kudos)
        thumbIconImage.load(path: videoInfo.videoBannerURL)

        var imageName: String = "gold"
        let bundle = Bundle.getBundle(for: VideoCell.self, resourceName: imageName, ext: "pdf")
        gradeIcon.image = UIImage(named: imageName, in: bundle, with: nil)
    }
}
