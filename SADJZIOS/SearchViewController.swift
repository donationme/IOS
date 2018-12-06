//
//  SearchViewController.swift
//  SADJZIOS
//
//  Created by Afshawn Lotfi on 12/6/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit


enum SearchStyle{
    case ALL
    case INDUVIDUAL
}

enum SearchBy{
    case NAME
    case CATEGORY
}


protocol SearchDelegate {
    func setLocationID(locationModel : LocationModel)
}


class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, SearchDelegate {

    
    @IBOutlet weak var pickDifferentLocationBtn: UIButton!
    @IBAction func pickDifferentLocation(_ sender: UIButton) {
        self.pickLocation()
        
        
    }
    private var searchStyle = SearchStyle.ALL
    private var searchBy = SearchBy.NAME
    private var currentQuery = ""
    private var currentLocationModel:LocationModel?
    private let items = ItemCategory.allCases;
    
    
    @IBOutlet weak var searchTypeLabel: UILabel!
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ItemCategory.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return String(reflecting:self.items[row]).components(separatedBy: ".").last
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.currentQuery =  String(reflecting:self.items[row]).components(separatedBy: ".").last!
        self.searchCategory()
        
        
    }
    
    private func searchCategory(){
    
        if (self.searchStyle == SearchStyle.ALL){
    
            if let tokenModel = TokenInterfacer.getToken(){
                rest.getRequest(endpoint: RestEndpoints.SearchAllCategory, args: "atlanta/" + self.currentQuery, token: tokenModel.token){ response, error in
                    if let searchModel = response {
                        self.displayResults(results: searchModel.results)
                    } else {
                        print(error ?? "")
                    }
                }
            }
        
        
        }else{
        
            
                if let tokenModel = TokenInterfacer.getToken(){
                        rest.getRequest(endpoint: RestEndpoints.SearchSpecificCategory, args: "atlanta/" + (self.currentLocationModel?.id)! + "/" + self.currentQuery, token: tokenModel.token){ response, error in
                        if let searchModel = response {
                            self.displayResults(results: searchModel.results)
                        } else {
                            print(error ?? "")
                    }
                }
            }
        
        }
    
    }
    
    private func searchName(){
        
        if (self.searchStyle == SearchStyle.ALL){
            
            
            
            if let tokenModel = TokenInterfacer.getToken(){
                rest.getRequest(endpoint: RestEndpoints.SearchAllName, args: "atlanta/" + self.currentQuery, token: tokenModel.token){ response, error in
                    if let searchModel = response {
                        self.displayResults(results: searchModel.results)
                    } else {
                        print(error ?? "")
                    }
                }
            }
            
            
            
        }else{
            
            if let tokenModel = TokenInterfacer.getToken(){
                rest.getRequest(endpoint: RestEndpoints.SearchSpecificName, args: "atlanta/" + (self.currentLocationModel?.id)! + "/" + self.currentQuery, token: tokenModel.token){ response, error in
                    if let searchModel = response {
                        self.displayResults(results: searchModel.results)
                    } else {
                        print(error ?? "")
                    }
                }
            }
            
        }

        
        
        
    }
    
    
    @IBOutlet weak var searchText: UITextField!
    
    
    @IBAction func onSearch(_ sender: UITextField) {

        
        self.currentQuery = sender.text!
        self.searchName()
        
    }
    
    private func displayResults(results : [DonationItemModel]){
        DispatchQueue.main.async {
            self.searchData = [String:DonationItemModel]()
            for result in results{
                self.searchData[result.id] = result
            }
            self.tableView.reloadData()
        }

    }
    
    
    @IBAction func nameCatAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.searchBy = SearchBy.NAME
            categoryPicker.isHidden = true
            searchText.isHidden = false
            
            break;
        case 1:
            self.searchBy = SearchBy.CATEGORY
            categoryPicker.isHidden = false
            searchText.isHidden = true
            break;
        default:
            break;
        }
        
        
    }
    
    @IBAction func allIndAction(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            self.searchStyle = SearchStyle.ALL
            self.searchTypeLabel.text = "Searching All"
            self.pickDifferentLocationBtn.isHidden = true

            break;
        case 1:
            
            self.searchStyle = SearchStyle.INDUVIDUAL
            self.pickDifferentLocationBtn.isHidden = false

            self.pickLocation()
            
            
            break;
        default:
            break;
        }
        
        
    }
    @IBOutlet weak var tableView: UITableView!
    
    
    func pickLocation(){
        if let sonationCenterVC = storyboard?.instantiateViewController(withIdentifier: "DonationCenterViewController") as? DonationCenterViewController{
            self.present(sonationCenterVC, animated: true)
            sonationCenterVC.searchAfterChoose()
            sonationCenterVC.searchDelegate = self
            
        }
    }
    
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    private var searchData : [String:DonationItemModel] = [String:DonationItemModel]()
    
    private let rest = RestInterfacer<SearchModel,String>()

    private let reusable = "cCell";
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return searchData.count;
    }
    
    
    func setLocationID(locationModel : LocationModel){
        self.currentLocationModel = locationModel
        self.searchTypeLabel.text = "Searching " + locationModel.name
        if (self.searchBy == SearchBy.NAME){
            self.searchName()
        }else{
            self.searchCategory()

        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: self.reusable)

        let keys =  Array(searchData.keys)
        if (keys.count - 1 >= indexPath.row){
            let id = keys[indexPath.row]
            cell.detailTextLabel?.text = String(self.searchData[id]?.quantity ?? 0)
            cell.textLabel?.text = self.searchData[id]?.name
        }
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.reusable)
        tableView.delegate = self
        tableView.dataSource = self
        self.categoryPicker.dataSource = self
        self.categoryPicker.delegate = self
        categoryPicker.isHidden = true
        self.pickDifferentLocationBtn.isHidden = true
        
    }
    
    
}


