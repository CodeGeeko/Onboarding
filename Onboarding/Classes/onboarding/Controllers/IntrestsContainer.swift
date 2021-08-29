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
    }
    private func setUpInterestsChips() {
        _ = MDCChipCollectionViewFlowLayout()
        chipCollection.allowsMultipleSelection = true
        chipCollection.register(
            MDCChipCollectionViewCell.self,
            forCellWithReuseIdentifier: "chips")
        let bundle = Bundle.getBundle(for: IntrestsContainer.self, resourceName: "interestsHeader", ext: "pdf")
        topHeaderImage.image = UIImage(named: "interestsHeader", in: bundle, with: nil)
    }
    private func setUpNavigationItems() {
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
}



extension IntrestsContainer: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.interests?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "chips", for: indexPath) as? MDCChipCollectionViewCell else { return UICollectionViewCell() }
        let interest = self.interests?[safe: indexPath.item]
        cell.chipView.titleLabel.text = interest
        configureChipView(with: cell)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //do nothing for now
        print(1)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        //do nothing for now
        print(2)
    }
}

extension IntrestsContainer {
    func configureChipView(with cell: MDCChipCollectionViewCell) {
        cell.chipView.shapeGenerator = MDCRectangleShapeGenerator()
        cell.chipView.setBackgroundColor(.white, for: .normal)
        cell.chipView.setTitleColor(UIColor(hexString: "#4b0bc3"), for: .normal)
        cell.chipView.setBackgroundColor(UIColor(hexString: "#4b0bc3"), for: .selected)
        cell.chipView.setTitleColor(.white, for: .selected)
        cell.chipView.setBorderColor(UIColor(hexString: "#4b0bc3"), for: .normal)
        cell.chipView.setBorderColor(UIColor(hexString: "#4b0bc3"), for: .selected)
        cell.chipView.setBorderWidth(1.0, for: .normal)
        cell.chipView.setBorderWidth(2.0, for: .selected)
    }
}

extension IntrestsContainer: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let yourWidth = collectionView.bounds.width/2.0
        let yourHeight = collectionView.bounds.height/4.0

        return CGSize(width: yourWidth, height: yourHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
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
