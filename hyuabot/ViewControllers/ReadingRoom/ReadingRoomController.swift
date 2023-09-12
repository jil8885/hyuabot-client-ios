import UIKit
import RxSwift
import Then
import QueryAPI

class ReadingRoomController: UIViewController {
    private let tableView: UITableView = UITableView()
    private let disposeBag = DisposeBag()
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let refreshControl = UIRefreshControl()
    private var roomList: [ReadingRoomQuery.Data.ReadingRoom] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupView()
        self.subscribeData()
        self.appDelegate.queryReadingRoomPage()
    }
    
    private func setupTableView(){
        self.tableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.refreshControl = self.refreshControl
            $0.refreshControl?.addTarget(self, action: #selector(refreshTableView(_:)), for: .valueChanged)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.sectionHeaderTopPadding = 0
            $0.register(ReadingRoomListItemView.self, forCellReuseIdentifier: ReadingRoomListItemView.identifier)
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
        appDelegate.readingRoomQuery.subscribe(onNext: { roomList in
            self.roomList = roomList
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }).disposed(by: disposeBag)
    }
    
    @objc private func refreshTableView(_ sender: AnyObject) {
        self.appDelegate.queryCafeteriaPage()
    }
}

extension ReadingRoomController: UITableViewDelegate {}

extension ReadingRoomController: UITableViewDataSource {
    // Number of rows per section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.roomList.count
    
    }
    
    // Cell configuration
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataCell = tableView.dequeueReusableCell(withIdentifier: ReadingRoomListItemView.identifier, for: indexPath) as! ReadingRoomListItemView
        dataCell.setUpCell(item: self.roomList[indexPath.row])
        return dataCell
    }
    
    // Section header height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
