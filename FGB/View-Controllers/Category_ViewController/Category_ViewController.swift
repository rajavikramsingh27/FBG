//  Category_ViewController.swift
//  FGB
//  Created by iOS-Appentus on 12/03/19.
//  Copyright © 2019 appentus. All rights reserved.


import UIKit
import SDWebImage

var is_from_cate = false

class Category_ViewController: UIViewController {
    @IBOutlet weak var btn_women:UIButton!
    @IBOutlet weak var btn_men:UIButton!
    @IBOutlet weak var btn_kids:UIButton!
    @IBOutlet weak var view_over_scroll:UIView!
    @IBOutlet weak var scroll_view:UIScrollView!
    @IBOutlet weak var leading_bottom_line:NSLayoutConstraint!
    @IBOutlet weak var width_container:NSLayoutConstraint!
    @IBOutlet weak var width_first_coll_view:NSLayoutConstraint!
    @IBOutlet weak var width_second_coll_view:NSLayoutConstraint!
    @IBOutlet weak var width_third_coll_view:NSLayoutConstraint!
    
    @IBOutlet weak var coll_Category_Women:UICollectionView!
    @IBOutlet weak var coll_Category_men:UICollectionView!
    @IBOutlet weak var coll_Category_kids:UICollectionView!
    
    @IBOutlet weak var lbl_product_not_found:UILabel!
    
    @IBOutlet weak var lbl_categogry_title:UILabel!
    
    var arr_selected = [Bool]()
    var arr_subcate_count = [String]()
    
    var arr_Subcategory = [Model_Category]()
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
//        scroll_view.panGestureRecognizer.addTarget(self, action: #selector(handlePanGesture))
        Model_Category.shared.arr_category_subcate.removeAll()
        
        Model_Category.shared.collection_code = "women"
        func_category_subcate()
        set_grasd()
        
        set_gradient_on_label(lbl: lbl_categogry_title)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.lbl_product_not_found.isHidden = true
        
        let width = self.view.frame.size.width
        width_container.constant = 3*width
        width_first_coll_view.constant = width
        width_second_coll_view.constant = width
        width_third_coll_view.constant = width
    }
    
    func set_grasd() {
        set_grad_to_btn(btn: btn_women)
        set_grad_to_btn(btn: btn_men)
        set_grad_to_btn(btn: btn_kids)
        set_gradient_on_label(lbl: lbl_product_not_found)
        
        lbl_product_not_found.text = "pronotfound".localized
        lbl_categogry_title.text = "categories".localized
        
        btn_men.setTitle("Men".localized, for: .normal)
        btn_women.setTitle("Women".localized, for: .normal)
        btn_kids.setTitle("Kids".localized, for: .normal)
    }
    
    func func_category_subcate() {
        DispatchQueue.main.async {
            self.coll_Category_Women.reloadData()
            self.coll_Category_men.reloadData()
            self.coll_Category_kids.reloadData()
            self.func_ShowHud()
        }
        Model_Category.shared.func_category_subcate { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                
                self.arr_selected.removeAll()
                if Model_Category.shared.arr_category_subcate.count > 0 {
                    self.lbl_product_not_found.isHidden = true
                    for _ in 0..<Model_Category.shared.arr_category_subcate.count {
                        self.arr_selected.append(false)
                    }
                } else {
                    self.lbl_product_not_found.isHidden = false
                }
                
                self.coll_Category_Women.reloadData()
                self.coll_Category_men.reloadData()
                self.coll_Category_kids.reloadData()
            }
        }
    }
    
    @IBAction func btn_women(_ sender:UIButton) {
        leading_bottom_line.constant = btn_women.frame.origin.x
        UIView.animate(withDuration:0.2, delay: 0, options: .curveLinear, animations: {
            self.scroll_view.contentOffset.x = 0
        }, completion: nil)
        
        Model_Category.shared.arr_category_subcate.removeAll()
        Model_Category.shared.collection_code = "women"
        func_category_subcate()
    }
    
    @IBAction func btn_men(_ sender:UIButton) {
        leading_bottom_line.constant = btn_men.frame.origin.x
        UIView.animate(withDuration:0.2, delay: 0, options: .curveLinear, animations: {
            self.scroll_view.contentOffset.x = self.view.frame.size.width
        }, completion: nil)
        Model_Category.shared.arr_category_subcate.removeAll()
        Model_Category.shared.collection_code = "men"
        func_category_subcate()
    }
    
    @IBAction func btn_kids(_ sender:UIButton) {
        leading_bottom_line.constant = btn_kids.frame.origin.x
        UIView.animate(withDuration:0.2, delay: 0, options: .curveLinear, animations: {
            self.scroll_view.contentOffset.x = self.view.frame.size.width*2
        }, completion: nil)
        Model_Category.shared.arr_category_subcate.removeAll()
        Model_Category.shared.collection_code = "kids"
        func_category_subcate()
    }
    
    @IBAction func btn_search(_ sender:Any) {
        let search_VC = storyboard?.instantiateViewController(withIdentifier: "Search_ViewController") as! Search_ViewController
        present(search_VC, animated: true, completion: nil)
    }

}



