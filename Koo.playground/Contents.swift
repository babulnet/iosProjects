import UIKit
import PlaygroundSupport
import Foundation
import Combine

PlaygroundPage.current.needsIndefiniteExecution = true

var greeting = "Hello, playground"

class AsyncOperation: Operation {
    enum State: String {
        case isReady
        case isExecuting
        case isFinished
    }
    
    var state: State = .isReady {
        willSet (newValue) {
            willChangeValue(forKey: state.rawValue)
            willChangeValue(forKey: newValue.rawValue)
        }
        didSet {
            didChangeValue(forKey: oldValue.rawValue)
            didChangeValue (forKey: state.rawValue)
        }
    }
    
    override var isAsynchronous: Bool { true }
    override var isExecuting: Bool { state == .isExecuting }
    override var isFinished: Bool {
        if isCancelled && state != .isExecuting {return true}
        return state == .isFinished
    }
    
    override func start() {
        guard !isCancelled else {
            state = .isFinished
            return
        }
        state = .isExecuting
        main()
    }
    override func cancel () {
        state = .isFinished
    }
}


class Man {
    var height: Int = 0
}

//class CustomDispatchGroup {
//    let lock = NSLock()
//    private var count = 0
//    private var leaveCount = 0
//    private  var completion: (()->())? = nil
//    private var man = Man()
//
//     func enter() {
//       // lock.lock()
//        print("count before", count)
//        man.height += 1
//        print(count)
//        //lock.unlock()
//    }
//
//     func leave() {
//      //  lock.lock()
//        man.height -= 1
//
//        if man.height == 0 {
//            guard let completion = completion else {return}
//            completion()
//        }
//       // lock.unlock()
//    }
//
//    func notify(_ done : @escaping()->()) {
//        completion = done
//    }
//}


//var cc = CustomDispatchGroup()

//cc.notify {
//    print("Done")
//}

//cc.enter()
//cc.enter()
//cc.enter()
//cc.enter()
//
//cc.leave()
//cc.leave()
//cc.leave()
//cc.leave()

//DispatchQueue.concurrentPerform(iterations: 4) { val in
//    print("queue - ", val)
//    cc.enter()
//}
//
//DispatchQueue.concurrentPerform(iterations: 4) { _ in
//    cc.leave()
//}






// CustomNotificationCentre

class MyNotificationCentre {

    class Observer {
        var name: String = ""
        var completion: ([String:Any])->()

        init(name:String, completion:@escaping ([String:Any])->()) {
            self.name = name
            self.completion = completion
        }
    }

    class Notification {
        var name: String = ""
    }

    static let shared = MyNotificationCentre()

    var observerdictionary: [String:[Observer]] = [:]

    func addObserver(object: AnyObject, name: String, completion:@escaping ([String:Any])->()) {

        let className = String(describing: type(of: object))

        let newObserver = Observer(name: className, completion: completion)

        if let _ = observerdictionary[name] {
            observerdictionary[name]?.append(newObserver)
        } else {
            observerdictionary[name] = [newObserver]
        }
    }

    func post(name: String, info:[String:Any]) {
        if let observers = observerdictionary[name] {
            for item in observers {
                item.completion(info)
            }
        }
    }
    
