import UIKit

// MARK: - Common

protocol AnyStorage {
    func getValue<Value>(forKey key: String, defaultValue: Value) -> Value
    func setValue<Value>(_ value: Value, forKey key: String)
}

protocol AnyCounterCoordinator {
    var storage: AnyStorage { get }

    func makeCounterView() -> AnyCounterView
}

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

// MARK: - Domain

enum Domain {
    private struct GetCountUseCase {
        let storage: AnyStorage

        func get() -> Int {
            storage.getValue(forKey: "count", defaultValue: 0)
        }
    }
    private struct IncrementUseCase {
        let storage: AnyStorage

        func increment() -> Int {
            let getCountUseCase = GetCountUseCase(storage: storage)
            storage.setValue(getCountUseCase.get() + 1, forKey: "count")
            return getCountUseCase.get()
        }
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
}

// MARK: - App

enum App {
    class CounterView: AnyCounterView {
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

    class CounterStorage: AnyStorage {
        typealias Key = String
        private var storage: [Key: Any] = [:]

        func getValue<Value>(forKey key: Key, defaultValue: Value) -> Value {
            storage[key] as? Value ?? defaultValue
        }

        func setValue<Value>(_ value: Value, forKey key: Key) {
            storage[key] = value
        }
    }

    class CounterCoordinator: AnyCounterCoordinator {
        var storage: AnyStorage = CounterStorage()

        func makeCounterView() -> AnyCounterView {
            let view = CounterView()
            view.presenter = Domain.CounterPresenter(coordinator: self)
            return view
        }
    }
}

let coordinator = App.CounterCoordinator()
let view = coordinator.makeCounterView()
view.appeared()
view.tappedIncrement()
view.tappedIncrement()
view.tappedIncrement()
view.disappeared()
