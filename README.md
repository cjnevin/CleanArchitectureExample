# CleanDomain

An example of how to setup an app using a separate framework for the Domain->Presentation logic as is shown in the Clean Architecture diagram.

Common contains:
- View Interfaces
- Coordinator Interfaces
- Model Interfaces
- Dependency Interfaces
- Presenter Interfaces

Domain imports Common and contains:
- Use Cases (Private)
- Presenters (Subject under Test)

App imports Common then:
- Each UIViewController implements a View Interface
- Each ModelObject implements a Model Interface
- Each dependency implements a Dependency Interface

App imports Domain and Common then:
- Each UINavigationController implements a Coordinator Interface

Has 100% test coverage of the Domain layer.
