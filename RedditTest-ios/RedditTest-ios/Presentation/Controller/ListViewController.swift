//
//  ViewController.swift
//  RedditTest-ios
//
//  Created by Stefan V. de Moraes on 19/09/21.
//

import UIKit

class ListViewController: BaseViewController {

    @IBOutlet private(set) weak var listTitleLabel: UILabel?
    
    @IBOutlet private(set) weak var paginableTableView: PaginableTableView?
    
    private(set) var viewModel: ListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        self.view.backgroundColor = .redditBlue
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setupViewModel() {
        viewModel = ListViewModel(view: paginableTableView ?? UIView())
        viewModel?.delegate = self
        viewModel?.setAction(backToWelcome)
        self.listTitleLabel?.text = viewModel?.title
        self.listTitleLabel?.insertLine(width: 1.0, color: .redditOrange)
    }
    
    private func setupTableView(){
        paginableTableView?.paginableDataSource = self
        paginableTableView?.paginableDelegate = self
        paginableTableView?.alwaysBounceVertical = true
        paginableTableView?.autoresizingMask = UIView.AutoresizingMask.flexibleHeight
        paginableTableView?.backgroundColor = .clear
        paginableTableView?.separatorStyle = .singleLine
        paginableTableView?.tintColor = .redditGray
        paginableTableView?.enablePullToRefresh = true
        paginableTableView?.loadData(refresh: true)
        paginableTableView?.tableFooterView = UIView()
    }
    
    @objc
    func backToWelcome() {
        coordinator?.go?(to: .welcome)
    }
}

extension ListViewController: PaginableTableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let list = viewModel?.listChildren
        
        return list?.count ?? Int.zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let list = viewModel?.listChildren
        let item = list?[index]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: AppIdentifiers.redditListTableViewCell, for: indexPath) as? RedditListTableViewCell {
            cell.tag = indexPath.row
            
            if let data = item?.data {
                cell.setup(with: data)
            }
        
            return cell
        }
        
        return UITableViewCell()
    }
}

extension ListViewController: PaginableTableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let heightForRow: CGFloat = 86.0
        
        return heightForRow
    }
    
    func loadMore(_ pageSize: Int, onSuccess: ((Bool) -> Void)?, onError: ((Error) -> Void)?) {
        let count = viewModel?.listChildren?.count ?? Int.zero
        let params = RedditRequest(after: viewModel?.after, before: nil,
                                   count: String(count), limit: String(pageSize))
        
        viewModel?.fetchEntries(params: params, completion: { [paginableTableView] in
            DispatchQueue.main.async {
                
                onSuccess?(self.viewModel?.hasMore ?? true)
                onError?(RedditError.reloadError)
                
                paginableTableView?.reloadData()
            }
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let listCoordinator = coordinator as? ListCoordinator else { return }
        listCoordinator.entryData = prepareDetails(for: indexPath)
        listCoordinator.go(to: .details)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let heightForRow: CGFloat = 86.0
        
        return heightForRow
    }
}

extension ListViewController: ListViewModelDelegate {
    
    
    func prepareDetails(for index: IndexPath) -> RedditEntryData {
        let list = viewModel?.listChildren
        let item = list?[index.row]
        
        let entry = RedditEntryData(title: item?.data?.title,
                                    author: item?.data?.author,
                                    thumbnail: item?.data?.thumbnail,
                                    commentsNumber: item?.data?.commentsNumber,
                                    created: item?.data?.created)
        
        return entry
    }
    
    
    func showError(error: RedditError) {
        let alertController = UIAlertController(title: "Error", message: error.rawValue, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Back", style: .cancel) { action in
            (self.viewModel?.action ?? { })()
        }
        
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
}
