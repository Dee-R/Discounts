//
//  DiscountCollectionViewController.swift
//  Discounts
//
//  Created by Eddy R on 15/12/2020.
//

import UIKit

private let reuseIdentifier = "Cell1"

class DiscountsCollectionViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout{
    private let itemsPerRow: CGFloat = 5
    private let sectionInsets = UIEdgeInsets(top: 50.0,
                                             left: 10.0,
                                             bottom: 50.0,
                                             right: 10.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 100
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DiscountsCollectionViewCell
        cell.taxButton.setTitle("\(100 - indexPath.row) %", for: .normal)
        // Configure the cell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//     // espace haut bas pour chaque ligne
        return sectionInsets.left
    }
    
    @IBAction func actionButtonTaxTapped(_ sender: UIButton) {
        if let taxPercent:String.SubSequence = sender.titleLabel?.text?.dropLast(2) {
            print(taxPercent)
        }
        
        print("tap")
    }
}
