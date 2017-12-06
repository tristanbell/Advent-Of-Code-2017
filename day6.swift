let input = [11, 11, 13, 7, 0, 15, 5, 5, 4, 4, 1, 1, 7, 1, 15, 11]

var states: [[Int]] = [input]

func isDuplicate(state: [Int]) -> (result: Bool, loopSize: Int)
{
    var result = false
    var loopSize = 0
    
    for i in 0..<states.count - 1
    {
        let oldState = states[i]
        var isEqual = true
        for i in 0..<oldState.count
        {
            if oldState[i] != state[i]
            {
                isEqual = false
                break
            }
        }
        
        if isEqual
        {
            result = true
            loopSize = (states.count - 1) - i
            break
        }
    }
    
    return (result, loopSize)
}

func findMax(_ array: [Int]) -> (value: Int, index: Int)
{
    var index = 0
    var maxVal = -1
    
    for i in 0..<array.count
    {
        if array[i] > maxVal
        {
            maxVal = array[i]
            index = i
        }
    }
    
    return (maxVal, index)
}

var numCycles = 0
while true
{
    var currentState = states.last!
    let maxData = findMax(currentState)
    currentState[maxData.index] = 0
    
    var currentIndex = (maxData.index + 1) % currentState.count
    for i in 0..<maxData.value
    {
        currentState[currentIndex] += 1
        
        currentIndex = (currentIndex + 1) % currentState.count
    }
    
    states.append(currentState)
    
    numCycles += 1
    
    let duplicateData = isDuplicate(state: currentState)
    if duplicateData.result
    {
        print("\(numCycles), \(duplicateData.loopSize)")
        break
    }
}
