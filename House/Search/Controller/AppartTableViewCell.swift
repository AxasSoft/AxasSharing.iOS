//
//  appartTableViewCell.swift
//  NotAlone
//
//  Created by Сергей Майбродский on 29.06.2022.
//

import UIKit
import SDWebImage
import CenteredCollectionView

class AppartTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var mediaCollecctionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var appart: Appart?
    
    var pictures: [String?] = []
    
    var currentCenteredPage = 0
    let cellPercentWidth: CGFloat = 1
    var centeredCollectionViewFlowLayout: CenteredCollectionViewFlowLayout!
    override func awakeFromNib() {
        super.awakeFromNib()
        priceView.setSmallRadius()
        self.mediaCollecctionView.delegate = self
        self.mediaCollecctionView.dataSource = self
        centeredCollectionViewFlowLayout = (mediaCollecctionView.collectionViewLayout as! CenteredCollectionViewFlowLayout)
        mediaCollecctionView.decelerationRate = UIScrollView.DecelerationRate.fast
        mediaCollecctionView.delegate = self
        mediaCollecctionView.dataSource = self
        centeredCollectionViewFlowLayout.itemSize = CGSize( width: 350,  height: 200 * cellPercentWidth)
        centeredCollectionViewFlowLayout.minimumLineSpacing = 20
        mediaCollecctionView.showsVerticalScrollIndicator = false
        mediaCollecctionView.showsHorizontalScrollIndicator = false
    }
    
    
    func reloadCollectionView() -> Void {
        self.mediaCollecctionView.reloadData()
    }
    
    
    //MARK: COLLECTION
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = appart?.pictures.count ?? 0
        pageControl.isHidden = !((appart?.pictures.count ?? 0 ) > 1)
        return appart?.pictures.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! AppartCollectionViewCell
        if cell.imageView != nil {
            cell.imageView.sd_setImage(with: URL(string: appart?.pictures[indexPath.item] ?? ""), placeholderImage: UIImage(named: "Guest"))
        }
        cell.imageView.contentMode = .scaleAspectFill
        return cell
    }
    
    
    //MARK: PAGE CONTROL
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl?.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageControl?.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
    }
}

