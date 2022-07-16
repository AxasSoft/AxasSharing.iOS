//
//  ContainerAppartsController.swift
//  House
//
//  Created by Сергей Майбродский on 16.07.2022.
//

import UIKit

class SelectorAppartsController: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var clearFilterButton: UIButton!
    
    var filterParameters: [String] = []


    override func viewDidLoad() {
        super.viewDidLoad()

        segmentControl.addTarget(self, action: #selector(segmentValueChanged(_:)), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    func setupUI(){
        filterView.setSmallRadius()
        add(asChildViewController: AppartController)
        if filterParameters.count == 0 {
            filterView.isHidden = true
        } else {
            filterView.isHidden = false
        }
    }
    
    @objc func segmentValueChanged(_ sender: Any) {
        updateView()
    }
    
    // MARK: CHANGED CONTROLLERS
    private lazy var AppartController: AppartController = {
        let storyboard = UIStoryboard(name: "Search", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "AppartListVC") as! AppartController
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    private lazy var MapAppartController: MapAppartController = {
        let storyboard = UIStoryboard(name: "Search", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "AppartMapVC") as! MapAppartController
        self.add(asChildViewController: viewController)
        return viewController
    }()

    
    // MARK: Add controller
    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        containerView.addSubview(viewController.view)
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
    
    
    //MARK: Remove controller
    private func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
     func updateView() {
        remove(asChildViewController: AppartController)
        remove(asChildViewController: MapAppartController)
        
         if segmentControl.selectedSegmentIndex == 0 {
            add(asChildViewController: AppartController)
        } else {
            add(asChildViewController: MapAppartController)
        }
    }
}
