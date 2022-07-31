//
//  ForNormalPractice.swift
//  SwiftUIlESSONSwITHniTHIN
//
//  Created by Babul Raj on 18/06/22.
//

import SwiftUI
struct User {
    var name: String
    var age: Int
}

class Presenter: ViewModelProvider {
    private  var model: User
    var viewModel: MyViewModel = MyViewModel(firstString: "", secondString: "")
    
    init(model: User) {
        self.model = model
    }
    
    func transformDataToVM() -> MyViewModel {
       let vm =  MyViewModel(firstString: "", secondString: "")
        return vm
    }
    
    func getData() {
        //
    }
}

//***********************************////****************** View Layer

protocol ViewModelProvider: ObservableObject {
    var viewModel: MyViewModel {get set}
}

struct MyViewModel {
    var firstString: String
    var secondString: String
}

struct ForNormalPractice<Babul>: View where Babul:ViewModelProvider {
    @ObservedObject var presenter: Babul
    
    var body: some View {
        VStack {
            Text("\(presenter.viewModel.firstString)")
            Text("\(presenter.viewModel.secondString)")
        }
    }
}

struct ForNormalPractice_Previews: PreviewProvider {
    static var previews: some View {
        ForNormalPractice(presenter: Presenter(model: User(name: "bBAUL", age: 33)))
    }
}
