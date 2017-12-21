import Foundation

let input = "{{{},{},{{}}}}"

class Group : CustomStringConvertible
{
    var parent: Group? = nil
    var children: [Group] = []
    
    func add(child: Group)
    {
        child.parent = self
        children += [child]
    }
    
    var description: String
    {
        return "Num children: \(children.count)"
    }
}

var root = Group()

var currentGroup = root

for (index, char)in input.characters.enumerated()
{
    if char == "{"
    {
        var childGroup = Group()
        currentGroup.add(child: childGroup)
        print("added child")
        currentGroup = childGroup
    }
    else if char == "}"
    {
        if let parentGroup = currentGroup.parent
        {
            currentGroup = parentGroup
            print("finished child")
        }
    }
}

func getPrintString(_ group: Group) -> String
{
    if group.children.isEmpty
    {
        return "{}"
    }
    
    var output = group.parent != nil ? "{" : ""
    
    for child in group.children
    {
        output += getPrintString(child)
        
        if child !== group.children.last!
        {
            output += ","
        }
    }
    
    output += group.parent != nil ? "}" : ""
    
    return output
}

print(root)

print("in : \(input)")
print("out: \(getPrintString(root))")
