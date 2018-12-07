//
//  LocationViewController.swift
//  SADJZIOS
//
//  Created by Afshawn Lotfi on 12/7/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit




class LocationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ActionDelegate {
    
    let rest = RestInterfacer<Dictionary<String,Array<String>>,DonationItemModel>()

    
    func delete(donationItem: DonationItemModel) {
        
        
        if let tokenModel = TokenInterfacer.getToken(){
            rest.getRequest(endpoint: RestEndpoints.RemoveDonationItem, args: "atlanta/" + donationItem.locationId + "/" + donationItem.id, token: tokenModel.token){ response, error in
                if let resp = response {
                    DispatchQueue.main.async {
                        self.donationData.removeValue(forKey: donationItem.id)
                        self.updateDonTable();
                    }
                } else {
                    print(error ?? "")
                }
            }
        }
        
        
    }
    
    func edit(editedDonationItem: DonationItemModel) {
     
        if let tokenModel = TokenInterfacer.getToken(){
            rest.postRequest(endpoint: RestEndpoints.EditDonationItem, model : editedDonationItem, args:  "atlanta/" + editedDonationItem.locationId + "/" + editedDonationItem.id, token: tokenModel.token){ response, error in
                if let resp = response {
                    DispatchQueue.main.async {
                    self.donationData[editedDonationItem.id] = editedDonationItem;
                    self.updateDonTable()
                    }
                } else {
                    print(error ?? "")
                }
            }
        }
        
        
    }
    
    func add(newDonationItem: DonationItemModel) {
        self.navigationController?.popToRootViewController(animated: true)

        if let tokenModel = TokenInterfacer.getToken(){
            rest.postRequest(endpoint: RestEndpoints.AddDonationItem, model : newDonationItem, args: "atlanta/" + self.locationData["Id"]! , token: tokenModel.token){ response, error in
                if let resp = response {
                    self.donationData[resp["id"]?[0] ?? ""] = DonationItemModel(name: newDonationItem.name, description: newDonationItem.description, quantity: newDonationItem.quantity, category:newDonationItem.category, id: resp["id"]?[0] ?? "", time: "", locationId: self.locationData["Id"]! )
                    self.updateDonTable()
                    
                } else {
                    print(error ?? "")
                }
            }
        }
        
        
    }
    
    
    private func updateDonTable(){
        DispatchQueue.main.async {
            self.navigationController?.popToRootViewController(animated: true)
            self.donationItemsTable.reloadData()

        }
    }
    
    

    private let reusable = "aCell";
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{

        if (tableView.tag == 1){
            return self.locationData.count
        }else if (tableView.tag == 2){
            return self.donationData.count

        }else{
            return 0
        }

    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: self.reusable)
        
        
        if (tableView.tag == 1){

            let keys =  Array(self.locationData.keys)
            let title = keys[indexPath.row]
            cell.detailTextLabel?.text = self.locationData[title]
            cell.textLabel?.text = title
            
            
        }else if (tableView.tag == 2){

            let keys =  Array(self.donationData.keys)
            let id = keys[indexPath.row]
            cell.detailTextLabel?.text = String(self.donationData[id]?.quantity ?? 1)
            cell.textLabel?.text = self.donationData[id]?.name
            
            
        }

        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let keys =  Array(self.donationData.keys)
        let id = keys[indexPath.row]
        self.initializeDonationItemView(donAction: DonationItemAction.EDIT ,donationItem: self.donationData[id]!)

        
    }
    
    func initializeDonationItemView(donAction : DonationItemAction, donationItem : DonationItemModel){
        
        if let dIVC = storyboard?.instantiateViewController(withIdentifier: "DonationItemViewController") as? DonationItemViewController{
            self.navigationController?.pushViewController(dIVC, animated: true)
            dIVC.actionDelegate = self;
            dIVC.inititilizeView(action: donAction, donationItem: donationItem)
        }
        
    }
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        self.initializeDonationItemView(donAction: DonationItemAction.ADD , donationItem: DonationItemModel(name: "", description: "", quantity: 1, category: ItemCategory.Other, id: "", time: "", locationId: ""))
        
    }
    @IBAction func dismiss(_ sender: UIBarButtonItem) {
        self.navigationController?.dismiss(animated: true)
        
    }
    
    @IBOutlet weak var locationTable: UITableView!
    private var locationData:[String:String] = [String:String]()
    private var donationData:[String:DonationItemModel] = [String:DonationItemModel]()

    @IBOutlet weak var donationItemsTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.locationTable.tag = 1;
        self.donationItemsTable.tag = 2;
        
        self.locationTable.reloadData();
        self.donationItemsTable.reloadData();

        self.locationTable.delegate = self;
        self.donationItemsTable.delegate = self;
        self.locationTable.dataSource = self;
        self.donationItemsTable.dataSource = self;

    }
    
    
    func setLocation(locationModel: LocationModel){
        
        self.locationData["Address"] = locationModel.address;
        self.locationData["Type"] = locationModel.locationType;
        self.locationData["Id"] = locationModel.id;
        self.locationData["Name"] = locationModel.name;
        self.locationData["Phone"] = locationModel.phone;
        self.locationData["Website"] = locationModel.website;
        for donationItem in locationModel.donationItems{
            self.donationData[donationItem.id] = donationItem
        }

    
    }
    
    
}

