//
//  ApartmentBasicViewController.swift
//  loca
//
//  Created by Toan Nguyen on 6/1/19.
//  Copyright © 2019 LocaLoca. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ApartmentBasicViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, IndicatorInfoProvider {

    @IBOutlet weak var tableView: UITableView!
    
    var dataList = [(image:UIImage,description:String)]()
    
    var photosLink = [String]()
    var utilities = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        dataList.append((UIImage(named: "location_icon")!,"Dia chi : 46 duong so 5, Phuong Thao Dien Quan 2"))
        dataList.append((UIImage(named: "home_icon")!,"Dự án : Phú Gia"))
        dataList.append((UIImage(named: "direction_icon")!,"Hướng : Nam"))
        dataList.append((UIImage(named: "floor_icon")!,"Số Tầng : 2"))
        dataList.append((UIImage(named: "bedroom_icon")!,"Số Phòng Ngủ : 2"))
        dataList.append((UIImage(named: "bathroom_icon")!,"Số Phòng Tắm : 2"))
        dataList.append((UIImage(named: "terrace_icon")!,"Sân Thượng : có"))
        dataList.append((UIImage(named: "garden_icon")!,"vườn: không"))
        dataList.append((UIImage(named: "pool_icon")!,"Hồ Bơi : không"))
        dataList.append((UIImage(named: "estate_icon")!,"Loại Bất Động Sản : Căn hộ"))
        
        photosLink.append("https://images.unsplash.com/photo-1480074568708-e7b720bb3f09?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1353&q=80")
        photosLink.append("https://images.unsplash.com/photo-1523217582562-09d0def993a6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=80")
        
        photosLink.append("https://images.unsplash.com/photo-1493809842364-78817add7ffb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80")
        
        utilities.append("Hồ Bơi")
        utilities.append("Sauna")
        utilities.append("Phòng Gym")
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
       let itemInfo: IndicatorInfo = "Cơ Bản"
        return itemInfo
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return dataList.count
        case 2:
            return utilities.count
        case 3 :
            return photosLink.count
        default:
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "apartmentbasic") as! ApartmentBasicTableViewCell
            cell.setData(image: dataList[indexPath.row].image, description: dataList[indexPath.row].description)
        
            return cell
            
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "apartment_description") as! ApartmentDescriptionTableViewCell
            cell.setData(description: "Sunshine City Sài Gòn - Siêu phẩm căn hộ hạng sang chất lượng 5 sao Sunshine City Quận 7 áp dụng Công Nghệ 4.0 (Thang máy nhận diện khuôn mặt, máy nước nóng điều khiển từ xa khi chưa về nhà, bãi đỗ xe thông minh tự tiềm kiếm vị trí trống) & nội thất dát vàng + tòa nhà được bao phủ toàn bộ kính Low E 3 lớp chống tia cực tím. \n Thông tin tổng quan về dự án: \n Vị trí: Ngã 4 đường Phú Thuận giao với Huỳnh Tấn Phát, liền kề khu đô thị Phú Mỹ Hưng, Quận 7, TP.HCM.")
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "apartment_utilities")
            cell?.textLabel?.text = utilities[indexPath.row]
            return cell!
        } else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "apartment_photos") as! ApartmentPhotosTableViewCell
            
            let url = URL(string: photosLink[indexPath.row])
            let data = try? Data(contentsOf: url!)
            
            if let imageData = data {
                let image = UIImage(data: imageData)
                cell.setData(image: image!)
            }
            
            return cell
            
            
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 1:
            return 200
        case 3:
            return 300
        default:
            return 50
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let parentView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        
        let view = UILabel(frame: CGRect(x: 16, y: 0, width: tableView.frame.width, height: 40))
        
        switch section {
        case 0 :
            view.text = "Thông Tin Cơ Bản"
        case 1 :
            view.text = "Nội Dung Mô Tả"
        case 2 :
             view.text = "Tiện Ích"
        case 3 :
            view.text = "Hình Ảnh"
        default:
            view.text = ""
        }
        
       
       
        
        parentView.addSubview(view)
        return parentView
    }
    
    
}
