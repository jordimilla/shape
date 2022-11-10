import Domain
import Data
import Presentation

public class AppAssembly {
    
    public static let listBreedsFeature: ViewControllerProvider = {
        
        let fetchBreedsUseCase = FetchBreedsUseCase(repository: ServiceRepositoryAssembly.makeServiceRepository())
        
        return ListBreedsAssembly(fetchBreedsUseCase: fetchBreedsUseCase).build()
    }
}
