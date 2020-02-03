# CleanDomain

An example of how to setup an app using a separate framework for the Domain->Presentation logic as is shown in the Clean Architecture diagram.

Domain contains Entity Interfaces, Service Interfaces, Use Cases, Presenters, View Interfaces, and Coordinator Interfaces.

App implements UIViewController (View Interfaces), UINavigationController (Coordinator Interfaces), Model Objects (Entity Interfaces), Dependencies (Service Interfaces)

Has 100% test coverage of the Domain layer.
