//  Item-Details_ViewController.swift
//  FGB
//  Created by iOS-Appentus on 08/03/19.
//  Copyright © 2019 appentus. All rights reserved.



import UIKit
import SDWebImage

var is_details_item = false

class Item_Details_ViewController: UIViewController {
    @IBOutlet weak var coll_cate:UICollectionView!
    @IBOutlet weak var coll_product_details:UICollectionView!
    
    @IBOutlet weak var hight_cate_coll:NSLayoutConstraint!
    @IBOutlet weak var lbl_title:UILabel!
    
    var arr_selected_cate = [Bool]()
    
    var is_filter = false
    
    var page = 1
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbl_title.text = Model_Category.shared.subcategory_name
        set_gradient_on_label(lbl: lbl_title)
        for _ in 0..<Model_Item_Details.shared.arr_Subcategory.count {
            arr_selected_cate.append(false)
        }
        
        func_clear_filter()
        
        NotificationCenter.default.addObserver(self, selector: #selector(func_clear_filter), name: NSNotification.Name (rawValue: "clear_filter"), object: nil)
    }
    
    @objc func func_clear_filter() {
        Model_Item_Details.shared.page = "1"
        Model_Item_Details.shared.arr_get_products.removeAll()
        func_get_products()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        coll_product_details.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    @IBAction func btn_filter(_ sender:Any) {
        let filter_VC = storyboard?.instantiateViewController(withIdentifier: "Filter_ViewController") as! Filter_ViewController
        present(filter_VC, animated: true, completion: nil)
    }
    
    @IBAction func btn_back(_ sender:Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func func_get_products() {
        func_ShowHud()
        Model_Item_Details.shared.func_get_products { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                
                if status == "success" {
                    
                } else {
                    
                }
                
                if Model_Item_Details.shared.arr_get_products.count == 0 {
                    self.coll_product_details.isHidden = true
                } else {
                    self.coll_product_details.isHidden = false
                }
                self.coll_product_details.reloadData()
            }
        }
    }
    
    
}



//  MARK:- UICollectionView methods
extension Item_Details_ViewController:UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == coll_cate {
            return CGSize (width: 80, height: 40)
        } else {
            return CGSize (width: collectionView.frame.size.width/2-10, height: 350)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == coll_cate {
            return Model_Item_Details.shared.arr_Subcategory.count
        } else {
            return Model_Item_Details.shared.arr_get_products.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == coll_cate {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Item_Details_Cate_CollectionViewCell
            
            let model = Model_Item_Details.shared.arr_Subcategory[indexPath.row]
            cell.bnt_cate.setTitle(model.subcategory_name, for: .normal)
            
            if arr_selected_cate[indexPath.row] {
                cell.bnt_cate.backgroundColor = color_gold
                cell.bnt_cate.setTitleColor(UIColor.white, for: .normal)
            } else {
                cell.bnt_cate.backgroundColor = UIColor .white
                cell.bnt_cate.setTitleColor(UIColor.black, for: .normal)
            }
            
            cell.bnt_cate.tag = indexPath.row
            cell.bnt_cate.addTarget(self, action: #selector(btn_cate(_:)), for: .touchUpInside)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell-1", for: indexPath) as! Item_Details_CollectionViewCell
            
            let model = Model_Item_Details.shared.arr_get_products[indexPath.row]
            
            cell.img_spacks.sd_setShowActivityIndicatorView(true)
            cell.img_spacks.sd_setIndicatorStyle(.gray)
                
            let u = model.image_path
            let img_name = u.components(separatedBy: k_images_url)
            var img_ = ""
            if img_name.count > 1 {
                img_ = img_name[1]
                if let encoded = img_.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                    let u = "\(k_images_url)/\(encoded)"
                    let url = URL(string:u)
                    cell.img_spacks.sd_setImage(with:url!, placeholderImage:img_default_app)
                }

            } else {
                cell.img_spacks.sd_setImage(with:URL (string:u), placeholderImage:img_default_app)
            }
            cell.lbl_desc.text = model.product_description
            cell.lbl_product_name.text = model.product_name
            
            let full_price = Double(model.currency_price)!*Double(model.product_price)!
//            cell.lbl_price.text = "\(String(format: "%.2f", full_price)) \(currency_symbol)"
            cell.lbl_price.text = "\(arabic_digits("\(full_price)")) \(currency_symbol)"
            
            var diff_days = 0
            if !model.product_adate.isEmpty {
                let product_a_date = "\(model.product_adate) 00:00:00"
                let date_format = DateFormatter()
                date_format.dateFormat = "dd-MM-yyyy HH:mm:ss"
                let product_add_date = date_format.date(from: product_a_date)
//                print(product_add_date)
                let diffInDays = Calendar.current.dateComponents([.day], from: product_add_date ?? Date(), to: Date())
                print(diffInDays)
                diff_days = Int("\(diff_days)")!
            }
            cell.img_is_sale_new_offer.isHidden = true
//            if model.product_issale == "1" {
//                cell.img_is_sale_new_offer.image = UIImage (named: "sale-gold.png")
//            } else if diff_days < 7 {
//                cell.img_is_sale_new_offer.image = UIImage (named: "new-gold.png")
//            }
            
            set_gradient_on_label(lbl: cell.lbl_desc)
            set_gradient_on_label(lbl: cell.lbl_price)
            set_gradient_on_label(lbl: cell.lbl_product_name)

            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == coll_product_details {
            let model = Model_Item_Details.shared.arr_get_products[indexPath.row]
            
            Model_Products.shared.product_id = model.product_id
            Model_Products.shared.category_code = model.category_code
            
            is_from_cate = true

            let shop_details_vc = storyboard?.instantiateViewController(withIdentifier: "Product_Details_ViewController") as! Product_Details_ViewController
            present(shop_details_vc, animated: true, completion: nil)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("scrollViewDidEndDragging")
        if ((coll_product_details.contentOffset.y + coll_product_details.frame.size.height) >= scrollView.contentSize.height) {
            page = page+1
            Model_Item_Details.shared.page = "\(page)"
            func_get_products()
        }
    }
    
    @IBAction func btn_cate(_ sender:UIButton) {
        for i in 0..<Model_Item_Details.shared.arr_Subcategory.count {
            if i == sender.tag {
                if arr_selected_cate[i] {
                    arr_selected_cate[i] = false
                } else {
                    arr_selected_cate[i] = true
                }
            } else {
                arr_selected_cate[i] = false
            }
        }
        
        Model_Category.shared.subcategory_code = Model_Item_Details.shared.arr_Subcategory[sender.tag].subcategory_code
        coll_cate.reloadData()
        func_get_products()
    }
    
    
    
}








