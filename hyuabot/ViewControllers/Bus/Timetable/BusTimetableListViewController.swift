import UIKit
import RxSwift
import QueryAPI


class BusTimetableListViewController: UIViewController {
    let tableView: UITableView = UITableView()
    let disposeBag = DisposeBag()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var date: BusDate = .weekdays
    private var timetableList: [BusTimetableArrivalItem] = []
    
    init(date: BusDate){
        super.init(nibName: nil, bundle: nil)
        self.date = date
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
        tableView.register(BusEmptyListItemView.self, forCellReuseIdentifier: BusEmptyListItemView.identifier)
        tableView.register(BusTimetableListItemView.self, forCellReuseIdentifier: BusTimetableListItemView.identifier)
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
        appDelegate.busTimetableQuery.subscribe(onNext: { data in
            // Get first item or return
            var timetableList: [BusTimetableArrivalItem] = []
            var date = "weekdays"
            if self.date == .weekdays {
                date = "weekdays"
            } else if self.date == .saturdays {
                date = "saturday"
            } else {
                date = "sunday"
            }
            
            data.forEach{
                $0.timetable.forEach{
                    if $0.weekday == date {
                        if $0.time.starts(with: "00:") {
                            timetableList.append(BusTimetableArrivalItem(time: "24" + $0.time.dropFirst(2)))
                        } else {
                            timetableList.append(BusTimetableArrivalItem(time: $0.time))
                        }
                    }
                }
            }
            self.timetableList = timetableList.sorted(by: { $0.time < $1.time })
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
}

extension BusTimetableListViewController: UITableViewDelegate {}

extension BusTimetableListViewController: UITableViewDataSource {
    // Number of rows per section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        max(self.timetableList.count, 1)
    }
    
    // Cell configuration
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataCell = tableView.dequeueReusableCell(withIdentifier: "BusTimetableListItemView", for: indexPath) as! BusTimetableListItemView
        let emptyCell = tableView.dequeueReusableCell(withIdentifier: "BusEmptyListItemView", for: indexPath) as! BusEmptyListItemView
        if indexPath.section == 0 && !self.timetableList.isEmpty {
            dataCell.setUpCell(item: self.timetableList[indexPath.row])
            return dataCell
        }
        return emptyCell
    }
    
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
