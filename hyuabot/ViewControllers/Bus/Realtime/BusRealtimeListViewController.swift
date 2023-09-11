import UIKit
import RxSwift
import Then
import QueryAPI

class BusRealtimeListViewController: UIViewController {
    private let tableView: UITableView = UITableView()
    private let disposeBag = DisposeBag()
    private var busType: BusType = .local
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let refreshControl = UIRefreshControl()
    private var sectionList: [String] = []
    private var section1List: [BusArrivalItem] = []
    private var section2List: [BusArrivalItem] = []
    private var section3List: [BusArrivalItem] = []
    
    init(busType: BusType) {
        super.init(nibName: nil, bundle: nil)
        self.busType = busType
        switch self.busType {
        case .local:
            self.sectionList = ["bus.route.10-1.sangnoksu", "bus.route.10-1.purgio"]
        case .seoul:
            self.sectionList = ["bus.route.3102", "bus.route.3100", "bus.route.3101"]
        case .suwon:
            self.sectionList = ["bus.route.707-1", "bus.route.suwon"]
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupView()
        self.subscribeData()
    }
    
    private func setupTableView(){
        self.tableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.refreshControl = self.refreshControl
            $0.refreshControl?.addTarget(self, action: #selector(refreshTableView(_:)), for: .valueChanged)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.sectionHeaderTopPadding = 0
            $0.register(BusRealtimeHeaderView.self, forHeaderFooterViewReuseIdentifier: BusRealtimeHeaderView.identifier)
            $0.register(BusRealtimeFooterView.self, forHeaderFooterViewReuseIdentifier: BusRealtimeFooterView.identifier)
            $0.register(BusRealtimeListItemView.self, forCellReuseIdentifier: BusRealtimeListItemView.identifier)
            $0.register(BusEmptyListItemView.self, forCellReuseIdentifier: BusEmptyListItemView.identifier)
        }
    }
    
    private func setupView() {
        self.view.do {
            $0.addSubview(tableView)
        }
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    private func subscribeData() {
        appDelegate.busRealtimeQuery.subscribe(onNext: { busRealtime in
            var section1List: [BusArrivalItem] = []
            var section1RealtimeList: [BusRealtimeArrivalItem] = []
            var section1TimetableList: [BusTimetableArrivalItem] = []
            var section2List: [BusArrivalItem] = []
            var section2RealtimeList: [BusRealtimeArrivalItem] = []
            var section2TimetableList: [BusTimetableArrivalItem] = []
            var section3List: [BusArrivalItem] = []
            var section3RealtimeList: [BusRealtimeArrivalItem] = []
            var section3TimetableList: [BusTimetableArrivalItem] = []
            
            if self.busType == .local {
                busRealtime.filter({ $0.routeID == 216000068 && $0.stopID == 216000138 }).forEach { bus in
                    bus.realtime.forEach { realtime in
                        section1RealtimeList.append(BusRealtimeArrivalItem(routeName: bus.routeName, realtime: realtime))
                    }
                    bus.timetable.forEach { timetable in
                        if timetable.time.starts(with: "00:") {
                            section1TimetableList.append(BusTimetableArrivalItem(time: "24" + timetable.time.dropFirst(2)))
                        } else {
                            section1TimetableList.append(BusTimetableArrivalItem(time: timetable.time))
                        }
                    }
                }
                busRealtime.filter({ $0.routeID == 216000068 && $0.stopID == 216000379 }).forEach { bus in
                    bus.realtime.forEach { realtime in
                        section2RealtimeList.append(BusRealtimeArrivalItem(routeName: bus.routeName, realtime: realtime))
                    }
                    bus.timetable.forEach { timetable in
                        if timetable.time.starts(with: "00:") {
                            section2TimetableList.append(BusTimetableArrivalItem(time: "24" + timetable.time.dropFirst(2)))
                        } else {
                            section2TimetableList.append(BusTimetableArrivalItem(time: timetable.time))
                        }
                    }
                }
            } else if self.busType == .seoul {
                busRealtime.filter({ $0.routeID == 216000061 && $0.stopID == 216000379 }).forEach { bus in
                    bus.realtime.forEach { realtime in
                        section1RealtimeList.append(BusRealtimeArrivalItem(routeName: bus.routeName, realtime: realtime))
                    }
                    bus.timetable.forEach { timetable in
                        if timetable.time.starts(with: "00:") {
                            section1TimetableList.append(BusTimetableArrivalItem(time: "24" + timetable.time.dropFirst(2)))
                        } else {
                            section1TimetableList.append(BusTimetableArrivalItem(time: timetable.time))
                        }
                    }
                }
                busRealtime.filter({ ($0.routeID == 216000026 || $0.routeID == 216000096 ) && $0.stopID == 216000719 }).forEach { bus in
                    bus.realtime.forEach { realtime in
                        section2RealtimeList.append(BusRealtimeArrivalItem(routeName: bus.routeName, realtime: realtime))
                    }
                    bus.timetable.forEach { timetable in
                        if timetable.time.starts(with: "00:") {
                            section2TimetableList.append(BusTimetableArrivalItem(time: "24" + timetable.time.dropFirst(2)))
                        } else {
                            section2TimetableList.append(BusTimetableArrivalItem(time: timetable.time))
                        }
                    }
                }
                busRealtime.filter({ $0.routeID == 216000043 && $0.stopID == 216000719 }).forEach { bus in
                    bus.realtime.forEach { realtime in
                        section3RealtimeList.append(BusRealtimeArrivalItem(routeName: bus.routeName, realtime: realtime))
                    }
                    bus.timetable.forEach { timetable in
                        if timetable.time.starts(with: "00:") {
                            section3TimetableList.append(BusTimetableArrivalItem(time: "24" + timetable.time.dropFirst(2)))
                        } else {
                            section3TimetableList.append(BusTimetableArrivalItem(time: timetable.time))
                        }
                    }
                }
            } else if self.busType == .suwon {
                busRealtime.filter({ $0.routeID == 216000070 && $0.stopID == 216000719 }).forEach { bus in
                    bus.realtime.forEach { realtime in
                        section1RealtimeList.append(BusRealtimeArrivalItem(routeName: bus.routeName, realtime: realtime))
                    }
                    bus.timetable.forEach { timetable in
                        if timetable.time.starts(with: "00:") {
                            section1TimetableList.append(BusTimetableArrivalItem(time: "24" + timetable.time.dropFirst(2)))
                        } else {
                            section1TimetableList.append(BusTimetableArrivalItem(time: timetable.time))
                        }
                    }
                }
                busRealtime.filter({ $0.stopID == 216000070 }).forEach { bus in
                    bus.realtime.forEach { realtime in
                        section2RealtimeList.append(BusRealtimeArrivalItem(routeName: bus.routeName, realtime: realtime))
                    }
                    bus.timetable.forEach { timetable in
                        if timetable.time.starts(with: "00:") {
                            section2TimetableList.append(BusTimetableArrivalItem(time: "24" + timetable.time.dropFirst(2)))
                        } else {
                            section2TimetableList.append(BusTimetableArrivalItem(time: timetable.time))
                        }
                    }
                }
            }
            
            section1RealtimeList.sorted(by: { $0.realtime!.remainingTime < $1.realtime!.remainingTime }).forEach{
                section1List.append(BusArrivalItem(realtime: $0, timetable: nil))
            }
            section1TimetableList.sorted(by: { $0.time < $1.time }).forEach{
                section1List.append(BusArrivalItem(realtime: nil, timetable: $0))
            }
            section2RealtimeList.sorted(by: { $0.realtime!.remainingTime < $1.realtime!.remainingTime }).forEach{
                section2List.append(BusArrivalItem(realtime: $0, timetable: nil))
            }
            section2TimetableList.sorted(by: { $0.time < $1.time }).forEach{
                section2List.append(BusArrivalItem(realtime: nil, timetable: $0))
            }
            section3RealtimeList.sorted(by: { $0.realtime!.remainingTime < $1.realtime!.remainingTime }).forEach{
                section3List.append(BusArrivalItem(realtime: $0, timetable: nil))
            }
            section3TimetableList.sorted(by: { $0.time < $1.time }).forEach{
                section3List.append(BusArrivalItem(realtime: nil, timetable: $0))
            }
            
            self.section1List = section1List
            self.section2List = section2List
            self.section3List = section3List
            
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
    
    @objc private func refreshTableView(_ sender: AnyObject) {}
}

extension BusRealtimeListViewController: UITableViewDelegate {
    // Section header configuration
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: BusRealtimeHeaderView.identifier) as? BusRealtimeHeaderView else {
             return UIView()
         }
        headerView.setUpHeaderView(label: String.localizedBusItem(resourceID: String.LocalizationValue(self.sectionList[section])))
        return headerView
     }
    
    // Section footer configuration
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: BusRealtimeFooterView.identifier) as? BusRealtimeFooterView else {
            return UIView()
        }
        return footerView
    }
}

extension BusRealtimeListViewController: UITableViewDataSource {
    // Number of rows per section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return max(min(section1List.count, 3), 1)
        } else if section == 1 {
            return max(min(section2List.count, 3), 1)
        } else {
            return max(min(section3List.count, 3), 1)
        }
    }
    
    // Cell configuration
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataCell = tableView.dequeueReusableCell(withIdentifier: BusRealtimeListItemView.identifier, for: indexPath) as! BusRealtimeListItemView
        
        let emptyCell = tableView.dequeueReusableCell(withIdentifier: BusEmptyListItemView.identifier, for: indexPath) as! BusEmptyListItemView
        if indexPath.section == 0 && !section1List.isEmpty {
            dataCell.setUpCell(item: section1List[indexPath.row])
            return dataCell
        } else if indexPath.section == 1 && !section2List.isEmpty {
            dataCell.setUpCell(item: section2List[indexPath.row])
            return dataCell
        } else if indexPath.section == 2 && !section3List.isEmpty {
            dataCell.setUpCell(item: section3List[indexPath.row])
            return dataCell
        }
        return emptyCell
    }
    
    // Section header height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionList.count
    }
}