    func remove(_ object: AnyObject, notificationName: String? = nil) {
        
        let className = String(describing: type(of: object))
        print("removing\(className)")
        print("dic before\(observerdictionary)")


        if let notificationName = notificationName {
            observerdictionary[notificationName]?.removeAll(where: { observer in
                observer.name == className
            })
        } else {
            observerdictionary =  observerdictionary.filter { item in
                item.value.contains { observer in
                    observer.name != className
                }
            }
        }
        
        print("after")
        print(observerdictionary)
    }
}
//
//class CheckNoti {
//    
//}
//class CheckNoti1 {
//    
//}
//
//class CheckNoti2 {
//    
//}
//
//MyNotificationCentre.shared.addObserver(object: CheckNoti(), name: "Notification1") { dic in
//    print(dic)
//}
//
//MyNotificationCentre.shared.addObserver(object: CheckNoti(), name: "Notification2") { dic in
//    print(dic)
//}
//
//MyNotificationCentre.shared.addObserver(object: CheckNoti(), name: "Notification3") { dic in
//    print(dic)
//}
//
//
//
//MyNotificationCentre.shared.addObserver(object: CheckNoti1(), name: "Notification1") { dic in
//    print(dic)
//}
//
//
//
//MyNotificationCentre.shared.addObserver(object: CheckNoti1(), name: "Notification2") { dic in
//    print(dic)
//}
//
//
//MyNotificationCentre.shared.post(name: "Notification1", info: ["Notification1":"Babul"])
//MyNotificationCentre.shared.post(name: "Notification2", info: ["Notification2":"Achu"])
//MyNotificationCentre.shared.post(name: "Notification3", info: ["Notification3":"Nithin"])
//
//MyNotificationCentre.shared.remove(CheckNoti())



//Concurrency
class Concrrency {
    var currentOnGoingWorkItem: DispatchWorkItem?
    func checkConcurrency() {
        // This means the block of code is dispatched asyncronously from the main Queue. Main wueue is a serial queue. async means it won't block the queue its dispatched from.
       
        var counter = 1
        DispatchQueue.main.async {
            for i in (0...3) {
                counter = i
                print(i)
            }
        }
        
        
        for i in (4...6) {
            counter = i
            print(i)
        }
        
        // In all the Queues(Serial/Concurrent) tasks will be initiated serially [FIFO], but in case concurrent queus                         multiple tasks can be excecuted at the same time.
        
        DispatchQueue.main.async {
            counter = 9
            print(counter)
            
        }
    }
    
    func GlobalQueueNotUsingMainThread() {
        DispatchQueue.main.async {
            Thread.isMainThread ? print("Main Queue using main Thread") : print("Main Queue Not using main Thread")
        }
        
        DispatchQueue.global().async {
            Thread.isMainThread ? print("Global queue using main Thread") : print("Global queue Not using main Thread")
        }
    }
    
    func checkingThePriority() {
        
        DispatchQueue.global(qos: .background).async {
            for i in (0...10) {
                print(i)
            }
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            for i in (11...20) {
                print(i)
            }
        } // User initiated block prints first than background
    }
    
    func checkCustomQueuesAndTargetQueues() {
        let cc1 = DispatchQueue(label: "cc1")
        let cc2 = DispatchQueue(label: "cc2",attributes: .concurrent,target: cc1) // if the target is cc1 which is a serial queue, printing will happen from 0 to 20 in order
        cc1.async {
            for i in (0...5) {
                print(i)
            }
        }
        
        cc1.async {
            for i in (6...10) {
                print(i)
            }
        }
        
        cc2.async {
            for i in (11...15) {
                print(i)
            }
        }
        
        cc2.async {
            for i in (16...20) {
                print(i)
            }
        }
    }
    
    func checkInitiallyInactive() {
        let cc1 = DispatchQueue(label: "cc1")
       // let cc2 = DispatchQueue(label: "cc2",attributes: .concurrent)
       // cc2.setTarget(queue: cc1) // you cannot set target to an already activated queue, it will crach
        
        // Instead do like below
        let cc2 = DispatchQueue(label: "cc2",attributes: [.concurrent,.initiallyInactive])
        cc2.setTarget(queue: cc1)
        cc2.async {
            print("Queue activated")
        }
        cc2.activate()
    }
    
