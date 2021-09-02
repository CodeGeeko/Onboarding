import UIKit

public protocol VideoInteractable {
    func didSelectVideo(with videoInfo: Any)
}

class DiscoverTableManager: NSObject {
    private var videos: [Tutorial]  = []
    private let cellHeight: CGFloat = 142.0
    var delegate: VideoInteractable?

    func setVideos(videos: [Tutorial]) {
        self.videos = videos
    }
}
extension DiscoverTableManager: UITableViewDataSource, UITableViewDelegate {
    // MARK: Table View Datasource and Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let videoInfo = self.videos[safe: indexPath.row] else { return tableView.defaultTableViewCell() }
        let cell = tableView.dequeuedCell(ofType: VideoCell.self, indexPath: indexPath)
        cell.configureCell(videoInfo: videoInfo)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let videoInfo = self.videos[safe: indexPath.row] else { return }
        self.delegate?.didSelectVideo(with: videoInfo)
    }
}
