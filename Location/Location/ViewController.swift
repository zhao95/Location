//
//  ViewController.swift
//  Location
//
//  Created by 赵恩峰 on 16/8/22.
//  Copyright © 2016年 赵恩峰. All rights reserved.
//
/* =====================================================================*/

// MARK:记得在info.plist文件中添加 NSLocationWhenInUseUsageDescription文件
// 并设置 提示名称   这样才能弹出提示对话框   显示地位信息


// 欢迎来到我的仓库留言 -> https://github.com/zhao95/Location
// 同时欢迎提交建议.共同改善小项目. 发扬开源精神~

/* =====================================================================*/


import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    private lazy var mangaer : CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // iOS8+定位必须请求获取用户的授权
        mangaer.requestWhenInUseAuthorization()
        
        // 开始定位
        mangaer.startUpdatingLocation()
        
        // 设置代理
        mangaer.delegate = self
        
        
        // mangaer其他属性的补充
        // 1.设置定位的精确度
        /*
         kCLLocationAccuracyBestForNavigation: 导航精确度(最精确)
         kCLLocationAccuracyBest: 最好精确度(默认)
         kCLLocationAccuracyNearestTenMeters: 10米的误差
         kCLLocationAccuracyHundredMeters: 100米的误差
         kCLLocationAccuracyKilometer: 千米误差
         kCLLocationAccuracyThreeKilometers: 三千米的误差
         */
        // 精确度越高, 越耗电
        mangaer.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        
        // 2.设置用于移动多少距离,重新进行定位
        mangaer.distanceFilter = 100
    }
}

extension ViewController : CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("定位到用户的位置")
        
        // 1.校验用户是否有位置
        guard let lastLocation = locations.last else  {
            return
        }
        
        // 2.获取具体的信息
        // 2.1.获取用户的经纬度(重要)
        let coordinate = lastLocation.coordinate
        print("纬度:\(coordinate.latitude) 经度:\(coordinate.longitude)")
        
        // 2.2.获取用户所在的海拔
        let altitude = lastLocation.altitude
        print("海拔:\(altitude)")
        
        // 2.3.水平精确度(位置误差)和垂直精确度(海拔误差)
        let hAccuracy = lastLocation.horizontalAccuracy
        let vAccuracy = lastLocation.verticalAccuracy
        print("水平精确度:\(hAccuracy) 垂直精确度:\(vAccuracy)")
        
        // 2.4.当前的运动方向(如果是负数,表示不可用)
        let course = lastLocation.course
        print("运动方向:\(course)")
        
        // 2.5.获取当前的速度
        let speed = lastLocation.speed
        print("速度:\(speed)")
    }
}
