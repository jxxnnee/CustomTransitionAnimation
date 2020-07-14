//
//  ViewController.swift
//  CustomViewAnimation
//
//  Created by OODDY MAC on 2020/07/14.
//  Copyright © 2020 MIN KYUNG JUN. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var collection: UICollectionView!
    var presentTransition = AnimationTransition()
    var dismissTransition = DismissTransition()
    let itemSize = UIScreen.main.bounds.width / 2 - 3
    
    private var nayeons: [UIImage] {
        var images: [UIImage] = []
        for index in 0...3 {
            if let image = UIImage(named: "nayeon\(index)")?.resized(to: itemSize) {
                images.append(image)
            }
        }
        return images
    }
    
}


// MARK: Life Cycle
extension MainViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        
        self.collection.delegate = self
        self.collection.dataSource = self
        self.collection.backgroundColor = .black
        self.collection.register(UINib(nibName: "CollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "CollectionViewCell")
        self.resizingCell()
    }
}


// MARK: Custom Functions
extension MainViewController {
    
    private func resizingCell() {
        // 셀 크기를 핸드폰 화면에 맞춰 두칸씩 나오도록 세팅
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.itemSize, height: self.itemSize)

        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3

        self.collection.collectionViewLayout = layout
    }
    
    private func setRect(image: UIImage, cell: UICollectionViewCell) -> CGRect{
        if image.size.width < image.size.height {
            let x = cell.frame.minX + (cell.frame.size.width - image.size.width) / 2
            return CGRect(x: x, y: cell.frame.minY, width: image.size.width, height: image.size.height)
        } else {
            let y = cell.frame.minY + (cell.frame.size.height - image.size.height) / 2
            return CGRect(x: cell.frame.minX, y: y, width: image.size.width, height: image.size.height)
        }
    }
}


// MARK: Collection View Delegate
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.image.image = nayeons[indexPath.row]
        
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell else {
            return
        }
        
        // 나타낼 View 첫 Frame(x,y,width,height) 설정
        let rect = setRect(image: nayeons[indexPath.row], cell: cell)
        let cellOriginPoint = cell.superview?.convert(cell.center, to: nil)
        let cellOriginFrame = cell.superview?.convert(rect, to: nil)
        
        // Transition에 Point와 Frame 설정
        presentTransition.setPoint(cellOriginPoint)
        presentTransition.setFrame(cellOriginFrame)

        guard let subView = self.storyboard?.instantiateViewController(withIdentifier: "SubViewController") as? SubViewController else {
            return
        }
        // 나타낼 View에 Image값 전달, Delegate 설정
        subView.imageStr = "nayeon\(indexPath.row)"
        subView.transitioningDelegate = self
        subView.modalPresentationStyle = .custom

        present(subView, animated: true)
    }
}


// MARK: Transition Animation Delegate
extension MainViewController: UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    
    // present될때 실행애니메이션
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
       return presentTransition
    }
    
    // dismiss될때 실행애니메이션
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
       return dismissTransition
    }
  
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
       // Presenting usually doesn't have any interactivity
       return nil
    }
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
       return nil
    }
   
    // UINavigationControllerDelegate push/pop 애니메이션
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
           return nil
    }
}
