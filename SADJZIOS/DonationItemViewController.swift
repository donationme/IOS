//
//  DonationItemViewController.swift
//  SADJZIOS
//
//  Created by Afshawn Lotfi on 12/6/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//



import UIKit

enum DonationItemAction{
    case ADD
    case EDIT
}

protocol ActionDelegate {

    
    func delete(donationItem : DonationItemModel)
    func edit(editedDonationItem : DonationItemModel)
    func add(newDonationItem : DonationItemModel)

    
}




class DonationItemViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    private var donationItem:DonationItemModel?;
    private var action:DonationItemAction = DonationItemAction.EDIT;
    public var actionDelegate:ActionDelegate?;
    private var currentCategory = ItemCategory.allCases[0]
    private let items = ItemCategory.allCases;
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
        self.currentCategory =  self.items[row]
    }
    
    
    
    @IBAction func editAddItem(_ sender: UIButton) {

        if let aDelegate = self.actionDelegate{
            
            
            let donationItem = DonationItemModel(name: self.nameText.text ?? "", description: self.descripText.text ?? "", quantity: Int(self.quantityLabel?.text ?? "1") ?? 1, category: self.currentCategory, id: self.donationItem?.id ?? "", time: "2018-12-06T16:50:03.629Z", locationId: self.donationItem?.locationId ?? "")

            if (self.action == DonationItemAction.EDIT){
                aDelegate.edit(editedDonationItem: donationItem)
            }else{
                aDelegate.add(newDonationItem: donationItem)

            }

        }

        
    }
    
    @IBAction func deleteItem(_ sender: Any) {
        
        if let aDelegate = self.actionDelegate{
            if let donationItem = self.donationItem{
                aDelegate.delete(donationItem: donationItem)

            }
        }
        
    }
    
    
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var descripText: UITextField!
    
    @IBOutlet weak var quantityLabel: UILabel!
    
    @IBAction func increment(_ sender: UIStepper) {
        
        quantityLabel.text = String(format:"%i",  Int(sender.value))
        
    }
    
    @IBOutlet weak var quantityStepper: UIStepper!
    
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    
    @IBOutlet weak var editAddBtn: UIButton!
    

    @IBOutlet weak var deleteBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.categoryPicker.dataSource = self;
        self.categoryPicker.delegate = self;
        self.categoryPicker.reloadAllComponents()
        quantityStepper.minimumValue = 1
        quantityStepper.maximumValue = 1000
        quantityStepper.value = Double(self.donationItem?.quantity ?? 1)
        let userType = SessionInterfacer.getUser()?.userType
//        if (userType != UserType.Admin || userType != UserType.LocationEmployee || userType != UserType.Manager){
//            self.nameText.isEnabled = false;
//            self.descripText.isEnabled = false;
//            self.quantityStepper.isEnabled = false;
//            self.categoryPicker.isUserInteractionEnabled = false
//            self.editAddBtn.isEnabled = false
//            self.deleteBtn.isEnabled = false
//
//        }
        if (self.action == DonationItemAction.ADD){
            self.deleteBtn.isHidden = true;
            self.editAddBtn.setTitle("Add", for: .normal)
            
        }else{
            
            self.deleteBtn.isHidden = false;
            self.editAddBtn.setTitle("Edit", for: .normal)
            
            if let item = self.donationItem{
                self.nameText.text = item.name
                self.descripText.text = item.description
                self.quantityLabel.text = String(item.quantity)
                self.categoryPicker.reloadAllComponents()
                let index = item.category.rawValue
                self.categoryPicker.selectRow(index, inComponent: 0, animated: true)
            }
            
        }
        
    }
    
    func inititilizeView(action : DonationItemAction, donationItem : DonationItemModel?){

        self.action = action
        self.donationItem = donationItem
        
    }
    
    
    
    
}




