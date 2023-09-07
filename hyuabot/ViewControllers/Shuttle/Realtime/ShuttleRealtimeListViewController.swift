import UIKit
import RxSwift
import QueryAPI


class ShuttleRealtimeListViewController: UIViewController {    
    let tableView: UITableView = UITableView()
    let disposeBag = DisposeBag()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let refreshControl = UIRefreshControl()
    private var stopID: ShuttleStop = ShuttleStop.dormitoryOut
    private var stopKey: String = ""
    private var categoryList: [String] = []
    private var section1List: [ShuttleArrivalItem] = []
    private var section2List: [ShuttleArrivalItem] = []
    private var section3List: [ShuttleArrivalItem] = []
    
    init(stopID: ShuttleStop) {
        super.init(nibName: nil, bundle: nil)
        self.stopID = stopID
        switch stopID {
        case .dormitoryOut:
            categoryList = [
                String.localizedShuttleItem(resourceID: "shuttle_destination_subway"),
                String.localizedShuttleItem(resourceID: "shuttle_destination_terminal"),
                String.localizedShuttleItem(resourceID: "shuttle_destination_jungang_station"),
            ]
            stopKey = "dormitory_o"
        case .shuttlecockOut:
            categoryList = [
                String.localizedShuttleItem(resourceID: "shuttle_destination_subway"),
                String.localizedShuttleItem(resourceID: "shuttle_destination_terminal"),
                String.localizedShuttleItem(resourceID: "shuttle_destination_jungang_station"),
            ]
            stopKey = "shuttlecock_o"
        case .station:
            categoryList = [
                String.localizedShuttleItem(resourceID: "shuttle_destination_campus"),
                String.localizedShuttleItem(resourceID: "shuttle_destination_terminal"),
                String.localizedShuttleItem(resourceID: "shuttle_destination_jungang_station"),
            ]
            stopKey = "station"
        case .terminal:
            categoryList = [
                String.localizedShuttleItem(resourceID: "shuttle_destination_campus"),
            ]
            stopKey = "terminal"
        case .jungangStation:
            categoryList = [
                String.localizedShuttleItem(resourceID: "shuttle_destination_campus"),
            ]
            stopKey = "jungang_stn"
        case .shuttlecockIn:
            categoryList = [
                String.localizedShuttleItem(resourceID: "shuttle_destination_dormitory"),
            ]
            stopKey = "shuttlecock_i"
        }
            
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureView()
        subscribeData()
    }
    
    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        tableView.refreshControl?.addTarget(self, action: #selector(refreshTableView(_:)), for: .valueChanged)
        tableView.register(ShuttleRealtimeHeaderView.self, forHeaderFooterViewReuseIdentifier: ShuttleRealtimeHeaderView.identifier)
        tableView.register(ShuttleRealtimeFooterView.self, forHeaderFooterViewReuseIdentifier: ShuttleRealtimeFooterView.identifier)
        tableView.register(ShuttleEmptyListItemView.self, forCellReuseIdentifier: ShuttleEmptyListItemView.identifier)
        tableView.register(ShuttleRealtimeListItemView.self, forCellReuseIdentifier: ShuttleRealtimeListItemView.identifier)
    }
    
