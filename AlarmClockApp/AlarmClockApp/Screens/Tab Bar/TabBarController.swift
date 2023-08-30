//
//  TabBarController.swift
//  AlarmClockApp
//
//  Created by Barkın Süngü on 30.08.2023.
//
import UIKit


class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let alarmVC = AlarmViewController()
        let soundVC = SoundsViewController()
        
        alarmVC.tabBarItem = UITabBarItem(title: "Alarm", image: UIImage(systemName: "bell.fill"), tag: 0)
        soundVC.tabBarItem = UITabBarItem(title: "Sound", image: UIImage(systemName: "speaker.wave.1.fill"), tag: 1)
        
        let alarmNavigationController = UINavigationController(rootViewController: alarmVC)
        let soundNavigationController = UINavigationController(rootViewController: soundVC)
        
        viewControllers = [alarmNavigationController, soundNavigationController]
    }
}
