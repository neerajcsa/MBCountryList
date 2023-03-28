//
//  ProvinceViewController.swift
//  MBCountryList
//
//  Created by Neeraj Pandey on 10/03/23.
//

import UIKit

class ProvinceViewController: UIViewController {

    private let tableView = UITableView()
    private let country : Country
    private var viewModel : ProvinceViewModel!
    
    init(country : Country) {
        self.country = country
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureViewController()
        configureTableView()
        viewModel = ProvinceViewModel(country: country)
        configureViewModel()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "\(country.countryName)"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 60
        tableView.register(ProvinceTableCell.self, forCellReuseIdentifier: ProvinceTableCell.reuseID)
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    private func configureViewModel() {
        showLoadingView()
        viewModel.fetchProvinceData()
        viewModel.completionSuccess = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if self.viewModel.arrProvinceList.isEmpty {
                    self.showEmptyStateView(with: "Province list is empty.", in: self.view)
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

}

extension ProvinceViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrProvinceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProvinceTableCell.reuseID) as! ProvinceTableCell
        
        let province = viewModel.arrProvinceList[indexPath.row]
        cell.set(province: province)
        
        return cell
    }
}
