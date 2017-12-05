// Part 1
func level(x: Int) -> (level: Int, lowerBound: Int, upperBound: Int)
{
    var f = Float(x)
    var s = f.squareRoot()
    s.round(.up)
    var upperSquare = Int(s)
    if(upperSquare % 2 == 0) { upperSquare += 1 }
    let result = upperSquare / 2
    let lower = (upperSquare - 2) * (upperSquare - 2)
    let upper = upperSquare * upperSquare
    
    return (result, lower, upper)
}

let input = [312051]
for i in input
{
    let levelData = level(x:i)
    let levelSize = levelData.upperBound - levelData.lowerBound
    let quadrantSize = levelSize / 4
    var closestPole = 0
    var closestPoleDist = 1000000;
    for j in 1...4
    {
        let pole = levelData.lowerBound + quadrantSize * j - quadrantSize / 2
        let poleDist = abs(i - pole)
        if poleDist < closestPoleDist
        {
            closestPole = pole
            closestPoleDist = poleDist
        }
    }
    let dist = levelData.level + closestPoleDist
    print("Input: \(i), dist: \(dist)")
}
