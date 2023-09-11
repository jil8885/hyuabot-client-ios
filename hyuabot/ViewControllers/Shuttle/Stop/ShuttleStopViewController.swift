import UIKit
import MapKit
import QueryAPI

class ShuttleStopViewController: UIViewController  {
    private var shuttleStop: ShuttleStop? = nil
    private var shuttleStopName: String? = nil
    private var categoryList: [String] = []
    private var category1List: [ShuttleFirstLastItem] = [
        ShuttleFirstLastItem(type: "shuttle.days.weekdays", first: nil, last: nil),
        ShuttleFirstLastItem(type: "shuttle.days.weekends", first: nil, last: nil),
    ]
    private var category2List: [ShuttleFirstLastItem] = [
        ShuttleFirstLastItem(type: "shuttle.days.weekdays", first: nil, last: nil),
        ShuttleFirstLastItem(type: "shuttle.days.weekends", first: nil, last: nil),
    ]
    private var category3List: [ShuttleFirstLastItem] = [
        ShuttleFirstLastItem(type: "shuttle.days.weekdays", first: nil, last: nil),
        ShuttleFirstLastItem(type: "shuttle.days.weekends", first: nil, last: nil),
    ]
    private lazy var stopLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkText
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var shuttleStopMapView: MKMapView = {
        let view = MKMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isZoomEnabled = true
        view.isScrollEnabled = false
        
        return view
    }()
    private lazy var firstLastBusTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.register(ShuttleRealtimeHeaderView.self, forHeaderFooterViewReuseIdentifier: ShuttleRealtimeHeaderView.identifier)
        tableView.register(ShuttleStopTableCell.self, forCellReuseIdentifier: ShuttleStopTableCell.identifier)
        return tableView
    }()
    
    init(shuttleStop: ShuttleStop? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.shuttleStop = shuttleStop
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupView()
        queryFirstLastShuttle()
    }
    
    private func setupView() {
        var stopLocation: CLLocation? = nil
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(stopLabel)
        self.view.addSubview(shuttleStopMapView)
        self.view.addSubview(firstLastBusTableView)
        
        switch shuttleStop {
        case .dormitoryOut:
            stopLabel.text = String.localizedShuttleItem(resourceID: "dormitory_o")
            stopLocation = CLLocation(latitude: 37.29339607529377, longitude: 126.83630604103446)
            shuttleStopName = "dormitory_o"
            categoryList = [
                "shuttle_destination_subway",
                "shuttle_destination_terminal",
                "shuttle_destination_jungang_station",
            ]
        case .shuttlecockOut:
            stopLabel.text = String.localizedShuttleItem(resourceID: "shuttlecock_o")
            shuttleStopName = "shuttlecock_o"
            stopLocation = CLLocation(latitude:37.29875417910844, longitude: 126.83784054072336)
            categoryList = [
                "shuttle_destination_subway",
                "shuttle_destination_terminal",
                "shuttle_destination_jungang_station",
            ]
        case .station:
            stopLabel.text = String.localizedShuttleItem(resourceID: "station")
            shuttleStopName = "station"
            stopLocation = CLLocation(latitude:37.3096539, longitude: 126.8520997)
            categoryList = [
                "shuttle_destination_campus",
                "shuttle_destination_terminal",
                "shuttle_destination_jungang_station",
            ]
        case .terminal:
            stopLabel.text = String.localizedShuttleItem(resourceID: "terminal")
            shuttleStopName = "terminal"
            stopLocation = CLLocation(latitude:37.31945164682341, longitude: 126.8455453372041)
            categoryList = ["shuttle_destination_campus"]
        case .jungangStation:
            stopLabel.text = String.localizedShuttleItem(resourceID: "jungang_station")
            shuttleStopName = "jungang_stn"
            stopLocation = CLLocation(latitude:37.3147818, longitude: 126.8397399)
            categoryList = ["shuttle_destination_campus"]
        case .shuttlecockIn:
            stopLabel.text = String.localizedShuttleItem(resourceID: "shuttlecock_i")
            shuttleStopName = "shuttlecock_i"
            stopLocation = CLLocation(latitude:37.29869328231496, longitude: 126.8377767466817)
            categoryList = ["shuttle_destination_campus"]
        default:
            stopLabel.text = ""
        }
        
        if stopLocation !== nil {
            moveLocation(latitudeValue: stopLocation!.coordinate.latitude, longtudeValue: stopLocation!.coordinate.longitude, delta: 0.0025)
            setAnnotation(
                latitudeValue: stopLocation!.coordinate.latitude,
                longitudeValue: stopLocation!.coordinate.longitude,
                delta: 0.0025,
                title: stopLabel.text!,
                subtitle: ""
            )
        }
        
        NSLayoutConstraint.activate([
            stopLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stopLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10),
            shuttleStopMapView.topAnchor.constraint(equalTo: stopLabel.bottomAnchor, constant: 10),
            shuttleStopMapView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            shuttleStopMapView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            shuttleStopMapView.heightAnchor.constraint(equalToConstant: 300),
            firstLastBusTableView.topAnchor.constraint(equalTo: shuttleStopMapView.bottomAnchor),
            firstLastBusTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            firstLastBusTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            firstLastBusTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    func moveLocation(latitudeValue: CLLocationDegrees, longtudeValue: CLLocationDegrees, delta span: Double) {
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longtudeValue)
        let pSpanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: pSpanValue)
        self.shuttleStopMapView.setRegion(pRegion, animated: true)
    }
    
    func setAnnotation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span :Double, title strTitle: String, subtitle strSubTitle:String) {
        self.shuttleStopMapView.removeAnnotations(self.shuttleStopMapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        annotation.title = strTitle
        annotation.subtitle = strSubTitle
        self.shuttleStopMapView.addAnnotation(annotation)
    }
    
    func queryFirstLastShuttle() {
        guard let shuttleStopName = self.shuttleStopName else {
            return
        }
        Network.shared.apollo.fetch(query: ShuttleStopTimetableQuery(stop: shuttleStopName)) { result in
            switch result {
            case .success(let graphQLResult):
                self.setData(data: graphQLResult.data!)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func setData(data: ShuttleStopTimetableQuery.Data) {
        guard let stopItem = data.shuttle.stop.first else {
            return
        }
        var category1List: [ShuttleFirstLastItem] = []
        var category2List: [ShuttleFirstLastItem] = []
        var category3List: [ShuttleFirstLastItem] = []
        var category1Weekdays: [ShuttleStopTimetableQuery.Data.Shuttle.Stop.Tag.Timetable] = []
        var category1Weekends: [ShuttleStopTimetableQuery.Data.Shuttle.Stop.Tag.Timetable] = []
        var category2Weekdays: [ShuttleStopTimetableQuery.Data.Shuttle.Stop.Tag.Timetable] = []
        var category2Weekends: [ShuttleStopTimetableQuery.Data.Shuttle.Stop.Tag.Timetable] = []
        var category3Weekdays: [ShuttleStopTimetableQuery.Data.Shuttle.Stop.Tag.Timetable] = []
        var category3Weekends: [ShuttleStopTimetableQuery.Data.Shuttle.Stop.Tag.Timetable] = []
        if self.shuttleStop == .dormitoryOut || self.shuttleStop == .shuttlecockOut {
            stopItem.tag.forEach { tagItem in
                if tagItem.tagID == "DH" {
                    tagItem.timetable.forEach{ timetableItem in
                        if timetableItem.weekdays {
                            category1Weekdays.append(timetableItem)
                        } else {
                            category1Weekends.append(timetableItem)
                        }
                    }
                } else if tagItem.tagID == "C" {
                    tagItem.timetable.forEach{ timetableItem in
                        if timetableItem.weekdays {
                            category1Weekdays.append(timetableItem)
                            category2Weekdays.append(timetableItem)
                        } else {
                            category1Weekends.append(timetableItem)
                            category2Weekends.append(timetableItem)
                        }
                    }
                } else if tagItem.tagID == "DJ" {
                    tagItem.timetable.forEach{ timetableItem in
                        if timetableItem.weekdays {
                            category1Weekdays.append(timetableItem)
                            category3Weekdays.append(timetableItem)
                        } else {
                            category1Weekends.append(timetableItem)
                            category3Weekends.append(timetableItem)
                        }
                    }
                } else if tagItem.tagID == "DY" {
                    tagItem.timetable.forEach{ timetableItem in
                        if timetableItem.weekdays {
                            category2Weekdays.append(timetableItem)
                        } else {
                            category2Weekends.append(timetableItem)
                        }
                    }
                }
            }
        }
        else if self.shuttleStop == .station {
            stopItem.tag.forEach { tagItem in
                if tagItem.tagID == "DH" {
                    tagItem.timetable.forEach{ timetableItem in
                        if timetableItem.weekdays {
                            category1Weekdays.append(timetableItem)
                        } else {
                            category1Weekends.append(timetableItem)
                        }
                    }
                } else if tagItem.tagID == "C" {
                    tagItem.timetable.forEach{ timetableItem in
                        if timetableItem.weekdays {
                            category1Weekdays.append(timetableItem)
                            category2Weekdays.append(timetableItem)
                        } else {
                            category1Weekends.append(timetableItem)
                            category2Weekends.append(timetableItem)
                        }
                    }
                } else if tagItem.tagID == "DJ" {
                    tagItem.timetable.forEach{ timetableItem in
                        if timetableItem.weekdays {
                            category1Weekdays.append(timetableItem)
                            category3Weekdays.append(timetableItem)
                        } else {
                            category1Weekends.append(timetableItem)
                            category3Weekends.append(timetableItem)
                        }
                    }
                }
            }
        }
        else {
            stopItem.tag.forEach { tagItem in
                tagItem.timetable.forEach{ timetableItem in
                    if timetableItem.weekdays {
                        category1Weekdays.append(timetableItem)
                    } else {
                        category1Weekends.append(timetableItem)
                    }
                }
            }
        }
        
        category1Weekdays.sort(by: { $0.time < $1.time })
        category1Weekends.sort(by: { $0.time < $1.time })
        category2Weekdays.sort(by: { $0.time < $1.time })
        category2Weekends.sort(by: { $0.time < $1.time })
        category3Weekdays.sort(by: { $0.time < $1.time })
        category3Weekends.sort(by: { $0.time < $1.time })
        category1List = [
            ShuttleFirstLastItem(type: "shuttle.days.weekdays", first: category1Weekdays.first?.time, last: category1Weekdays.last?.time),
            ShuttleFirstLastItem(type: "shuttle.days.weekends", first: category1Weekends.first?.time, last: category1Weekends.last?.time)
        ]
        category2List = [
            ShuttleFirstLastItem(type: "shuttle.days.weekdays", first: category2Weekdays.first?.time, last: category2Weekdays.last?.time),
            ShuttleFirstLastItem(type: "shuttle.days.weekends", first: category2Weekends.first?.time, last: category2Weekends.last?.time)
        ]
        category3List = [
            ShuttleFirstLastItem(type: "shuttle.days.weekdays", first: category3Weekdays.first?.time, last: category3Weekdays.last?.time),
            ShuttleFirstLastItem(type: "shuttle.days.weekends", first: category3Weekends.first?.time, last: category3Weekends.last?.time)
        ]
        
        self.category1List = category1List
        self.category2List = category2List
        self.category3List = category3List
        self.firstLastBusTableView.reloadData()
    }
}

extension ShuttleStopViewController: UITableViewDelegate {
    // Section header configuration
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ShuttleRealtimeHeaderView.identifier) as? ShuttleRealtimeHeaderView else {
             return UIView()
         }
        headerView.setUpHeaderView(label: String.localizedShuttleItem(resourceID: String.LocalizationValue(categoryList[section])))
        return headerView
     }
}

extension ShuttleStopViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataCell = tableView.dequeueReusableCell(withIdentifier: ShuttleStopTableCell.identifier, for: indexPath) as! ShuttleStopTableCell
        if indexPath.section == 0 {
            dataCell.setUpCell(
                type: self.category1List[indexPath.row].type,
                first: self.category1List[indexPath.row].first,
                last: self.category1List[indexPath.row].last)
        } else if indexPath.section == 1 {
            dataCell.setUpCell(
                type: self.category2List[indexPath.row].type,
                first: self.category2List[indexPath.row].first,
                last: self.category2List[indexPath.row].last)
        } else if indexPath.section == 2 {
            dataCell.setUpCell(
                type: self.category3List[indexPath.row].type,
                first: self.category3List[indexPath.row].first,
                last: self.category3List[indexPath.row].last)
        }
        return dataCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.categoryList.count
    }
}
