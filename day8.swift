import Foundation

//let input = ["b inc 5 if a > 1", "a inc 1 if b < 5", "c dec -10 if a >= 1", "c inc -20 if c == 10"]

let operators: [String : (Int32, Int32) -> Bool] = 
[
    "==": (==),
    "!-": (!=),
    ">": (>),
    ">=": (>=),
    "<": (<),
    "<=": (<=)
]

let instructions: [String: (inout Int32, Int32) -> Void] = 
[
    "inc": (+=),
    "dec": (-=)
]

let whitespaceAndPunctuationSet = CharacterSet(charactersIn: " (),")

var registers: [String : Int32] = [:]

func getReg(_ index: String, defaultVal: Int32) -> Int32
{
    if let value = registers[index]
    {
        return value
    }
    else
    {
        registers[index] = defaultVal
        return registers[index]!
    }
}

for line in input
{
    var stringScanner = Scanner(string: line)
    stringScanner.charactersToBeSkipped = whitespaceAndPunctuationSet
    
    let regName = stringScanner.scanUpToCharactersFromSet(whitespaceAndPunctuationSet)!
    
    let opName = stringScanner.scanUpToCharactersFromSet(whitespaceAndPunctuationSet)!
    
    let num = stringScanner.scanInt()!
    
    // "if"
    stringScanner.scanUpToCharactersFromSet(whitespaceAndPunctuationSet)
    
    let condReg = stringScanner.scanUpToCharactersFromSet(whitespaceAndPunctuationSet)!
    
    let condOpName = stringScanner.scanUpToCharactersFromSet(whitespaceAndPunctuationSet)!
    
    let condVal = stringScanner.scanInt()!
    
    let condOp = operators[condOpName]!
    if(condOp(getReg(condReg, defaultVal: 0), condVal))
    {
        let op = instructions[opName]!
        if var value = registers[regName]
        {
            op(&registers[regName]!, num)
        }
        else
        {
            registers[regName] = 0
            op(&registers[regName]!, num)
        }
    }
}

//print(registers)
print(registers.values.max()!)