//extension Category_ViewController : UITableViewDelegate,UITableViewDataSource {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
////        if arr_selected[indexPath.row] {
////            var subcate_count = 0
////            if ((arr_Subcategory.count)%2) != 0 {
////                subcate_count = (arr_Subcategory.count)/2+1
////            } else {
////                 subcate_count = (arr_Subcategory.count)/2
////            }
////            return CGFloat(60 + subcate_count*80)+30.0
////        } else {
//            return 160
////        }
//
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10 //Model_Category.shared.arr_category_subcate.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Category_TableViewCell
//
////        if arr_selected[indexPath.row] {
//            cell.coll_subcategory.delegate = self
//            cell.coll_subcategory.dataSource = self
//            cell.coll_subcategory.reloadData()
////
////            cell.btn_plus.isSelected = true
////
////            var subcate_count = 0
////            if ((arr_Subcategory.count)%2) != 0 {
////                subcate_count = (arr_Subcategory.count)/2+1
////            } else {
////                subcate_count = (arr_Subcategory.count)/2
////            }
////
////            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
////                tableView.rowHeight = CGFloat(60 + subcate_count*80)+30.0
////                cell.layoutIfNeeded()
////            }, completion: { finished in
////
////            })
////        } else {
////            tableView.rowHeight = 60.0
////            cell.btn_plus.isSelected = false
////        }
////
////        let model = Model_Category.shared.arr_category_subcate[indexPath.row]
////        cell.lbl_cate_name.text = model.category_name
////
////        cell.btn_plus.tag = indexPath.row
////        cell.btn_plus.addTarget(self, action: #selector(btn_plus(_:)), for: .touchUpInside)
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//
////        func_expand_cell_hieght(indexPath: indexPath.row)
//    }
//
//    func func_expand_cell_hieght(indexPath:Int) {
//        let model = Model_Category.shared.arr_category_subcate[indexPath]
//        arr_Subcategory =  model.Subcategory
//
//        arr_subcate_count.removeAll()
//        for _ in 0..<arr_Subcategory.count {
//            arr_subcate_count.append("")
//        }
//
//        for i in 0..<Model_Category.shared.arr_category_subcate.count {
//            if i == indexPath {
//                if arr_selected[indexPath] {
//                    arr_selected[i] = false
//                } else {
//                    arr_selected[i] = true
//                }
//            } else {
//                arr_selected[i] = false
//            }
//        }
//
//        tbl_Category.beginUpdates()
//        tbl_Category.setNeedsLayout()
//        tbl_Category.endUpdates()
//
//        tbl_Category.reloadData()
//    }
//
//}



//  MARK:- UICollectionView methods
extension Category_ViewController:UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height_collection = collectionView.frame.size.width/2-10-5
        return CGSize (width:height_collection, height: height_collection)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Model_Category.shared.arr_category_subcate.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Category_CollectionViewCell
        let model = Model_Category.shared.arr_category_subcate[indexPath.row]
        
        cell.lbl_sub_cate_name.text = model.category_name

        cell.img_sub_cate.sd_showActivityIndicatorView()
        cell.img_sub_cate.sd_setIndicatorStyle(.gray)
        
        let u = model.category_icon
        let img_name = u.components(separatedBy: k_images_url)

        if img_name.count > 1 {
            var img_ = img_name[1]
            if let encoded = img_.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                let u = "\(k_images_url)/\(encoded)"
                let url = URL(string:u)
                cell.img_sub_cate.sd_setImage(with:url!, placeholderImage:img_default_app)
            }
        } else {
            cell.img_sub_cate.sd_setImage(with:URL (string: u), placeholderImage:img_default_app)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        Model_Category.shared.Subcategory = Model_Category.shared.arr_category_subcate[indexPath.row].Subcategory
        Model_Category.shared.category_code = Model_Category.shared.arr_category_subcate[indexPath.row].category_code
        Model_Category.shared.category_name = Model_Category.shared.arr_category_subcate[indexPath.row].category_name
        Model_Category.shared.category_icon = Model_Category.shared.arr_category_subcate[indexPath.row].category_icon
        
//        let model = arr_Subcategory[indexPath.row]
//        Model_Category.shared.subcategory_code = model.subcategory_code
//        Model_Item_Details.shared.arr_Subcategory = arr_Subcategory
        
        let search_VC = storyboard?.instantiateViewController(withIdentifier: "Shop_Subcateory_ViewController") as! Shop_Subcateory_ViewController
        present(search_VC, animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let witdh = scrollView.frame.width - (scrollView.contentInset.left*2)
//        let index = scrollView.contentOffset.x / witdh
//        let roundedIndex = round(index)
//        if Int(roundedIndex) == 0 {
//            leading_bottom_line.constant = btn_women.frame.origin.x
//            Model_Category.shared.collection_code = "women"
//        } else if Int(roundedIndex) == 1 {
//            leading_bottom_line.constant = btn_men.frame.origin.x
//            Model_Category.shared.collection_code = "men"
//        } else if Int(roundedIndex) == 2 {
//            leading_bottom_line.constant = btn_kids.frame.origin.x
//            Model_Category.shared.collection_code = "kids"
//        }
//
//        UIView.animate(withDuration: 0.2) {
//            self.view.layoutIfNeeded()
//        }
//
//        Model_Category.shared.arr_category_subcate.removeAll()
//        func_category_subcate()
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let witdh = scrollView.frame.width - (scrollView.contentInset.left*2)
        let index = scrollView.contentOffset.x / witdh
        let roundedIndex = round(index)
        if Int(roundedIndex) == 0 {
            leading_bottom_line.constant = btn_women.frame.origin.x
            Model_Category.shared.collection_code = "women"
        } else if Int(roundedIndex) == 1 {
            leading_bottom_line.constant = btn_men.frame.origin.x
            Model_Category.shared.collection_code = "men"
        } else if Int(roundedIndex) == 2 {
            leading_bottom_line.constant = btn_kids.frame.origin.x
            Model_Category.shared.collection_code = "kids"
        }
        
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
        
        Model_Category.shared.arr_category_subcate.removeAll()
        func_category_subcate()

    }
    
}









