import UIKit
import RxSwift
import Then
import QueryAPI

class CafeteriaListViewController: UIViewController {
    private let tableView: UITableView = UITableView()
    private let disposeBag = DisposeBag()
    private var mealType: MealType = .breakfast
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let refreshControl = UIRefreshControl()
    private var menuList: [Int:[CafeteriaQuery.Data.Cafeterium.Menu]] = [:]
    
    init(mealType: MealType) {
        super.init(nibName: nil, bundle: nil)
        self.mealType = mealType
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
            $0.register(CafeteriaHeaderView.self, forHeaderFooterViewReuseIdentifier: CafeteriaHeaderView.identifier)
            $0.register(CafeteriaListItemView.self, forCellReuseIdentifier: CafeteriaListItemView.identifier)
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
        appDelegate.cafeteriaQuery.subscribe(onNext: { cafeteriaList in
            var menuList: [Int:[CafeteriaQuery.Data.Cafeterium.Menu]] = [:]
            
            if self.mealType == .breakfast {
                cafeteriaList.forEach {
                    if $0.menu.filter({ item in
                        item.slot == "조식"
                    }).count > 0 {
                        if menuList.keys.contains($0.id) {
                            menuList[$0.id]?.append(contentsOf: $0.menu.filter ({ item in
                                item.slot == "조식"
                            }))
                        } else {
                            menuList[$0.id] = $0.menu.filter ({ item in
                                item.slot == "조식"
                            })
                        }
                    }
                }
            } else if self.mealType == .lunch {
                cafeteriaList.forEach {
                    if $0.menu.filter({ item in
                        item.slot == "중식"
                    }).count > 0 {
                        if menuList.keys.contains($0.id) {
                            menuList[$0.id]?.append(contentsOf: $0.menu.filter ({ item in
                                item.slot == "중식"
                            }))
                        } else {
                            menuList[$0.id] = $0.menu.filter ({ item in
                                item.slot == "중식"
                            })
                        }
                    }
                }
            } else if self.mealType == .dinner {
                cafeteriaList.forEach {
                    if $0.menu.filter({ item in
                        item.slot == "석식"
                    }).count > 0 {
                        if menuList.keys.contains($0.id) {
                            menuList[$0.id]?.append(contentsOf: $0.menu.filter ({ item in
                                item.slot == "석식"
                            }))
                        } else {
                            menuList[$0.id] = $0.menu.filter ({ item in
                                item.slot == "석식"
                            })
                        }
                    }
                }
            
            }
            self.menuList = menuList
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }).disposed(by: disposeBag)
    }
    
    @objc private func refreshTableView(_ sender: AnyObject) {
        self.appDelegate.queryCafeteriaPage()
    }
}

extension CafeteriaListViewController: UITableViewDelegate {
    // Section header configuration
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CafeteriaHeaderView.identifier) as? CafeteriaHeaderView else {
             return UIView()
         }
        let cafeteriaKey = String("cafeteria.name.\(String(Array(self.menuList.keys)[section]))")
        headerView.setUpHeaderView(label: String.localizedCafeteriaItem(resourceID: String.LocalizationValue(cafeteriaKey)))
        return headerView
     }
}

extension CafeteriaListViewController: UITableViewDataSource {
    // Number of rows per section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuList[Array(self.menuList.keys)[section]]?.count ?? 0
    
    }
    
    // Cell configuration
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataCell = tableView.dequeueReusableCell(withIdentifier: CafeteriaListItemView.identifier, for: indexPath) as! CafeteriaListItemView
        dataCell.setUpCell(item: self.menuList[Array(self.menuList.keys)[indexPath.section]]![indexPath.row])
        return dataCell
    }
    
    // Section header height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.menuList.keys.count
    }
}
