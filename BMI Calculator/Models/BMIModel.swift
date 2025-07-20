
import UIKit

struct BMIModel {

    var bmi: BMI?

    func getBMIValue() -> String {
        let bmiValue = String(format: "%.1f", bmi?.value ?? 0.0)
        return bmiValue
    }

    mutating func calculateBMI(height: Float, weight: Float)  {
        let bmiValue = (weight / pow (height, 2))
        
        if bmiValue < 18.5 {
            bmi = BMI(value: bmiValue, advice: "Eat more pies", color: UIColor(hex: "#78D6F9"))
        } else if bmiValue < 24.9 {
            bmi = BMI(value: bmiValue, advice: "Fit as a fiddle!", color: UIColor(hex: "#B6E296"))
        } else {
            bmi = BMI(value: bmiValue, advice: "Eat less pies", color: UIColor(hex: "#E87AA3"))
        }
    }

    func getAdvice() -> String {
        return bmi?.advice ?? "No advice"
    }

    func getColor() -> UIColor {
        return bmi?.color ?? UIColor.white
    }
}
