//
//  ViewController.swift
//  RedditAmiGo
//
//  Created by Leonardo Saganski on 3/5/21.
//

import UIKit

class EntryListViewController: UIViewController, ViewControllerProtocol {
    @IBOutlet weak var tableView: UITableView!

    private var isLoading = false
    private let refreshControl = UIRefreshControl()
    private var loading: Loading?
    private var coordinator: Coordinator?
    private var viewModel: EntryListViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Reddit Entries!"
        loading = Loading(view: self.view)
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData(reload: true)
    }
    
    func setCoordinator(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func bindViewModel(viewModel: ViewModelProtocol) {
        self.viewModel = viewModel as? EntryListViewModel
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let cellNib = UINib(nibName: "EntryListTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier:
                                    "cell")
        tableView.register(LoadingTableViewCell.self, forCellReuseIdentifier: "loadingCell")
        refreshControl.tintColor = .brown
        refreshControl.attributedTitle = NSAttributedString(string: "Carregando dados...")
        self.tableView?.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(onRefreshData), for: .valueChanged)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
    }
    
    @objc
    private func onRefreshData() {
        loadData(reload: true)
    }

    private func loadData(reload: Bool) {
        if !isLoading {
            isLoading = true
            loading?.start()
            viewModel?.fetchData(reload: reload) {
                [weak self]
                result in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.loading?.stop()
                    self.isLoading = false
                    self.refreshControl.endRefreshing()
                    switch result {
                    case .success:
                        self.tableView.reloadData()
                    case .failure(let error):
                        self.showErrorMessage(message: error)
                    }
                }
            }
        }
    }
}

extension EntryListViewController: UITableViewDelegate, UITableViewDataSource {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if (offsetY > contentHeight - scrollView.frame.height * 4) && !isLoading {
            loadData(reload: false)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel?.getItemsCount() ?? 0
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            var cell: EntryListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EntryListTableViewCell
            if cell == nil {
                let cellNib = Bundle.main.loadNibNamed("EntryListTableViewCell", owner: self, options: nil)
                cell = cellNib?.first as! EntryListTableViewCell
            }
            let item = viewModel?.getItemByIndex(index: indexPath.row)
            cell.setData(title: item?.title, author: item?.author, thumbnail: item?.thumbnail, numComments: item?.num_comments, date: item?.created)
            cell.contentView.setNeedsLayout()
            cell.contentView.layoutIfNeeded()
            return cell
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "loadingCell", for: indexPath) as? LoadingTableViewCell {
                cell.activity.startAnimating()
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel?.getItemByIndex(index: indexPath.row)
        coordinator?.entriesDetails(item: item)
    }
}
