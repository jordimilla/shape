# shape

- Architecture used: Clean Architecture
- Architecture pattern in the presentation layer: MVVM
- UI Framework: UIKit
- Persistence Framework: CoreData
- Reactive Framework: Combine


The application is organized in 3 layers in ShapePackage provided by SwiftPackageManager:

# Presentation 
Layer contains UI that are coordinated by Presenters/ViewModels which execute 1 or multiple. Presentation Layer depends on Domain Layer.

# Domain Layer 
is the most INNER part of the onion (no dependencies with other layers) and it contains Entities & Repository Interfaces. Use cases combine data from 1 or multiple Repository Interfaces.

# Data Layer 
contains Repository Implementations and multiple Data Sources. Repositories are responsible to coordinate data from the different Data Sources. Data Layer depends on Domain Layer.

# Improvements
- Create an API manager to handle all requests (get,post,put...) and urls
- UI: I have focused on the architecture part and not on the visual
- Finish unit tests. I have done some unit tests in each layer so you can see how the tests would look
- Add UI test: Example https://github.com/jordimilla/Crypto
