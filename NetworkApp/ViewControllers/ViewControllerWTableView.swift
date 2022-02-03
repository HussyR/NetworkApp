//
//  ViewController.swift
//  NetworkApp
//
//  Created by Данил on 02.02.2022.
//

import UIKit

class ViewControllerWTableView: UIViewController {
    // URL для получения страницы + номер страницы добавить
    let pageUrl = "https://rickandmortyapi.com/api/character/?page="
    let maxPages = 20
    let cellID = "cellID"
    
    var isLoaded = true
    
    
    var characterPages = [CharacterPage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupData()
    }
    
    private func setupData() {
        NetworkManager.fetchPage(url: pageUrl + "1") { [weak self] page in
            guard let self = self else {return}
            self.characterPages.append(page)
            DispatchQueue.main.async {
                self.isLoaded = false
                self.tableView.reloadData()
            }
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.fillSuperView(with: 0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RickAndMortyTableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    let tableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 128
        return tableView
    }()
}
//MARK: DataSource and Delegate
extension ViewControllerWTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! RickAndMortyTableViewCell
        cell.cellModel = characterPages[indexPath.row / 20].results[indexPath.row % 20]
        cell.configureCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = characterPages.flatMap { $0.results }.count
        return count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    
}
//MARK: Pagination
extension ViewControllerWTableView: UIScrollViewDelegate {
    
    
    // Будет появляться при прокрутке вниз и ожидании подгрузки данных
    private func createSpinnerFooter () -> UIView {
        let footview = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 150))
        let spinner = UIActivityIndicatorView()
        spinner.startAnimating()
        spinner.color = .black
        spinner.center = footview.center
        footview.addSubview(spinner)
        return footview
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        view.endEditing(true)
        let position = scrollView.contentOffset.y + scrollView.frame.size.height
        // scrollView.contentOffset.y отвечает за длину прокрученного контента
//        if (!isLoaded && !isSearch) {
//            guard pages.count < maxPagesCount else {return}
//            if (position > scrollView.contentSize.height) {
//                print("load data")
//                tableView.tableFooterView = createSpinnerFooter()
//                isLoaded = true
//                NetworlManager.fetchDataRickAndMorty(url: url + String(pages.count + 1)) { page in
//                    self.pages.append(page)
//                    self.characters += page.results
//                    DispatchQueue.main.async {
//                        self.tableView.reloadData()
//                        self.tableView.tableFooterView = nil
//                        self.isLoaded = false
//                    }
//                }
//            }
//        }
        if (!isLoaded) {
            guard characterPages.count < maxPages else {return}
            if (position > scrollView.contentSize.height + 20) {
                print("load data")
                tableView.tableFooterView = createSpinnerFooter()
                isLoaded = true
                let loadedPage = String(characterPages.count + 1)
                NetworkManager.fetchPage(url: pageUrl + loadedPage) { [weak self] page in
                    guard let self = self else {return}
                    self.characterPages.append(page)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.tableView.tableFooterView = nil
                        self.isLoaded = false
                    }
                }
            }
        }
        
    }
}
