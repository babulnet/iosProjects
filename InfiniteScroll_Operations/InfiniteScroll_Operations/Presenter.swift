//
//  Presenter.swift
//  InfiniteScroll_Operations
//
//  Created by Babul Raj on 04/11/22.
//

import Foundation
import UIKit

struct User:Codable,Equatable {
   
    var id: Int
    var avatar_url:String
    var login: String
    var image: UIImage? = nil
    
    private enum CodingKeys: String, CodingKey {
           case id,avatar_url,login
       }
    
    init(id:Int,avatar_url: String,login:String) {
        self.id = id
        self.avatar_url = avatar_url
        self.login = login
        self.image = nil
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
}

class Presenter: ObservableObject {
    @Published var users:[User] = []
    private var opDic: [Int:Operation] = [:]
    var operationDic: [Int:ImgaeDownload] = [:]
    let downloadQueue = OperationQueue()
    init() {
        //downloadQueue.maxConcurrentOperationCount = 5
    }
    
    func getData(index:Int) {
        let url = URL(string:"https://api.github.com/users?per_page=30&since=\(index+1)")!
        
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
      
            if let error = error {
                print(error)
            } else {
                do {
                    let data = try JSONDecoder().decode([User].self, from: data!)
                    DispatchQueue.main.async {
                        self.users.append(contentsOf: data)
                    }
                } catch {
                    print("error parsing")
                }
            }
            
        }.resume()
    }
    
    func getImage(index:Int) -> Bool? {
        print("called from view index = \(index)")
//        _ = opDic.map({ index,operation in
//            if index
//        })
        
        let operarion = ImgaeDownload(user: users[index])
        downloadQueue.addOperation(operarion)
        operarion.completionBlock = {
            DispatchQueue.main.async { [weak self] in
                print("Just finished = \(index)")
                self?.users[index].image = operarion.user?.image
            }
        }
        
        return true
    }
    
    func isItTrue(index: Int) -> Bool {
        print("called from view index = \(index)")
        return true
    }
    
    func shouldLoadData(id:Int) -> Bool {
        return (users.count - 3) == id
    }
}


struct ModelImgae {
    var image: UIImage
    var state: DownloadState = .notStarted
    
    enum DownloadState {
        case notStarted,started,inProgress,finished,cancelled
    }
}

class ImgaeDownload:AsyncOperation {
    var user: User?
    private var url: URL?
    
    init(user: User?) {
        self.user = user
        self.url = URL(string: user?.avatar_url ?? "")
    }
    
    override func main() {
        if isCancelled {
            return
        }
        
        guard let url = url else {
            return
        }
        
        do {
            if isCancelled {
                return
            }
            let data = try Data(contentsOf: url)
            if let image = UIImage(data: data) {
                self.user?.image = image
            }
        } catch {
            
        }
        
    }
}


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
