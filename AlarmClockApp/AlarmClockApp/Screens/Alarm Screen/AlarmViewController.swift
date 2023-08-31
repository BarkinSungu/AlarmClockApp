//
//  Alarm View Controller.swift
//  AlarmClockApp
//
//  Created by Barkın Süngü on 30.08.2023.
//

import UIKit

class AlarmViewController: UIViewController {
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        return picker
    }()
        
    let setAlarmButton: UIButton = {
        let button = UIButton()
        button.setTitle("Set Alarm", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(setAlarm), for: .touchUpInside)
        return button
    }()
    
    let soundLabel: UILabel = {
        let label = UILabel()
        label.text = "Alarm Sound: Default"
        label.textColor = .black
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Alarm"
        
        view.addSubview(datePicker)
        view.addSubview(setAlarmButton)
        view.addSubview(soundLabel)
                
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        setAlarmButton.translatesAutoresizingMaskIntoConstraints = false
        soundLabel.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            datePicker.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            setAlarmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            setAlarmButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 50),
            setAlarmButton.widthAnchor.constraint(equalToConstant: 150),
            setAlarmButton.heightAnchor.constraint(equalToConstant: 50),
            
            soundLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            soundLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            soundLabel.topAnchor.constraint(equalTo: setAlarmButton.bottomAnchor, constant: 100)
        ])
    }
    
    @objc func setAlarm(){
        
    }
 
}
