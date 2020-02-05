# CleanDomain

An example of how to setup an app using a separate framework for the Domain->Presentation logic as is shown in the Clean Architecture diagram.

Domain contains:
- Use Cases (Private)
- Presenters (Subject under Test)
- View Interfaces
- Coordinator Interfaces
- Model Interfaces
- Dependency Interfaces

App imports Domain then:
- Each UIViewController implements a View Interface
- Each UINavigationController implements a Coordinator Interface
- Each ModelObject implements a Model Interface
- Each dependency implements a Dependency Interface

Has 100% test coverage of the Domain layer.
