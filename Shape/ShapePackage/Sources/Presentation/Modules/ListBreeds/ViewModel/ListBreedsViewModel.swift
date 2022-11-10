import Domain
import Foundation
import Combine

final class ListBreedsViewModel {
    
    private let fetchBreedsUseCase: FetchBreedsUseCase
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var breeds: [Breed] = []
    
    init(fetchBreedsUseCase: FetchBreedsUseCase) {
        self.fetchBreedsUseCase = fetchBreedsUseCase
    }
}

// MARK: - API
extension ListBreedsViewModel {
    func fetchBreeds() {
        fetchBreedsUseCase.execute(value: ())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            }, receiveValue: { [weak self] items in
                self?.breeds = items
            })
            .store(in: &cancellables)
    }
}
