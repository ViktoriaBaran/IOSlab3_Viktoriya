import UIKit

//Модель даних
class Car {
    var model: String
    var mileage: String
    var engineType: String
    var transmission: String
    var conditionRating: Int
    var isInsured: Bool
    var lastServiceDate: String
    
    init(model: String, mileage: String, engineType: String, transmission: String, conditionRating: Int, isInsured: Bool, lastServiceDate: String) {
        self.model = model
        self.mileage = mileage
        self.engineType = engineType
        self.transmission = transmission
        self.conditionRating = conditionRating
        self.isInsured = isInsured
        self.lastServiceDate = lastServiceDate
    }
    
    func printInfo() {
        print("\n====================================")
        print("🚗 БОРТОВИЙ ЖУРНАЛ АВТОМОБІЛЯ:")
        print("Модель: \(model)")
        print("Пробіг: \(mileage) км")
        print("Коробка передач: \(transmission)")
        print("Двигун: \(engineType)")
        print("Оцінка стану: \(conditionRating)/10 ⭐")
        print("Страховка: \(isInsured ? "Активна ✅" : "Неактивна ❌")")
        print("Останнє ТО: \(lastServiceDate)")
        print("====================================\n")
    }
}

//Контролер екрану
class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    // IBOutlets
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var mileageTextField: UITextField!
    @IBOutlet weak var transmissionSegment: UISegmentedControl!
    @IBOutlet weak var enginePickerView: UIPickerView!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var conditionSlider: UISlider!
    @IBOutlet weak var insuranceSwitch: UISwitch!
    @IBOutlet weak var serviceDatePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!
    
    let engineOptions = ["1.5 dCi Дизель", "2.0 Бензин", "1.6 Бензин", "Електро", "Гібрид"]
    var selectedEngine: String = "1.5 dCi Дизель"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        enginePickerView.delegate = self
        enginePickerView.dataSource = self
        
        setupStyling()
    }

    // Програмне налаштування красивих стилів
    private func setupStyling() {
        // Закруглення кутів та рамка для картинки
        carImageView.layer.cornerRadius = 16
        carImageView.clipsToBounds = true
        carImageView.layer.borderWidth = 2
        carImageView.layer.borderColor = UIColor.systemBlue.cgColor
        
        // Стиль для поля введення
        mileageTextField.layer.cornerRadius = 8
        mileageTextField.clearButtonMode = .whileEditing
        
        // Початковий текст стану
        //conditionLabel.text = "Стан авто: \(Int(conditionSlider.value))/10 ⭐"
    }

    //Зміна значення слайдера
    //@IBAction func sliderValueChanged(_ sender: UISlider) {
        //let rating = Int(sender.value)
        //conditionLabel.text = "Стан авто: \(rating)/10 ⭐"
    //}

    //UIPickerView Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int { return 1 }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return engineOptions.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return engineOptions[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedEngine = engineOptions[row]
    }

    //Збереження даних
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        let mileage = mileageTextField.text?.isEmpty == false ? mileageTextField.text! : "185000"
        let transmission = transmissionSegment.selectedSegmentIndex == 0 ? "Механіка 🕹️" : "Автомат 🅰️"
        let rating = Int(conditionSlider.value)
        let isInsured = insuranceSwitch.isOn
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale(identifier: "uk_UA")
        let formattedDate = formatter.string(from: serviceDatePicker.date)
        
        let myCar = Car(
            model: "Renault Megane III",
            mileage: mileage,
            engineType: selectedEngine,
            transmission: transmission,
            conditionRating: rating,
            isInsured: isInsured,
            lastServiceDate: formattedDate
        )
        
        myCar.printInfo()
        
        // Анімація підтвердження кліку на кнопку
        UIView.animate(withDuration: 0.1, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                sender.transform = .identity
            }
        }
    }
}

