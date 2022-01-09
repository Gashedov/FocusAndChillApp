//
//  SettingsView.swift
//  FocOn
//
//  Created by Artem Gorshkov on 14.09.21.
//

import UIKit

class SettingsView: UIViewController {
    //MARK: - Properties
    private let titleLabel = UILabel()
    private let disableButton = UIButton()
    private let settingsTableView = ContentSizedTableView()

    var viewModel: SettingsViewModel? 

    //MARK: - Life cycle methods
    override func loadView() {
        view = UIView()

        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
        }

        view.addSubview(disableButton)
        disableButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalToSuperview().inset(10)
            $0.size.equalTo(40)
        }

        view.addSubview(settingsTableView)
        settingsTableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide)
        }
    }

    override func viewDidLoad() {
        setupUI()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Track.didShow(screen: .settings)
    }

    //MARK: - Private methods

    private func setupUI() {
        view.backgroundColor = .white
        settingsTableView.register(SettingsTableViewCell.self)
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
        settingsTableView.backgroundColor = .white
        settingsTableView.layer.cornerRadius = 10
        settingsTableView.rowHeight = 50

        disableButton.setImage(R.image.cross(), for: .normal)
        disableButton.tintColor = .lightGray

        titleLabel.text = "Menu"
        titleLabel.font = .systemFont(ofSize: 30, weight: .semibold)
        titleLabel.textAlignment = .left

    }

    private func bindViewModel() {
        disableButton.addTarget(self, action: #selector(disableView), for: .touchUpInside)
    }

    @objc func disableView() {
        dismiss(animated: true)
    }
}

//MARK:- UITableViewDataSource implementation
extension SettingsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.options.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let options = viewModel?.options,
              options.count > indexPath.row else { return UITableViewCell() }

        let option = options[indexPath.row]

        let cell: SettingsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setup(title: option.title)
        return cell
    }
}

//MARK:- UITableViewDelegate implementation
extension SettingsView: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.optionSelected(at: indexPath.row)
    }
}
