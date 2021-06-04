import Foundation

final class CallStation {
    var usersArray = [User]()
    var callsArray = [Call]()
    
}

extension CallStation: Station {
    func users() -> [User] {
        return usersArray
    }
    
    func add(user: User) {
        if (!usersArray.contains(user)) {
            usersArray.append(user)
        }
    }
    
    func remove(user: User) {
        if (usersArray.contains(user)) {
            usersArray.remove(at: usersArray.firstIndex(of: user)!)
        }
    }
    
    func execute(action: CallAction) -> CallID? {
        return nil
    }
    
    func calls() -> [Call] {
        return callsArray
    }
    
    func calls(user: User) -> [Call] {
        return []
    }
    
    func call(id: CallID) -> Call? {
        nil
    }
    
    func currentCall(user: User) -> Call? {
        nil
    }
}
