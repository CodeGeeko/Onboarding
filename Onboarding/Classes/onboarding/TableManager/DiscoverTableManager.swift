import UIKit

class DiscoverTableManager: NSObject {
    private var videos: [Tutorial]  = []
    private let deviceViewCellHeight: CGFloat = 58.0
    override init() {
        super.init()
    }
    func setDevices(videos: [Tutorial]) {
        self.videos = videos
    }
}
extension DiscoverTableManager: UITableViewDataSource, UITableViewDelegate {
    // MARK: Table View Datasource and Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeuedCell(ofType: UITableViewCell.self, indexPath: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return deviceViewCellHeight
    }
}