    func configureView() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.sectionHeaderTopPadding = 0
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])

    }
    
    func subscribeData() {
        appDelegate.shuttleRealtimeQuery.subscribe(onNext: { data in
            let filteredData = data.first { $0.stopName == self.stopKey } ?? nil
            guard let filteredData = filteredData else { return }
            
            var section1: [ShuttleArrivalItem] = []
            var section2: [ShuttleArrivalItem] = []
            var section3: [ShuttleArrivalItem] = []
            
            
            switch self.stopID {
            case .dormitoryOut:
                filteredData.tag.filter { $0.tagID == "DH" || $0.tagID == "DJ" || $0.tagID == "C" }.forEach({ tagItem in
                    tagItem.timetable.forEach({ timetableItem in
                        section1.append(ShuttleArrivalItem(tag: tagItem.tagID, timetable: timetableItem))
                    })
                })
                filteredData.tag.filter { $0.tagID == "DY" || $0.tagID == "C" }.forEach({ tagItem in
                    tagItem.timetable.forEach({ timetableItem in
                        section2.append(ShuttleArrivalItem(tag: tagItem.tagID, timetable: timetableItem))
                    })
                })
                filteredData.tag.filter { $0.tagID == "DJ" }.forEach({  tagItem in
                    tagItem.timetable.forEach({ timetableItem in
                        section3.append(ShuttleArrivalItem(tag: tagItem.tagID, timetable: timetableItem))
                    })
                })
            case .shuttlecockOut:
                filteredData.tag.filter { $0.tagID == "DH" || $0.tagID == "DJ" || $0.tagID == "C" }.forEach({ tagItem in
                    tagItem.timetable.forEach({ timetableItem in
                        section1.append(ShuttleArrivalItem(tag: tagItem.tagID, timetable: timetableItem))
                    })
                })
                filteredData.tag.filter { $0.tagID == "DY" || $0.tagID == "C" }.forEach({ tagItem in
                    tagItem.timetable.forEach({ timetableItem in
                        section2.append(ShuttleArrivalItem(tag: tagItem.tagID, timetable: timetableItem))
                    })
                })
                filteredData.tag.filter { $0.tagID == "DJ" }.forEach({  tagItem in
                    tagItem.timetable.forEach({ timetableItem in
                        section3.append(ShuttleArrivalItem(tag: tagItem.tagID, timetable: timetableItem))
                    })
                })
            case .station:
                filteredData.tag.forEach({ tagItem in
                    tagItem.timetable.forEach({ timetableItem in
                        section1.append(ShuttleArrivalItem(tag: tagItem.tagID, timetable: timetableItem))
                    })
                })
                filteredData.tag.filter { $0.tagID == "C" }.forEach({ tagItem in
                    tagItem.timetable.forEach({ timetableItem in
                        section2.append(ShuttleArrivalItem(tag: tagItem.tagID, timetable: timetableItem))
                    })
                })
                filteredData.tag.filter { $0.tagID == "DJ" }.forEach({  tagItem in
                    tagItem.timetable.forEach({ timetableItem in
                        section3.append(ShuttleArrivalItem(tag: tagItem.tagID, timetable: timetableItem))
                    })
                })
            case .terminal:
                filteredData.tag.forEach({ tagItem in
                    tagItem.timetable.forEach({ timetableItem in
                        section1.append(ShuttleArrivalItem(tag: tagItem.tagID, timetable: timetableItem))
                    })
                })
            case .jungangStation:
                filteredData.tag.forEach({ tagItem in
                    tagItem.timetable.forEach({ timetableItem in
                        section1.append(ShuttleArrivalItem(tag: tagItem.tagID, timetable: timetableItem))
                    })
                })
            case .shuttlecockIn:
                filteredData.tag.forEach({ tagItem in
                    tagItem.timetable.forEach({ timetableItem in
                        section1.append(ShuttleArrivalItem(tag: tagItem.tagID, timetable: timetableItem))
                    })
                })
            }
            self.section1List = section1.sorted(by: { $0.timetable.time < $1.timetable.time })
            self.section2List = section2.sorted(by: { $0.timetable.time < $1.timetable.time })
            self.section3List = section3.sorted(by: { $0.timetable.time < $1.timetable.time })
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }).disposed(by: disposeBag)
    }
    
    @objc func refreshTableView(_ sender: Any)  {
        appDelegate.queryShuttleRealtimePage()
    }
}

extension ShuttleRealtimeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            self.tableView.performBatchUpdates(nil)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = self.tableView.cellForRow(at: indexPath) as? ShuttleRealtimeListItemView {
            cell.hideDetailView()
        }
    }
    
    // Section header configuration
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ShuttleRealtimeHeaderView.identifier) as? ShuttleRealtimeHeaderView else {
             return UIView()
         }
         headerView.setUpHeaderView(label: categoryList[section])
         return headerView
     }
    
    // Section footer configuration
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ShuttleRealtimeFooterView.identifier) as? ShuttleRealtimeFooterView else {
            return UIView()
        }
        footerView.setUpFooterView(stopID: self.stopKey, destination: self.categoryList[section])
        return footerView
    }
}

extension ShuttleRealtimeListViewController: UITableViewDataSource {
    // Number of rows per section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var maxCount = 3
        if categoryList.count <= 1 {
            maxCount = 12
        }
        if section == 0 {
            return max(min(section1List.count, maxCount), 1)
        } else if section == 1 {
            return max(min(section2List.count, maxCount), 1)
        } else {
            return max(min(section3List.count, maxCount), 1)
        }
    }
    
    // Cell configuration
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataCell = tableView.dequeueReusableCell(withIdentifier: "ShuttleRealtimeListItemView", for: indexPath) as! ShuttleRealtimeListItemView
        let emptyCell = tableView.dequeueReusableCell(withIdentifier: "ShuttleEmptyListItemView", for: indexPath) as! ShuttleEmptyListItemView
        if indexPath.section == 0 && !section1List.isEmpty {
            dataCell.setUpCell(stopType: self.stopID, item: section1List[indexPath.row])
            return dataCell
        } else if indexPath.section == 1 && !section2List.isEmpty {
            dataCell.setUpCell(stopType: self.stopID, item: section2List[indexPath.row])
            return dataCell
        } else if indexPath.section == 2 && !section3List.isEmpty {
            dataCell.setUpCell(stopType: self.stopID, item: section3List[indexPath.row])
            return dataCell
        }        
        return emptyCell
    }
    
    // Section header height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return categoryList.count
    }
}
