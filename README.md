# CleanDomain

An example of how to setup an app using a separate framework for the Domain->Presentation logic as is shown in the Clean Architecture diagram.

Domain contains Entity Interfaces, Use Cases, Presenters, View Interfaces, and Coordinator Interfaces.

App implements UIViewController (View Interfaces), UINavigationController (Coordinator Interfaces), Model Objects (Entity Interfaces)

Has 100% test coverage of the Domain layer.
