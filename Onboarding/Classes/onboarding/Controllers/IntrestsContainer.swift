import MaterialComponents

class IntrestsContainer: UIViewController {
    @IBOutlet private weak var topHeaderImage: UIImageView!
    @IBOutlet private weak var headerLabel: UILabel!
    @IBOutlet private weak var bodyContainerView: UIView!
    @IBOutlet private weak var chipCollection: UICollectionView!
    @IBOutlet private weak var continueBtn: UIButton!
    var delegate: OnboardingFlowControllerDelegate?
    var interests: [String]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.render()
    }
}
// MARK: - Render
extension IntrestsContainer {
    private func render() {
        setUp()
    }
    private func setUp() {
        setUpInterestsChips()
        setUpNavigationItems()
        setUpStyle()
    }
    private func setUpInterestsChips() {
        chipCollection.allowsMultipleSelection = true
        chipCollection.register(
            InterestCell.self,
            forCellWithReuseIdentifier: String(describing: InterestCell.self))
        let image = UIImage.bundledImage(for: IntrestsContainer.self, with: "interestsHeader", bundleName: "Onboarding")
        topHeaderImage.image = image
    }
    private func setUpNavigationItems() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setUpStyle() {
        continueBtn.layer.cornerRadius = 10.0
    }
}



extension IntrestsContainer: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.interests?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(with: InterestCell.self, for: indexPath) else { return UICollectionViewCell() }
        guard let interest = self.interests?[safe: indexPath.item] else { return UICollectionViewCell() }
        cell.configureInterest(with: interest)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? InterestCell else { return }
        cell.toggle()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? InterestCell else { return }
        cell.toggle()
    }
}

extension IntrestsContainer: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let counts = self.interests?.count ?? 0
        let den = CGFloat(counts/2)
        let width = (collectionView.bounds.width/2.0) - 30
        let height = CGFloat(CGFloat(collectionView.bounds.height) / CGFloat(den))
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

extension IntrestsContainer {
    public func setUpContentProvider(with interests: [String]) {
        self.interests = interests
    }
}

extension IntrestsContainer {
    @IBAction func continueDidTap(_ sender: Any) {
        guard let discoverContainer = OnboardingStepFlowFactory.viewController(for: .discover) as?  DiscoverContainer else { return }
        let navigator = OnboardingFlowNavigationCoordinator(with: self.navigationController)
        navigator.pushOrPresent(with: discoverContainer, isPush: true)
    }
}
