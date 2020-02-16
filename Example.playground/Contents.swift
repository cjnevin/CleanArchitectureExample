import UIKit

// MARK: - Common

protocol AnyStorage {
    func getValue<Value>(forKey key: String, defaultValue: Value) -> Value
    func setValue<Value>(_ value: Value, forKey key: String)
}

protocol StorageHaving {
    var storage: AnyStorage { get }
}

enum Common {
    private class Storage: AnyStorage {
        typealias Key = String
        private var storage: [Key: Any] = [:]

        func getValue<Value>(forKey key: Key, defaultValue: Value) -> Value {
            storage[key] as? Value ?? defaultValue
        }

        func setValue<Value>(_ value: Value, forKey key: Key) {
            storage[key] = value
        }
    }

    struct Dependencies: StorageHaving {
        let storage: AnyStorage = Storage()
    }
}

// MARK: - Interfaces

protocol AnyCounterCoordinator {
    var dependencies: StorageHaving { get }

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

enum Counter {
    private struct GetCountUseCase {
        let dependencies: StorageHaving

        func get() -> Int {
            dependencies.storage.getValue(forKey: "count", defaultValue: 0)
        }
    }

    private struct IncrementUseCase {
        let dependencies: StorageHaving

        func increment() -> Int {
            let getCountUseCase = GetCountUseCase(dependencies: dependencies)
            dependencies.storage.setValue(getCountUseCase.get() + 1, forKey: "count")
            return getCountUseCase.get()
        }
    }

    class Presenter: AnyCounterPresenter {
        private var view: AnyCounterView?
        private let getCountUseCase: GetCountUseCase
        private let incrementUseCase: IncrementUseCase

        init(coordinator: AnyCounterCoordinator) {
            getCountUseCase = GetCountUseCase(dependencies: coordinator.dependencies)
            incrementUseCase = IncrementUseCase(dependencies: coordinator.dependencies)
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

extension Counter {
    private class View: AnyCounterView {
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

    class Coordinator: AnyCounterCoordinator {
        var dependencies: StorageHaving
        init(dependencies: StorageHaving) {
            self.dependencies = dependencies
        }

        func makeCounterView() -> AnyCounterView {
            let view = View()
            view.presenter = Presenter(coordinator: self)
            return view
        }
    }
}

let dependencies = Common.Dependencies()
let coordinator = Counter.Coordinator(dependencies: dependencies)
let view = coordinator.makeCounterView()
view.appeared()
view.tappedIncrement()
view.tappedIncrement()
view.tappedIncrement()
view.disappeared()
