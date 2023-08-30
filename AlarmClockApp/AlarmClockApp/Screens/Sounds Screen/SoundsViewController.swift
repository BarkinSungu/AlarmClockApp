//
//  SoundsViewController.swift
//  AlarmClockApp
//
//  Created by Barkın Süngü on 30.08.2023.
//
import UIKit

class SoundsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var soundFiles: [String] = ["natural", "energy", "alarm_sound"]
    
    let segmentedControl: UISegmentedControl = {
        let items = ["Sounds", "Playlists", "Songs"]
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(segmentedControlChanged(_:)), for: .valueChanged)
        return control
    }()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Sounds"
        
        setUI()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func setUI(){
        view.addSubview(segmentedControl)
        view.addSubview(tableView)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func segmentedControlChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            // Sounds seçildiğinde yapılacak işlemler
            tableView.reloadData()
            break
        case 1:
            // Playlists seçildiğinde yapılacak işlemler
            tableView.reloadData()
            break
        case 2:
            // Songs seçildiğinde yapılacak işlemler
            tableView.reloadData()
            break
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return soundFiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = soundFiles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedSoundFileName = soundFiles[indexPath.row]
        
        print("Selected sound file: \(selectedSoundFileName)")
        
    }
}

