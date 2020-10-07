//
//  FirstViewController.swift
//  TestingCustomCollectionView
//
//  Created by Agha Saad Rehman on 06/10/2020.
//

import UIKit
import Alamofire


class FirstViewController: UIViewController {

    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var pageView: UIPageControl!
    
    
    // Images from
    var imgArr = [  UIImage(named:"image_1"),
                    UIImage(named:"image_2") ,
                    UIImage(named:"image_3")]
    
    var imagesArray = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("View Did load??")
        
        pageView.numberOfPages = imgArr.count
        pageView.currentPage = 0
        
        view.layoutIfNeeded()
    }
    
    // Making Network Call
    
    override func viewWillAppear(_ animated: Bool) {
        getImage()
        getImage()
        getImage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Vide did appear?? ")
        addBottomView()
    }
    
    func getImage(){
        
        let remoteImageURL = URL(string: "https://picsum.photos/500/500")!
        
        
        AF.request(remoteImageURL).responseData { (response) in
            if response.error == nil {
                print(response.result)
                
                // Show the downloaded image:
                if let data = response.data {
                    print("Got Image")
                    self.imagesArray.append(UIImage(data: data)!)
                    self.sliderCollectionView.reloadData()
                }
                else{
                    print("failed to get image from URL")
                }
            }
        }
    }
    
    func addBottomView(){
        
        print("BottomViewAdded")
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let navigationController = UINavigationController(rootViewController: vc)
        //navigationController.modalPresentationStyle = .fullScreen
    
        self.addChild(navigationController)
        
        let height = view.frame.height
        let width  = view.frame.width
        
        
        navigationController.view.frame = CGRect(x: 0,
                                                 y: self.view.frame.maxY,
                                                 width: width,
                                                 height: height)
        self.view.addSubview(navigationController.view)
        navigationController.didMove(toParent: self)
    }
}


// CollectionView Functions

extension FirstViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Cell
        cell.imageView.image = imagesArray[indexPath.row]
        cell.imageView.contentMode = UIView.ContentMode.center
        cell.imageView.contentMode = UIView.ContentMode.scaleAspectFill

        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        pageView?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {

        pageView?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
}

extension FirstViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = sliderCollectionView.frame.size
        
        
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
