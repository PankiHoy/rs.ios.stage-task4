import Foundation

final class FillWithColor {
    
    func fillWithColor(_ image: [[Int]], _ row: Int, _ column: Int, _ newColor: Int) -> [[Int]] {
        if (image[row][column] == newColor) {
            return image
        }
        
        var final = image
        floodFill(&final, row, column, newColor, image[row][column])
        
        return final
    }
    
    //    [1, 1, 1]
    //    [0, 1, 1]
    //    [1, 1, 0]
    
    func floodFill(_ image: inout [[Int]], _ row: Int, _ column: Int, _ newColor: Int, _ previousColor: Int) {
        if (row < 0 || column < 0 || row >= image.count || column >= image[0].count || image[row][column] != previousColor) {
            return
        }
        image[row][column] = newColor
        
        floodFill(&image, row-1, column, newColor, previousColor)
        floodFill(&image, row+1, column, newColor, previousColor)
        floodFill(&image, row, column-1, newColor, previousColor)
        floodFill(&image, row, column+1, newColor, previousColor)
    }
}

