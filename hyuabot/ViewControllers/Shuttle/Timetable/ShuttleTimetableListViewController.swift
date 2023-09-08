import UIKit
import RxSwift
import QueryAPI


class ShuttleTimetableListViewController: UIViewController {
    let tableView: UITableView = UITableView()
    let disposeBag = DisposeBag()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var date: ShuttleDate = .weekdays
    private var timetableList: [ShuttleTimetableItem] = []
    
    init(date: ShuttleDate){
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
        tableView.register(ShuttleEmptyListItemView.self, forCellReuseIdentifier: ShuttleEmptyListItemView.identifier)
        tableView.register(ShuttleTimetableListItemView.self, forCellReuseIdentifier: ShuttleTimetableListItemView.identifier)
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
        appDelegate.shuttleTimetableQuery.subscribe(onNext: { data in
            // Get first item or return
            guard let filteredData = data.first else { return }
            var timetable: [ShuttleTimetableItem] = []
            
            
            switch self.date {
            case .weekdays:
                filteredData.tag.forEach({ tagItem in
                    tagItem.timetable.filter{ $0.weekdays == true }.forEach({ timetableItem in
                        timetable.append(ShuttleTimetableItem(tag: tagItem.tagID, timetable: timetableItem))
                    })
                })
            case .weekends:
                filteredData.tag.forEach({ tagItem in
                    tagItem.timetable.filter{ $0.weekdays == false }.forEach({ timetableItem in
                        timetable.append(ShuttleTimetableItem(tag: tagItem.tagID, timetable: timetableItem))
                    })
                })
            }
            self.timetableList = timetable.sorted(by: { $0.timetable.time < $1.timetable.time })
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
}

extension ShuttleTimetableListViewController: UITableViewDelegate {}

extension ShuttleTimetableListViewController: UITableViewDataSource {
    // Number of rows per section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        max(self.timetableList.count, 1)
    }
    
    // Cell configuration
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataCell = tableView.dequeueReusableCell(withIdentifier: "ShuttleTimetableListItemView", for: indexPath) as! ShuttleTimetableListItemView
        let emptyCell = tableView.dequeueReusableCell(withIdentifier: "ShuttleEmptyListItemView", for: indexPath) as! ShuttleEmptyListItemView
        if indexPath.section == 0 && !self.timetableList.isEmpty {
            dataCell.setUpCell(item: self.timetableList[indexPath.row])
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
        return 1
    }
}
