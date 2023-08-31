//
//  Alarm View Controller.swift
//  AlarmClockApp
//
//  Created by Barkın Süngü on 30.08.2023.
//

import UIKit

class AlarmViewController: UIViewController {
    
    var alarmSoundName: String = "alarm_sound"
    
    //UI elements
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
        label.text = "Alarm Sound: alarm_sound"
        label.textColor = .black
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Alarm"
        
        NotificationCenter.default.addObserver(self, selector: #selector(didSelectSound(_:)), name: Notification.Name("SoundSelected"), object: nil)
        
        setUI()
    }
    
    func setUI(){
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
    
    func scheduleNotification(at date: Date) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if granted {
                let content = UNMutableNotificationContent()
                content.title = "Wake up!"
                content.body = "Time to wake up!"
                content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "\(self.alarmSoundName).wav"))
                
                let triggerDate = Calendar.current.dateComponents([.hour, .minute], from: date)
                let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
                
                let request = UNNotificationRequest(identifier: "alarm", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request) { (error) in
                    if let error = error {
                        print("Error scheduling notification: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    @objc func setAlarm() {
        var alarmTime = datePicker.date
        alarmTime = adjustSelectedDateIfNeeded(selectedDate: alarmTime)
        scheduleNotification(at: alarmTime)
        print("alarm time set for: \(alarmTime) with \(alarmSoundName)")

        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: alarmTime)
        let minute = calendar.component(.minute, from: alarmTime)
        self.showAlert(message: "Alarm set for \(hour):\(minute).")
    }
    
    //If selected date is earlier now set alarm for tomorrow
    func adjustSelectedDateIfNeeded(selectedDate: Date) -> Date {
        let calendar = Calendar.current
        let currentDate = Date()

        if selectedDate <= currentDate {
            let adjustedDate = calendar.date(byAdding: .day, value: 1, to: selectedDate)!
            return adjustedDate
        }
        return selectedDate
    }
    
    func setNotificationSound(soundName:String){
        soundLabel.text = "Alarm Sound: \(soundName)"
        alarmSoundName = soundName
        print("sound changed with: \(soundName)")
    }
    
    //The function that receives data from the selected row in SoundsViewController to set it as an alarm sound.
    @objc func didSelectSound(_ notification: Notification) {
            if let soundName = notification.object as? String {
                setNotificationSound(soundName: soundName)
            }
        }

    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Info", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
 
}
