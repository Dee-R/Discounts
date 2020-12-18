//
//  DiscountCollectionViewController.swift
//  Discounts
//
//  Created by Eddy R on 15/12/2020.
//

import UIKit

private let reuseIdentifier = "DiscountsCollectionViewCell"

class DiscountsCollectionViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout{
    // MARK: - 🉑 Setting
    var tagIdButton: Int?
    var discountDidSelected: ( (_ discount : String, _ id : Int) -> Void )?
    
    private let itemsPerRow: CGFloat = 5 // number of item/row
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 10.0, bottom: 50.0, right: 10.0)
    
    // MARK: - 👑 DELEGATE
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DiscountsCollectionViewCell
        cell.taxButton.setTitle("\(100 - indexPath.row) %", for: .normal)
        // Configure the cell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.bounds.width/6.0
        let itemHeight = itemWidth
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left // Space top, bottom, for each row
    }
    
    // MARK: - 🖐 Handle U
    @IBAction func actionButtonTaxTapped(_ sender: UIButton) {
        if let discountPerCent:String.SubSequence = sender.titleLabel?.text?.dropLast(2) {
            guard let tagIdButton = tagIdButton else {return}
            self.discountDidSelected?(String(discountPerCent), tagIdButton) // exe this on DiscountViewContrller from here
            dismiss(animated: true)
        }
    }
}
