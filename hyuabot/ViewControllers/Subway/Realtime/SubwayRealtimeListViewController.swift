import UIKit
import RxSwift
import Then
import QueryAPI

class SubwayRealtimeListViewController: UIViewController {
    private let tableView: UITableView = UITableView()
    private let disposeBag = DisposeBag()
    private var subwayType: SubwayType = .skyblue
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let refreshControl = UIRefreshControl()
    private var sectionList: [String] = []
    private var section1List: [SubwayArrivalItem] = []
    private var section2List: [SubwayArrivalItem] = []
    
    init(subwayType: SubwayType) {
        super.init(nibName: nil, bundle: nil)
        self.subwayType = subwayType
        switch self.subwayType {
        case .skyblue:
            self.sectionList = ["subway.skyblue.up", "subway.skyblue.down"]
        case .yellow:
            self.sectionList = ["subway.yellow.up", "subway.yellow.down"]
        case .transfer:
            self.sectionList = ["subway.transfer.up", "subway.transfer.down"]
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
            $0.register(SubwayRealtimeHeaderView.self, forHeaderFooterViewReuseIdentifier: SubwayRealtimeHeaderView.identifier)
            $0.register(SubwayRealtimeFooterView.self, forHeaderFooterViewReuseIdentifier: SubwayRealtimeFooterView.identifier)
            $0.register(SubwayRealtimeListItemView.self, forCellReuseIdentifier: SubwayRealtimeListItemView.identifier)
            $0.register(SubwayEmptyListView.self, forCellReuseIdentifier: SubwayEmptyListView.identifier)
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
        appDelegate.subwayRealtimeQuery.subscribe(onNext: { stationList in
            var section1List: [SubwayArrivalItem] = []
            var section1RealtimeList: [SubwayRealtimeQuery.Data.Subway.Realtime.Up] = []
            var section1TimetableList: [SubwayTimetableArrivalItem] = []
            var section2List: [SubwayArrivalItem] = []
            var section2RealtimeList: [SubwayRealtimeQuery.Data.Subway.Realtime.Down] = []
            var section2TimetableList: [SubwayTimetableArrivalItem] = []
            var section1TransferList: [TransferItem] = []
            var section2TransferList: [TransferItem] = []
            
            var upMaxReminaingTime: Int = 0
            var downMaxReminaingTime: Int = 0
            let now = Foundation.Date()
            
            if self.subwayType == .skyblue {
                guard let stationItem = stationList.filter({ $0.id == "K449" }).first else { return }
                stationItem.realtime.up.forEach{
                    section1RealtimeList.append($0)
                    upMaxReminaingTime = $0.remainingTime
                }
                stationItem.realtime.down.forEach{
                    section2RealtimeList.append($0)
                    downMaxReminaingTime = $0.remainingTime
                }
                stationItem.timetable.up.filter({
                    self.caculateRemainingTime(current: now, departureTime: $0.time) > upMaxReminaingTime + 2
                }).forEach{
                    section1TimetableList.append(SubwayTimetableArrivalItem(destinationID: $0.destinationID, destinationName: $0.destinationName, time: $0.time))
                }
                stationItem.timetable.down.filter({
                    self.caculateRemainingTime(current: now, departureTime: $0.time) > downMaxReminaingTime + 2
                }).forEach{
                    section2TimetableList.append(SubwayTimetableArrivalItem(destinationID: $0.destinationID, destinationName: $0.destinationName, time: $0.time))
                }
                
                section1RealtimeList.forEach{
                    section1List.append(SubwayArrivalItem(upRealtime: $0, downRealtime: nil, timetable: nil, transferItem: nil))
                }
                section1TimetableList.forEach{
                    section1List.append(SubwayArrivalItem(upRealtime: nil, downRealtime: nil, timetable: $0, transferItem: nil))
                }
                section2RealtimeList.forEach{
                    section2List.append(SubwayArrivalItem(upRealtime: nil, downRealtime: $0, timetable: nil, transferItem: nil))
                }
                section2TimetableList.forEach{
                    section2List.append(SubwayArrivalItem(upRealtime: nil, downRealtime: nil, timetable: $0, transferItem: nil))
                }
            } else if self.subwayType == .yellow {
                guard let stationItem = stationList.filter({ $0.id == "K251" }).first else { return }
                stationItem.realtime.up.forEach{
                    section1RealtimeList.append($0)
                    upMaxReminaingTime = $0.remainingTime
                }
                stationItem.realtime.down.forEach{
                    section2RealtimeList.append($0)
                    downMaxReminaingTime = $0.remainingTime
                }
                
                stationItem.timetable.up.filter({
                    self.caculateRemainingTime(current: now, departureTime: $0.time) > upMaxReminaingTime + 2
                }).forEach{
                    section1TimetableList.append(SubwayTimetableArrivalItem(destinationID: $0.destinationID, destinationName: $0.destinationName, time: $0.time))
                }
                stationItem.timetable.down.filter({
                    self.caculateRemainingTime(current: now, departureTime: $0.time) > downMaxReminaingTime + 2
                }).forEach{
                    section2TimetableList.append(SubwayTimetableArrivalItem(destinationID: $0.destinationID, destinationName: $0.destinationName, time: $0.time))
                }
                
                section1RealtimeList.forEach{
                    section1List.append(SubwayArrivalItem(upRealtime: $0, downRealtime: nil, timetable: nil, transferItem: nil))
                }
                section1TimetableList.forEach{
                    section1List.append(SubwayArrivalItem(upRealtime: nil, downRealtime: nil, timetable: $0, transferItem: nil))
                }
                section2RealtimeList.forEach{
                    section2List.append(SubwayArrivalItem(upRealtime: nil, downRealtime: $0, timetable: nil, transferItem: nil))
                }
                section2TimetableList.forEach{
                    section2List.append(SubwayArrivalItem(upRealtime: nil, downRealtime: nil, timetable: $0, transferItem: nil))
                }
            } else if self.subwayType == .transfer {
                guard let yellowOido = stationList.filter({ $0.id == "K258" }).first else { return }
                guard let skyblueOido = stationList.filter({ $0.id == "K456" }).first else { return }
                yellowOido.realtime.up.filter({ $0.destinationID < "K251" }).forEach { item in
                    section1TransferList.append(TransferItem(upFrom: item, upTo: nil, downFrom: nil, downTo: nil))
                }
                yellowOido.realtime.up.filter({ $0.destinationID == "K258" }).forEach{  item in
                    guard let firstItem = skyblueOido.timetable.up.filter({ self.caculateRemainingTime(current: now, departureTime: $0.time) > item.remainingTime }).first else { return }
                    section1TransferList.append(TransferItem(upFrom: item, upTo: firstItem, downFrom: nil, downTo: nil))
                }
                yellowOido.realtime.down.filter({ $0.destinationID == "K272" && $0.remainingTime > 20 }).forEach { item in
                    section2TransferList.append(TransferItem(upFrom: nil, upTo: nil, downFrom: item, downTo: nil))
                }
                skyblueOido.realtime.down.filter({ $0.remainingTime > 20 }).forEach{ item in
                    guard let firstItem = yellowOido.timetable.down.filter({ self.caculateRemainingTime(current: now, departureTime: $0.time) > item.remainingTime }).first else { return }
                    section2TransferList.append(TransferItem(upFrom: nil, upTo: nil, downFrom: item, downTo: firstItem))
                }
                
                
                
                section1TransferList.forEach{
                    section1List.append(SubwayArrivalItem(upRealtime: nil, downRealtime: nil, timetable: nil, transferItem: $0))
                }
                section2TransferList.forEach{
                    section2List.append(SubwayArrivalItem(upRealtime: nil, downRealtime: nil, timetable: nil, transferItem: $0))
                }
                section1List.sort(by: { $0.transferItem!.upFrom!.remainingTime < $1.transferItem!.upFrom!.remainingTime })
                section2List.sort(by: { $0.transferItem!.downFrom!.remainingTime < $1.transferItem!.downFrom!.remainingTime })
            }

            self.section1List = section1List
            self.section2List = section2List
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
    
    @objc private func refreshTableView(_ sender: AnyObject) {}
    
    func caculateRemainingTime(current: Foundation.Date, departureTime: String) -> Int {
        let splitTime = departureTime.split(separator: ":")
        var hour = Int(splitTime[0])!
        if hour < 4 {
            hour += 24
        }
        
        let minute = Int(splitTime[1])!
        let timeDelta = 60 * (hour - Calendar.current.component(.hour, from: current)) + (minute - Calendar.current.component(.minute, from: current))
        
        return timeDelta
    }
}

extension SubwayRealtimeListViewController: UITableViewDelegate {
    // Section header configuration
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: SubwayRealtimeHeaderView.identifier) as? SubwayRealtimeHeaderView else {
             return UIView()
         }
        headerView.setUpHeaderView(label: String.localizedSubwayItem(resourceID: String.LocalizationValue(self.sectionList[section])))
        return headerView
     }
    
    // Section footer configuration
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: SubwayRealtimeFooterView.identifier) as? SubwayRealtimeFooterView else {
            return UIView()
        }
        if section == 0 {
            footerView.setUpFooterView(subwayType: self.subwayType, heading: .up)
        } else if section == 1 {
            footerView.setUpFooterView(subwayType: self.subwayType, heading: .down)
        }
        return footerView
    }
}

extension SubwayRealtimeListViewController: UITableViewDataSource {
    // Number of rows per section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return max(min(section1List.count, 6), 1)
        } else if section == 1 {
            return max(min(section2List.count, 6), 1)
        }
        return 1
    }
    
    // Cell configuration
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataCell = tableView.dequeueReusableCell(withIdentifier: SubwayRealtimeListItemView.identifier, for: indexPath) as! SubwayRealtimeListItemView
        
        let emptyCell = tableView.dequeueReusableCell(withIdentifier: SubwayEmptyListView.identifier, for: indexPath) as! SubwayEmptyListView
        if indexPath.section == 0 && !section1List.isEmpty {
            dataCell.setUpCell(item: section1List[indexPath.row])
            return dataCell
        } else if indexPath.section == 1 && !section2List.isEmpty {
            dataCell.setUpCell(item: section2List[indexPath.row])
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
