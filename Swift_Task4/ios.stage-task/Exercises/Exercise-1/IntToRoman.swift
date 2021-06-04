import Foundation

public extension Int {
    
    var roman: String? {
        if self > 0 && self < 4000 {
            let thousandsRoman = ["", "M", "MM", "MMM"]
            let hundredsRoman = ["", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"]
            let tensRoman = ["", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"]
            let unitsRoman = ["", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"]
            
            let thousands = self/1000
            let hundreds = (self%1000)/100
            let tens = (self%100)/10
            let units = (self%10)
            
            return thousandsRoman[thousands] +
                hundredsRoman[hundreds] +
                tensRoman[tens] +
                unitsRoman[units]
        }
        
        return nil
    }
}
