


//  ViewController.swift
//  FGB
//  Created by iOS-Appentus on 07/03/19.
//  Copyright © 2019 appentus. All rights reserved.



import UIKit

class Walk_Through_ViewController: UIViewController {
    @IBOutlet weak var coll_view:UICollectionView!
    @IBOutlet weak var page_controll:UIPageControl!
    
    var arr_WT_title = ["firstscreen".localized,"secondscreen".localized]
    var arr_WT_image = ["WT SCREEN-1.png","WT SCREEN-2.png"]
//    var arr_WT_image = ["img_default_app","WT SCREEN-2.png"]
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    var statusBarView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statusBarView = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as! UIView
        statusBarView.backgroundColor = hexStringToUIColor(hex: "FAF267")
        
        coll_view.layer.cornerRadius = 30
//        coll_view.clipsToBounds = true
        
        page_controll.numberOfPages = arr_WT_title.count
        page_controll.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        statusBarView.backgroundColor = UIColor .clear
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btn_start(_ sender:UIButton) {
        func_present_items_VC()
    }
    
    func func_present_items_VC() {
        let search_VC = storyboard?.instantiateViewController(withIdentifier: "Login_ViewController")
        present(search_VC!, animated: true, completion: nil)
    }

    

}



//  MARK:- UICollectionView methods
extension Walk_Through_ViewController:UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize (width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr_WT_image.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Walk_Through_CollectionViewCell
        
        cell.lbl_title.text = arr_WT_title[indexPath.row]
        cell.img_WT.image = UIImage (named: arr_WT_image[indexPath.row])
        //        MARK:- gradient on label text
//        set_gradient_on_label(lbl: cell.lbl_title)
//        set_gradient_on_label(lbl: cell.desc_lbl)
        if indexPath.row == arr_WT_title.count-1 {
            cell.btn_start.isHidden = false
//            cell.hight_start_button.constant = 50
        } else {
            cell.btn_start.isHidden = true
//            cell.hight_start_button.constant = 0
        }
        
        cell.btn_start.addTarget(self, action: #selector(btn_start(_:)), for: .touchUpInside)
        
//        MARK:- gradient on button text
//       set_grad_to_btn(btn: cell.btn_start)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let witdh = scrollView.frame.width - (scrollView.contentInset.left*2)
        let index = scrollView.contentOffset.x / witdh
        let roundedIndex = round(index)
        page_controll.currentPage = Int(roundedIndex)
    }

}


