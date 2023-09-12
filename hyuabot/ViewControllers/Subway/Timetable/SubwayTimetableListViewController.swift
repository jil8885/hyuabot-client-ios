import UIKit
import RxSwift
import QueryAPI


class SubwayTimetableListViewController: UIViewController {
    let tableView: UITableView = UITableView()
    let disposeBag = DisposeBag()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var stationID: String = ""
    private var heading: SubwayHeading? = nil
    private var weekdays: SubwayWeekdays? = nil
    private var upTimetableList: [SubwayTimetableUpQuery.Data.Subway.Timetable.Up] = []
    private var downTimetableList: [SubwayTimetableDownQuery.Data.Subway.Timetable.Down] = []
    
    
    init(stationID: String, heading: SubwayHeading, weekdays: SubwayWeekdays) {
        super.init(nibName: nil, bundle: nil)
        self.stationID = stationID
        self.heading = heading
        self.weekdays = weekdays
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
        tableView.register(SubwayEmptyListView.self, forCellReuseIdentifier: SubwayEmptyListView.identifier)
        tableView.register(SubwayTimetableListItemView.self, forCellReuseIdentifier: SubwayTimetableListItemView.identifier)
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
        if self.heading == .up {
            appDelegate.subwayTimetableUpQuery.subscribe(onNext: { data in
                self.upTimetableList = data
                self.tableView.reloadData()
            }).disposed(by: disposeBag)
        } else {
            appDelegate.subwayTimetableDownQuery.subscribe(onNext: { data in
                self.downTimetableList = data
                self.tableView.reloadData()
            }).disposed(by: disposeBag)
        }
    }
}

extension SubwayTimetableListViewController: UITableViewDelegate {}

extension SubwayTimetableListViewController: UITableViewDataSource {
    // Number of rows per section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        max(self.upTimetableList.count + self.downTimetableList.count, 1)
    }
    
    // Cell configuration
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataCell = tableView.dequeueReusableCell(withIdentifier: "SubwayTimetableListItemView", for: indexPath) as! SubwayTimetableListItemView
        let emptyCell = tableView.dequeueReusableCell(withIdentifier: "SubwayEmptyListView", for: indexPath) as! SubwayEmptyListView
        if !self.upTimetableList.isEmpty {
            dataCell.setUpCell(item: self.upTimetableList[indexPath.row])
            return dataCell
        } else if !self.downTimetableList.isEmpty {
            dataCell.setUpCell(item: self.downTimetableList[indexPath.row])
            return dataCell
        }
        return emptyCell
    }
    
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
