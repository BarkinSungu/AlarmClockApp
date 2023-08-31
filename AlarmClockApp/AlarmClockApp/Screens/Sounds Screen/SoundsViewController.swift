//
//  SoundsViewController.swift
//  AlarmClockApp
//
//  Created by Barkın Süngü on 30.08.2023.
//
import UIKit
import MediaPlayer

class SoundsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableViewList: [String] = []
    
    var soundFiles: [String] = ["natural", "energy", "alarm_sound"]
    var songs: [String] = []
    var playlists: [String] = []
    
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
        table.backgroundColor = .white
        table.tintColor = .white
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Sounds"
        
        tableViewList = soundFiles
        
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
            tableViewList = soundFiles
            print(soundFiles)
            tableView.reloadData()
            break
        case 1:
            requestMediaLibraryAccess()
            loadPlaylists()
            tableViewList = playlists
            print(playlists)
            tableView.reloadData()
            break
        case 2:
            requestMediaLibraryAccess()
            loadMediaItems()
            tableViewList = songs
            print(songs)
            tableView.reloadData()
            break
        default:
            break
        }
    }
    
    func requestMediaLibraryAccess() {
        MPMediaLibrary.requestAuthorization { status in
            if status == .authorized {
                self.loadMediaItems()
            } else {
                print("Media library access denied.")
            }
        }
    }
        
    func loadMediaItems() {
        songs.removeAll()
        let mediaQuery = MPMediaQuery.songs()
        if let songItems = mediaQuery.items {
            for i in songItems{
                songs.append(i.title ?? "")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    func loadPlaylists() {
        playlists.removeAll()
        let playlistQuery = MPMediaQuery.playlists()
        if let playlistItems = playlistQuery.collections as? [MPMediaPlaylist] {
            for i in playlistItems{
                playlists.append(i.name ?? "")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func soundSelected(_ soundName: String) {
        NotificationCenter.default.post(name: Notification.Name("SoundSelected"), object: soundName)
        navigationController?.popViewController(animated: true)
    }

        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .white
        cell.textLabel?.textColor = .black
        cell.textLabel?.text = tableViewList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedSoundFileName = tableViewList[indexPath.row]
        soundSelected(selectedSoundFileName)
        
        print("Selected sound file: \(selectedSoundFileName)")
        
    }
}

