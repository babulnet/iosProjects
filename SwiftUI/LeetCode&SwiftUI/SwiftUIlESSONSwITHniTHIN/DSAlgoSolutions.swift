//
//  DSAlgoSolutions.swift
//  SwiftUIlESSONSwITHniTHIN
//
//  Created by Babul Raj on 15/06/22.
//


// Roman Letters & Linked list Pali
import Foundation

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

class LL {
    var head: ListNode
    
    init(array: [Int]) {
        self.head = ListNode(array[0])
        var prev: ListNode = head
        
        for i in (1..<array.count) {
            let node = ListNode(array[i])
            prev.next = node
            prev = node
        }
        
        if (DSALgoSolutions().checkLinkedListPaliWithRecursion(head: self.head)) {
            print("Its paliiiiiii")
        }
    }
}

class DSALgoSolutions {
    let dic1: [String:Int] = ["IV":4,"IX":9,"XL":40,"XC":90,"CD":400,"CM":900]
   
    func romanToNumber(input: String) -> Int {
        print("*********************************************************************")
        let dic: [Character:Int] = ["I":1,"V":5,"X":10,"L":50,"C":100,"D":500,"M":1000]
        
        
        var sum = 0
        var skip = false

        for (index, item) in input.enumerated() {
            var currentSum = 0
            
            if skip {
                skip = false
                continue
            }

            if "ICX".contains(item) && (index+1 < input.count ) && getPattern(input: input, index: index) != nil {
                let next = input[index+1] ?? ""
                let thisString = String(item)
                currentSum = dic1[thisString+next] ?? 0
                sum = sum + currentSum
                skip = true
            } else {
                currentSum = dic[item] ?? 0
                skip = false
            }
     
            sum = sum + currentSum
        }
       
        return sum
    }
    
    func getPattern(input: String, index: Int) -> Int? {
        let next = input[index+1] ?? ""
        let thisString = input[index] ?? ""
        return  dic1[thisString+next]
    }
    
    
    func checkLinkedListPali(head: ListNode?) -> Bool {
        var current = head
        var itemArray: [Int] = []
        
        while current != nil {
            itemArray.append(current?.val ?? 0)
            current = current?.next
        }
        
       
        for (index,item) in itemArray.enumerated() {
            if index > (itemArray.count/2) - 1 {
                break
            }
            
            if item != itemArray[(itemArray.count - 1) - index] {
                return false
            }
        }
        
        return true
    }
    
    func checkLinkedListPaliWithRecursion(head: ListNode?) -> Bool {
        guard let head = head else {return false}
        firstNode = head
        return recursivelyDoStuff(node: head)
    }
    
    //
    // Input 1,2,3,4,5,6
    func recursivelyDoStuff(node: ListNode?) -> Bool {
        guard let node = node else {
            return true
        }
        print(node.val,0) //1,2,3,4,5,6
        if !recursivelyDoStuff(node: node.next) { // If next is Not fine return False. It will go to the next statement when 6 retuns true from line 113 for the last item. So after thi, first printing item is 6. If any func returns false, then the whole thig is going to be false
            return false
        }
        //  != changed to == to show the printing reversal after the recursive call
        if (node.val == (firstNode?.val) ?? 0) {
            return false // if this is false for any Node, control will go to line 117 of prev function and from that fucn onwards it will never go beyond 117, the whole thing will be false
        }
        print(node.val)//6,5,4,3,2,1
        firstNode = firstNode?.next
        
        return true
    }
    var firstNode: ListNode?
}


public extension String {
     subscript(_ value: Int) -> String? {
        guard value < self.count else {return nil}
        let stringindex = self.index(self.startIndex, offsetBy: value)
        let char = self[stringindex]
        
        return String(char)
    }
}
