import UIKit

protocol AnyCounterView {
    var presenter: AnyCounterPresenter? { get set }

    func appeared()
    func disappeared()
    func tappedIncrement()

    func setCount(_ value: Int)
}

protocol AnyCounterPresenter {
    func attach<View: AnyCounterView>(view: View)
    func detach()
    func increment()
}

protocol AnyStorage {
    func getValue<Value>(forKey key: String) -> Value?
    func setValue<Value>(_ value: Value, forKey key: String)
}

struct GetCountUseCase {
    let storage: AnyStorage

    func get() -> Int {
        storage.getValue(forKey: "count") ?? 0
    }
}

struct IncrementUseCase {
    let storage: AnyStorage

    func increment() -> Int {
        let get = GetCountUseCase(storage: storage)
        let count = get.get()
        storage.setValue(count + 1, forKey: "count")
        return get.get()
    }
}

protocol AnyCounterCoordinator {
    var storage: AnyStorage { get }

    func makeCounterView() -> AnyCounterView
}

class CounterPresenter: AnyCounterPresenter {
    private var view: AnyCounterView?
    private let getCountUseCase: GetCountUseCase
    private let incrementUseCase: IncrementUseCase

    init(coordinator: AnyCounterCoordinator) {
        getCountUseCase = GetCountUseCase(storage: coordinator.storage)
        incrementUseCase = IncrementUseCase(storage: coordinator.storage)
    }

    func attach<View: AnyCounterView>(view: View) {
        self.view = view
        view.setCount(getCountUseCase.get())
    }

    func detach() {
        view?.setCount(0)
        view = nil
    }

    func increment() {
        view?.setCount(incrementUseCase.increment())
    }
}

class RealView: AnyCounterView {
    var presenter: AnyCounterPresenter?

    func appeared() {
        presenter?.attach(view: self)
    }

    func disappeared() {
        presenter?.detach()
    }

    func tappedIncrement() {
        presenter?.increment()
    }

    func setCount(_ value: Int) {
        print(value)
    }
}

class RealStorage: AnyStorage {
    typealias Key = String
    private var storage: [Key: Any] = [:]

    func getValue<Value>(forKey key: Key) -> Value? {
        storage[key] as? Value
    }

    func setValue<Value>(_ value: Value, forKey key: Key) {
        storage[key] = value
    }
}

class RealCoordinator: AnyCounterCoordinator {
    var storage: AnyStorage = RealStorage()

    func makeCounterView() -> AnyCounterView {
        let view = RealView()
        view.presenter = CounterPresenter(coordinator: self)
        return view
    }
}

let coordinator = RealCoordinator()
let view = coordinator.makeCounterView()
view.appeared()
view.tappedIncrement()
view.tappedIncrement()
view.tappedIncrement()
view.disappeared()