    func checkQueueBehaviours() { //serial sync and async, concurrent sync and sync
        var value: Int = 20
        //let queue = DispatchQueue(label: "com.serial.babul")
        let queue = DispatchQueue(label: "com.serial.babul", attributes: .concurrent)

        queue.sync {
            if Thread.isMainThread {
                print("Task in on main thred")
            } else {
                print("Task is on OTHER thread")
            }
           
//            queue.sync {
//                for i in 10...20 {
//                    value = i
//                    print("\(value) 😁")
//                }
  //          }
            for i in (0...3) {
                let imageURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg")!

                let _ = try! Data(contentsOf: imageURL)
                print("\(i)  finished downloading")
            }
        }
        
        queue.async {
            for i in 0...3 {
                value = i
                print("\(value) 😁")
            }
        }
        
        print("Last line in playground 🍾")
     }
    
    
    // Dispatch Groups
    func dispatchGroups() {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        DispatchQueue.global().asyncAfter(deadline: .now()+2) {
            print("first api call done")
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        DispatchQueue.global().asyncAfter(deadline: .now()+4) {
            print("second api call done")
            dispatchGroup.leave()
        }
        
        print("Apis started")
        dispatchGroup.notify(queue: .main) {
            print("Api calls completed")
        }
    }
    
    func dispatchGroupsWait() {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        DispatchQueue.global().asyncAfter(deadline: .now()+2) {
            print("first api call done")
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        DispatchQueue.global().asyncAfter(deadline: .now()+4) {
            print("second api call done")
            dispatchGroup.leave()
        }
        
        print("Apis started")
        //dispatchGroup.wait()

        DispatchQueue.main.async {
            print("Api calls completed")
        }
//        dispatchGroup.notify(queue: .main) {
//            print("Api calls completed")
//        }
    }
    
    // Use case - two api calls, but we can ignore second one to go to next screen after waiting for 3 seconds, but we should know the second was failure or not
    func dispatchGroupsWaitNew() {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        DispatchQueue.global().asyncAfter(deadline: .now()+2) {
            print("first api call done")
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        DispatchQueue.global().asyncAfter(deadline: .now()+5) {
            print("second api call done")
            dispatchGroup.leave()
        }
        
        print("Apis started")
        let waitResult: DispatchTimeoutResult = dispatchGroup.wait(timeout: .now() + .seconds(3))

        DispatchQueue.main.async {
            switch waitResult {
            case .success:
                print("Api calls completed before time out") // you won't get this call back affter time out
            case .timedOut:
                print("Api time out")
            }
        }
    }
    
    func dispatchGroupsWorkItem() { // We can use work items to
        currentOnGoingWorkItem?.cancel() // We can use this like operations
        let workItem1: DispatchWorkItem = DispatchWorkItem {
            for i in (0...7).map({"\($0) printed"}) {
                print(i)
            }
        }
        
        currentOnGoingWorkItem = workItem1
        print("Printing started")
        DispatchQueue.global().async(execute: workItem1)

    }
    
    // Dispatch Barrier, Semaphore, Work Item Flags
    class DispatchBarrier {
        var cancellable: [AnyCancellable] = []
        var balance: Int = 60
        let purchaseQueu = DispatchQueue(label: "serial", attributes: .concurrent)
        let semaphore = DispatchSemaphore(value: 1)
       // let purchaseQueu = DispatchQueue(label: "serial")

        let buyQueue = DispatchQueue(label: "buy")
       
        func buttonClickedToBuy() {
            for item in ([("phone",40),("camera",30)]) {
                purchase1(item: item.0, price: item.1)
            }
        }
        
        func purchase(item: String, price: Int) {
            purchaseQueu.async(flags:.barrier) { [weak self] in
                self?.buyItem(item: item, price:price)
            }
        }
        
        func purchase1(item: String, price: Int) {
            purchaseQueu.async { [weak self] in
                self?.buyItemWithSemaphore(item: item, price:price)
            }
        }
        
        // *** if complier sees an asyn call, it won't wait for the async block completion to proceed to the next line and assumes that that job is completed. So thats why if there is an Async call inside a serial queue, serial queue won't excecute tasks one by one ***//
        
        private func buyItem(item: String, price: Int) {
            if balance > price {
                // Async task inside a parent serial queue won't make the parent queue serial
                let imageURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg")!
                
              //  DispatchQueue.main.async {
                    print(item," purchased started")
                    let _ = try! Data(contentsOf: imageURL)
                    print(item," purchased")
                    self.balance = (self.balance) - price
                    print("balnce is ", self.balance)
               // }
             
    //            URLSession.shared.dataTask(with: imageURL, completionHandler: { data, response, error in
    //                print(item," purchased")
    //                self.balance = (self.balance) - price
    //                print("balnce is ", self.balance)
    //            }).resume()
            
        } else {
                print("No balance")
            }
        }
        
        private func buyItemWithSemaphore(item: String, price: Int) {
            semaphore.wait()
            if balance > price {
                DispatchQueue.global().async { [weak self] in
                    print(item," purchased started")
                    let imageURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg")!
                    let _ = try! Data(contentsOf: imageURL)
                    print(item," purchased")
                    self?.balance = (self?.balance ?? -1000) - price
                    print("balnce is ", self?.balance ?? -1000)
                    self?.semaphore.signal()
                }
      
    //            print(item," purchased started")
    //            let session = URLSession.shared
    //            let imageURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg")!
    //
    //            session.dataTask(with: imageURL, completionHandler: { data, response, error in
    //                print(item," purchased")
    //                self.balance = (self.balance ?? -1000) - price
    //                print("balnce is ", self.balance ?? -1000)
    //                self.semaphores.signal()
    //              }).resume()
            } else {
                print("No balance")
            }
        }
    }
    
    class Operations {
        func doOperations1() { // Opearations are synchronous by default.
            print("operation about to start")
            startOoperation()
            print("operation ended") // it will be printed synchronously unless we explicetely start the operation on another queue
        }
        
        private func startOoperation() {
            let operation: BlockOperation = BlockOperation { // operation inside BlockOperations are excecuted concurrently
                sleep(3)
                print("is on main thread- ",Thread.isMainThread) //  BY DEFAULT ON MAIN THREAD
                print("operation 1") // last operation to be completed because of sleep it means not seriallly excecuted
            }
            
            operation.completionBlock = {
                print("operation completed")
            }
            
            operation.addExecutionBlock {
                for i in (0...3) {
                    print(i,"printed") // this will be printed synchronlusly
                }
            }
            
            operation.addExecutionBlock {
                print("operation 2")
            }
            
            operation.addExecutionBlock {
                print("operation 3")
            }
            //operation.start()
            DispatchQueue.global().async {
                operation.start() // moving it off the main thread and making it async
            }
            
        }
        
        func doOperations2() { // Opearations are synchronous by default.
            print("operation about to start")
            startCustomeOperation()
            print("operation ended") // it will be printed synchronously unless we explicetely start the operation on another queue
        }
        
        class CustomeOperation: Operation {
            
            override func main() {
                for i in (0...4) {
                    print(i,"custome operation printed")
                }
            }
        }
        
        private func startCustomeOperation () {
            let operation = CustomeOperation()
            operation.start()
        }
        
        func doOperations3() {
            print("operationQueue about to start")
            operationQueue() // Operation queues make excecution  of operations asynchronous,so that both print stamements will be printed immediate;y
            print("operationQueue ended")
        }
        
        private func operationQueue() {
            let queue = OperationQueue() // Operations are excecuted concurrently here
            //queue.maxConcurrentOperationCount = 1 - This makes the queue excecute operations serially(But each operation can excecute its blocks concurrently)
            
            let operation: BlockOperation = BlockOperation {
                for i in 0...4 {
                    print(i, "print in operation queue")
                }
            }
            
//            operation.addExecutionBlock {
//                for i in 5...9 {
//                    print(i, "print in operation queue")
//                }
//            }
            
            operation.completionBlock = {
                print("first operation completed in operation queue")
            }
            
            
            let operation1: BlockOperation =  BlockOperation {
                for i in (0...4) {
                    print(i, " second operation print in operation queue")
                }
            }
           
            operation1.completionBlock = {
                print("second operation completed in operation queue")
            }
            
           // operation1.addDependency(operation) // Now this will make the quque serial because operatio1 is dependant on opration, but completion blocks can get called after some delay
            queue.addOperation(operation)
            queue.addOperation(operation1)
        }
        
        // Explicitely making operations Asynchronous
        func doOperation4() { // to be done
           let operation1 = BlockOperation(block: printOnetoTen)
            let operation2 = BlockOperation(block: print11to20)
            let queue = OperationQueue()
            operation2.addDependency(operation1)
            queue.addOperation(operation1)
            queue.addOperation(operation2)
        }
        //Async call inside an operation -> When combile encouters and asyn call, it assumes that the operation is completed and mark the dependacy as resolved
        
        func doOperation5() {
            let operation1 = PrintOperation(range: 0..<11)
            let operation2 = PrintOperation(range: 11..<21)
            let queue = OperationQueue()
            operation2.addDependency(operation1)
            queue.addOperation(operation1)
            queue.addOperation(operation2)
        }
        
        private func printOnetoTen() {
            DispatchQueue.global().async { //if wrap it around an async Block, dependancy wont work and solution is to cretae a Custom Operation and manage states
                for i in 1...10 {
                    print(i)
                }
            }
        }
        
        private func print11to20() {
            DispatchQueue.global().async {
                for i in 11...20 {
                    print(i)
                }
            }
        }
    }
}

class PrintOperation: AsyncOperation {
    private var array: [Int]
   
     init(range: Range<Int>) {
        array = Array(range)
    }
    
    override func main() {
        DispatchQueue.global().async {
            for i in self.array {
                print(i)
            }
            
            self.state = .isFinished
        }
    }
}


//Concrrency().checkConcurrency() // prints 4,5,6,0,1,2,3,9
//Concrrency().checkingThePriority()
//Concrrency().checkCustomQueuesAndTargetQueues()
//Concrrency().checkInitiallyInactive()
//Concrrency().checkQueueBehaviours()
//Concrrency().dispatchGroups()
//Concrrency().dispatchGroupsWait()
//Concrrency().dispatchGroupsWaitNew()
//Concrrency().dispatchGroupsWorkItem()
//let purchaser = Concrrency.DispatchBarrier()
//purchaser.buttonClickedToBuy()
let operation = Concrrency.Operations()
operation.doOperation4()


//https://www.youtube.com/watch?v=X9H2M7xMi9E&list=PLSbpzz0GJp5RTrjum9gWTqPhM4L3Kop0S - Video
//DispathQueus
//1. Main Queue - serial, uses main thread, UIKit, System created
//2. Global concurrent queus - Concurrent, don't use main thread(99%), system provided, priority is decided by qos
//3. Custom Queues

// Quality of service - Helps system decide priority and helps utilising the resources effectively
//1.User Interactive - used when dealing with animation (Main thread is the recommeded way for any userinteractions though)
//2. user initiated - when needs immediate result - loading data while scrolling, use when data required for seamless user exp.
//3. Utiluty - Long running tasks, user is aware that downloading is happening, but not high prioity, user is aware if the download
//4.Background - not visible to the user, creating back up, restoring something from server
//5.default - btw user initiated and utility
//6.Unspecified - least

// CusomeQueue:
//let cc1 = DispatchQueue(label: <#T##String#>, qos: <#T##DispatchQoS#>, attributes: <#T##DispatchQueue.Attributes#>, autoreleaseFrequency: <#T##DispatchQueue.AutoreleaseFrequency#>, target: <#T##DispatchQueue?#>)
//label - name of the queue
//qOS - quality of service
//attributes - can be concurrent and initiallyInactive (serial if not specified) (we can make it initialy inactive and later activate)
//targetQueue - a target queue can be specified and the custom queue will inherit the chareceristics of the target Queue
//autoreleaseFrequency - .inherit(inherit autorelease pool from target Queue), .workItem(set up its own autorelease pool), .never(never set ups an autorelease pool)

// Video 3
// Dsipatch Groups
//1.functions - enter, leave,wait,notify
//wait - stops the excecution in the current thread and proceeds when all the tasks are completed in the diapatch group. Do not use wait on the main thread
// DispatchTaskItem - like operation in operationQueue, we can cancel it, but resume

//Video - 4
//Dispatch Barrrier, Semaphonres, DispatchSource - To listen to events triggered by the system, for running timer in background(timer needs current run loop)
//let queue = DispatchQueue.global().async(group: <#T##DispatchGroup?#>, qos: <#T##DispatchQoS#>, flags: <#T##DispatchWorkItemFlags#>, execute: <#T##() -> Void#>)

//Video - 5 OperationQueue
//Why operarionQueue when GCD is there - operation built on top of gcd, gcd TASK is not complicated, task states are not required, its ki d of fire and forget,less control,
//operation - interested in state of the task, dependacy between task, highest level of abstraction
//creating operation for trivial tasks is an overkill
//operation is an abstract class(needs to be subclassed to use)
//subclasses - Block operation, NSInvocationOperation(only in objective C)
//Operations are synchronous by default, hence we use OpearationQueues to add operations in to it which will take tasks off the main thread
//

//Serial and Concurrent - about the destination , Sync/Asyn - about the source the task is dispatched from

func TestQueues() {
    //let queue = DispatchQueue(label: "q1",attributes: .concurrent)
    let queue = DispatchQueue(label: "q1")
    let innerQueue = DispatchQueue(label: "q2")
    
    queue.async {
        //innerQueue.async {
            sleep(1)
            for i in 1...10 {
                print(10)
            }
        //}
      
    }
    
    //   queue.async {
    //       print(0)
    //       queue.async {
    //            for i in 1...4 {
    //               print(i)
    //           }
    //       }
    //
    //       queue.async {
    //          print(2)
    //           for i in 5...9 {
    //               print(i)
    //           }
    //       }
    //
    //    }
    
    queue.async {
        print(30)
    }
    
    queue.async {
        print(40)
    }
}

TestQueues()
func simpleTest() {
    
}


//1
class A {
    func method() {
        print("A -method1")
    }
}

extension A {
    func method2() {
        print("B -method2")
    }
}

class B:A {
    override func method() {
        print("B -metthod1")
    }
    
//    override func method2() { cannnot override extentsion functions
//        print("B -metthod2")
//    }
}

//2 Dead lock - same queue sync within async
//let q = DispatchQueue(label: "q")
//q.async {
//    q.sync {
//        print("A")
//    }
//    print("B")
//}


//3

//struct IntStack {
//    var array: [Int] = []
//
//    mutating func add(_ item: Int) { // error here it its not mutating
//        array.append(item)
//    }
//}
//
//var a = IntStack() // error here if ites let
//a.add(5)
//print(a.array.count)

//4

//let a:UInt
//let ee: Char // char gives error
//let cc2: Double
//let ff: Optional<Int>


//5

class Panda {
    func setUpGrass(_ grass: Grass?) {
        grass?.closure = {
            self.run()
        }
    }
    
    func run() {
        print("run")
    }
    
    deinit {
        print("hellow")
    }
}

class Grass {
    var closure: (()->(Void))?
    deinit {
        print("world")
    }
}

var panda: Panda? = Panda()
var grass: Grass? = Grass()
panda?.setUpGrass(grass)
//grass?.closure!() run will print only if we call the closure
panda = nil
grass = nil // prints world hello

//6

let numbers = [[1,2,3],[4,5,6],[7,8,9]]
numbers.flatMap { $0}

print(numbers)
print(Array(numbers.joined())) // [1,2,3,4,5,6,7,8,9]


//7

class Author {
    var book: Book?
}

class Book {
    var numberOfPages = 100
}

let john = Author()
john.book = Book()
var pages:Int = john.book!.numberOfPages
print(pages)
john.book = nil
//pages = john.book?.numberOfPages // compilor error Int? cannnot be assigned to Int
print(pages)

//8

protocol Vehicle {
    var name : String {get set}
}

struct Car: Vehicle {
    var name: String
}

var car: Vehicle = Car(name: "bmw")
print(car.name)
var anotherCar = car
anotherCar.name = "Audi" // error as name is get only
//print(anotherCar.name)


let str1 = "flower"
let str2 = "flowlessr"


let ans = str1.filter { char in
    str2.contains(char)
}

ans

