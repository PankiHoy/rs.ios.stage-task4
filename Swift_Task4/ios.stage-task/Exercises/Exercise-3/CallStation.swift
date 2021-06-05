import Foundation

final class CallStation {
    var usersArray = [User]()
    var callsArray = [Call]()
}

extension CallStation: Station {
    func users() -> [User] {
        usersArray
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
        switch action {
        case let .start(from: sender, to: reciever):
            if !usersArray.contains(sender) && !usersArray.contains(reciever) {
                return nil
            } else if !usersArray.contains(reciever) {
                let call = Call(id: UUID.init(), incomingUser: sender, outgoingUser: reciever, status: .ended(reason: .error))
                callsArray.append(call)
                return call.id
            }
            
            if self.currentCall(user: reciever) != nil {
                let call = Call(id: UUID.init(), incomingUser: sender, outgoingUser: reciever, status: .ended(reason: .userBusy))
                callsArray.append(call)
            } else {
                let call = Call(id: UUID.init(), incomingUser: sender, outgoingUser: reciever, status: .calling)
                callsArray.append(call)
            }

            return callsArray[callsArray.firstIndex(where: { $0.incomingUser == sender && $0.outgoingUser == reciever })!].id
            
            
        case let .answer(from: user):
            if !usersArray.contains(user) {
                if callsArray.firstIndex(where: { $0.outgoingUser == user }) != nil {
                    callsArray[callsArray.firstIndex(where: { $0.outgoingUser == user })!].status = .ended(reason: .error)
                }
                return nil
            }
            
            let callId = calls(user: user).first?.id
            if callsArray[callsArray.firstIndex(where: { $0.id == callId })!].status == .calling {
                callsArray[callsArray.firstIndex(where: { $0.id == callId })!].status = .talk
            }
            
            return callId
            
            
        case let .end(from: user):
            let callId = calls(user: user).first?.id
            
            if callsArray.contains(where: { $0.id == callId }) {
                if callsArray[callsArray.firstIndex(where: { $0.id == callId })!].status == .calling {
                    callsArray[callsArray.firstIndex(where: { $0.id == callId })!].status = .ended(reason: .cancel)
                }
                if callsArray[callsArray.firstIndex(where: { $0.id == callId })!].status == .talk {
                    callsArray[callsArray.firstIndex(where: { $0.id == callId })!].status = .ended(reason: .end)
                }
            }
            
            return callId
        }
    }
    
    func calls() -> [Call] {
        callsArray
    }
    
    func calls(user: User) -> [Call] {
        var calls = [Call]()
        for call in callsArray {
            if call.incomingUser == user || call.outgoingUser == user {
                calls.append(call)
            }
        }
        return calls
    }
    
    func call(id: CallID) -> Call? {
        for call in callsArray {
            if call.id == id {
                return call
            }
        }
        return nil
    }
    
    func currentCall(user: User) -> Call? {
        for call in callsArray {
            if (call.outgoingUser == user || call.incomingUser == user) && (call.status == .calling || call.status == .talk) {
                return call
            }
        }
        return nil
    }
}

