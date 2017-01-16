//
//  VillainCollectionViewController.swift
//  BondVillains
//
//  Created by Gabrielle Miller-Messner on 2/3/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import Foundation
import UIKit

// MARK: - VillainCollectionViewController: UICollectionViewController

class VillainCollectionViewController: UICollectionViewController {

  @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
  var dimension: CGFloat!;
  // MARK: Properties

  // TODO: Add outlet to flowLayout here.

  // Get ahold of some villains, for the table
  // This is an array of Villain instances
  let allVillains = Villain.allVillains

  // MARK: Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    //TODO: Implement flowLayout here.
    let space: CGFloat = 3.0
    dimension = (view.frame.size.width - (2 * space)) / 3.0
    flowLayout.minimumInteritemSpacing = space
    flowLayout.minimumLineSpacing = space
    flowLayout.itemSize = CGSize(width: dimension, height: dimension)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.tabBarController?.tabBar.isHidden = false
  }

  // MARK: Collection View Data Source

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.allVillains.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VillainCollectionViewCell", for: indexPath) as! VillainCollectionViewCell;
    let villain = self.allVillains[(indexPath as NSIndexPath).row]

    // Set the name and image
    cell.nameLabel.text = villain.name

    let frame = cell.nameLabel.frame;
    cell.nameLabel.frame = CGRect(x: frame.minX, y: frame.minY, width: dimension - 20, height: frame.height);
    cell.nameLabel.textAlignment = NSTextAlignment.center;

    let centerXConstraint = NSLayoutConstraint(item: cell.nameLabel,
                                               attribute: NSLayoutAttribute.centerX,
                                               relatedBy: NSLayoutRelation.equal,
                                               toItem: cell,
                                               attribute: NSLayoutAttribute.centerX,
                                               multiplier: 1,
                                               constant: 0);

    NSLayoutConstraint.activate([centerXConstraint]);

    //cell.schemeLabel.text = "Scheme: \(villain.evilScheme)"
    cell.villainImageView?.image = UIImage(named: villain.imageName)
    cell.villainImageView?.frame = CGRect(x: 0, y: 0, width: dimension, height: dimension);

    return cell
  }

  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    let detailController = self.storyboard!.instantiateViewController(withIdentifier: "VillainDetailViewController") as! VillainDetailViewController;
    detailController.villain = self.allVillains[(indexPath as NSIndexPath).row]
    self.navigationController!.pushViewController(detailController, animated: true)
  }
}








