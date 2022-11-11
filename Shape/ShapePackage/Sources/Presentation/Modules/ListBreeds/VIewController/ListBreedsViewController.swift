import Foundation
import UIKit
import Domain
import Combine

class ListBreedsViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: ListBreedsViewModel
    var breeds: [Breed] = []
    var cancellables: Set<AnyCancellable> = []
    
    let tableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView())
    
    
    // MARK: - Inits
    
    public init(viewModel: ListBreedsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupBindings()
        viewModel.fetchBreedsFromStored()
    }
}

// MARK: - Layout
extension ListBreedsViewController {
    private func setupViews() {
        view.backgroundColor = .black
        title = "Breeds"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelectionDuringEditing = false
        tableView.register(BreedTableViewCell.self, forCellReuseIdentifier: BreedTableViewCell.indentifier)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favorites", style: .plain, target: self, action: #selector(addTapped))
    }

    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         left: view.safeAreaLayoutGuide.leftAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         right: view.safeAreaLayoutGuide.rightAnchor)
    }
    
    @objc private func addTapped() {
        guard let navigation = self.navigationController else { return }
        viewModel.goToFavorites(navigationController: navigation)
    }
}

// MARK: - Binding
extension ListBreedsViewController {
    private func setupBindings() {
        viewModel.$breeds
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                self?.breeds = items
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
}


// MARK: - UITableViewDataSource
extension ListBreedsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breeds.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BreedTableViewCell.indentifier, for: indexPath) as? BreedTableViewCell else {
            return UITableViewCell()
        }
        let breed: Breed = breeds[indexPath.row]
        cell.setup(title: breed.name)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ListBreedsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navigation = self.navigationController else { return }
        let breed: Breed = breeds[indexPath.row]
        viewModel.goToPictures(navigationController: navigation, post: breed)
    }
}
