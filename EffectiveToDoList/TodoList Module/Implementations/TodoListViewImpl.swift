import UIKit

final class TodoListViewImpl: UIViewController, TodoListView {
    
    var presenter: TodoListPresenter
    
    private var todolist: TodoList = []
    
    private let searchTextField = UITextField()
    private let tableView = UITableView()
    private let todoCountLabel = UILabel()
    private let addTodoButton = UIButton()
    
    private var searchText = ""
    
    init(presenter: TodoListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationItem.title = "Задачи"
        
        setupLayout()
        setupSearchTextField()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .inline
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }
    
    func reload() {
        tableView.reloadData()
    }
    
    func showTodoList(_ new: TodoList) {
        todoCountLabel.text = "Задач".countString(new.count)
        
        let old = todolist
        todolist = new
        
        if old.isEmpty || new.isEmpty {
            reload()
            return
        }
        
        if old.count > new.count {
            animateDelete(oldTodolist: old, newTodolist: new)
        } else if old.count == new.count {
            animateUpdate(oldTodolist: old, newTodolist: new)
        } else {
            animateInsert(oldTodolist: old, newTodolist: new)
        }
    }
    
    private func setupLayout() {
        let footer = setupFooter()
        
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchTextField)
        view.addSubview(tableView)
        view.addSubview(footer)
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            searchTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchTextField.heightAnchor.constraint(equalToConstant: 36),
            
            tableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.bottomAnchor.constraint(equalTo: footer.topAnchor),
            
            footer.heightAnchor.constraint(equalToConstant: 78),
            footer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            footer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            todoCountLabel.topAnchor.constraint(equalTo: footer.topAnchor, constant: 16),
            todoCountLabel.centerXAnchor.constraint(equalTo: footer.centerXAnchor),
            todoCountLabel.leadingAnchor.constraint(equalTo: footer.leadingAnchor),
            todoCountLabel.bottomAnchor.constraint(equalTo: footer.bottomAnchor, constant: -50),
            
            addTodoButton.topAnchor.constraint(equalTo: footer.topAnchor, constant: 8),
            addTodoButton.widthAnchor.constraint(equalTo: addTodoButton.heightAnchor),
            addTodoButton.heightAnchor.constraint(equalToConstant: 28),
            addTodoButton.trailingAnchor.constraint(equalTo: footer.trailingAnchor, constant: -22)
        ])
    }
    
    private func setupSearchTextField() {
        searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Поиск",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        )
        searchTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        searchTextField.font = .systemFont(ofSize: 17, weight: .regular)
        searchTextField.autocorrectionType = .no
        searchTextField.autocapitalizationType = .none
        
        searchTextField.leftView = UIImageView(image: .search)
        searchTextField.setLeftPaddingPoints(left: 8, right: 6)
        searchTextField.leftViewMode = .always
        
        searchTextField.rightView = UIImageView(image: .searchMicrophone)
        searchTextField.setRightPaddingPoints(right: 8)
        searchTextField.rightViewMode = .always
        
        searchTextField.backgroundColor = .systemGray5
        searchTextField.layer.cornerRadius = 10
    }
    
    @objc private func textFieldChanged(_ sender: UITextField) {
        presenter.searchTextChanged(sender.text ?? "")
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupFooter() -> UIView {
        let footer = UIView()
        footer.translatesAutoresizingMaskIntoConstraints = false
        todoCountLabel.translatesAutoresizingMaskIntoConstraints = false
        addTodoButton.translatesAutoresizingMaskIntoConstraints = false
        footer.backgroundColor = .systemGray5
        footer.addSubview(todoCountLabel)
        footer.addSubview(addTodoButton)
        
        todoCountLabel.countStyle()
        
        addTodoButton.setBackgroundImage(.addTodo, for: .normal)
        addTodoButton.tintColor = .systemYellow
        addTodoButton.addAction(UIAction { [weak self] sender in
            guard let self else { return }
            presenter.selected(from: self)
        }, for: .touchUpInside)
        
        return footer
    }
    
    private func animateDelete(oldTodolist: TodoList, newTodolist: TodoList) {
        var res = [IndexPath]()
        
        for i in 0..<newTodolist.count {
            if oldTodolist[i + res.count] != newTodolist[i] {
                res += [IndexPath(row: i, section: 0)]
                break
            }
        }
        animateDelete(at: res)
    }
    
    private func animateDelete(at indexPaths: [IndexPath]) {
        tableView.performBatchUpdates({
            tableView.deleteRows(at: indexPaths, with: .automatic)
        }, completion: nil)
    }
    
    private func animateUpdate(oldTodolist: TodoList, newTodolist: TodoList) {
        var res = [IndexPath]()
        
        for i in 0..<oldTodolist.count {
            if oldTodolist[i] != newTodolist[i] {
                res += [IndexPath(row: i, section: 0)]
                break
            }
        }
        animateUpdate(at: res)
    }
    
    private func animateUpdate(at indexPaths: [IndexPath]) {
        tableView.performBatchUpdates({
            tableView.reloadRows(at: indexPaths, with: .automatic)
        }, completion: nil)
    }
    
    
    private func animateInsert(oldTodolist: TodoList, newTodolist: TodoList) {
        var res = [IndexPath]()
        
        for i in 0..<oldTodolist.count {
            if oldTodolist[i] != newTodolist[i + res.count] {
                res += [IndexPath(row: i, section: 0)]
                break
            }
        }
        animateInsert(at: res)
    }
    
    private func animateInsert(at indexPaths: [IndexPath]) {
        tableView.performBatchUpdates({
            tableView.insertRows(at: indexPaths, with: .automatic)
        }, completion: nil)
    }
}

extension TodoListViewImpl: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todolist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(TodoListCell.self, indexPath: indexPath)
        var todo = todolist[indexPath.row]
        cell.setTodo(todo) { [weak self] isCompleted in
            todo.isCompleted = isCompleted
            self?.presenter.todoChanged(todo)
        }
        return cell
    }
    
    
}

extension TodoListViewImpl: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let todo = todolist[indexPath.row]
        presenter.selected(todo, from: self)
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let todo = todolist[indexPath.row]
        let identifier = indexPath as NSIndexPath
        
        let configuration = UIContextMenuConfiguration(identifier: identifier, previewProvider: nil) { [weak self] actions -> UIMenu? in
            
            guard let self else { return nil }
            
            let edit = UIAction(title: "Редактировать", image: .addTodo) { action in
                self.presenter.selected(todo, from: self)
            }
            
            let share = UIAction(title: "Поделиться", image: .share, identifier: nil) { action in
                let textToShare = [todo.title, todo.text]
                let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
                self.present(activityViewController, animated: true, completion: nil)
            }
            
            let delete = UIAction(title: "Удалить", image: .delete, attributes: .destructive) { action in
                self.presenter.deleteTapped(todo)
            }
            
            
            return UIMenu(children: [edit, share, delete])
        }
        return configuration
    }
}
