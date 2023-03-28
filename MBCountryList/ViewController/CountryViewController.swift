//
//  CountryViewController.swift
//  MBCountryList
//
//  Created by Neeraj Pandey on 10/03/23.
//

import UIKit

class CountryViewController: UIViewController {
    
    private let tableView = UITableView()
    private var viewModel = CountryViewModel()
    private var refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        configureTableView()
        configureViewModel()
        addRefreshControl()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Country"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 100
        tableView.register(CountryTableCell.self, forCellReuseIdentifier: CountryTableCell.reuseID)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    private func addRefreshControl() {
        self.tableView.refreshControl = refreshControl
        self.refreshControl.addTarget(self, action: #selector(refreshCountryData(_:)), for: .valueChanged)
    }
    
    private func configureViewModel() {
        showLoadingView()
        viewModel.fetchCountryData()
        viewModel.completionSuccess = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if self.viewModel.arrCountryList.isEmpty {
                    self.showEmptyStateView(with: "Country list is empty.", in: self.view)
                    self.tableView.isHidden = true
                } else {
                    self.tableView.isHidden = false
                    self.tableView.reloadData()
                }
                self.dismissLoadingView()
            }
        }
        viewModel.completionError = { [weak self] (error) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.isHidden = true
                self.dismissLoadingView()
                self.displayErrorController("Error", error.rawValue)
            }
        }
    }
        
    private func displayErrorController(_ title : String, _ error : String) {
        let alertController = UIAlertController(title: title, message: error, preferredStyle: .alert)
        let retry = UIAlertAction(title: "Retry", style: .default) { (_) in
            self.configureViewModel()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(retry)
        alertController.addAction(cancel)
        self.present(alertController, animated: true)
    }
    
    @objc private func refreshCountryData(_ sender: Any) {
        self.configureViewModel()
        self.refreshControl.endRefreshing()
    }
}

extension CountryViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.arrCountryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableCell.reuseID) as! CountryTableCell
        
        let country = viewModel.arrCountryList[indexPath.row]
        cell.set(country: country)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = viewModel.arrCountryList[indexPath.row]
        let controller = createProvinceVC(country : country)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func createProvinceVC(country : Country) -> ProvinceViewController {
        let provinceVC = ProvinceViewController(country: country)
        return provinceVC
    }
    
}
