import UIKit

final class TodoDetailViewImpl: UIViewController {
    
    var presenter: TodoDetailPresenter
    
    private var todo: Todo?
    
    private let titleTextField = UITextField()
    private let createDateLabel = UILabel()
    private let descriptionTextField = UITextField()
    
    init(presenter: TodoDetailPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupStyles()
        setupLayout()
        setupTextFields()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupLayout() {
        let stack = UIStackView(arrangedSubviews: [
            titleTextField,
            createDateLabel,
            descriptionTextField
        ])
        
        stack.alignment = .leading
        stack.axis = .vertical
        stack.spacing = 8
        stack.setCustomSpacing(16, after: createDateLabel)
        
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupStyles() {
        titleTextField.font = .systemFont(ofSize: 34, weight: .bold)
        createDateLabel.dateStyle()
        descriptionTextField.font = .systemFont(ofSize: 16, weight: .regular)
    }
    
    private func setupTextFields() {
        titleTextField.tag = 0
        titleTextField.placeholder = "Название задачи"
        titleTextField.delegate = self
        titleTextField.autocorrectionType = .no
        titleTextField.autocapitalizationType = .none
        
        descriptionTextField.tag = 1
        descriptionTextField.placeholder = "Описание задачи"
        descriptionTextField.delegate = self
        descriptionTextField.autocorrectionType = .no
        descriptionTextField.autocapitalizationType = .none
    }
}

extension TodoDetailViewImpl: TodoDetailView {
    func showTodo(_ todo: Todo?) {
        let todo = todo ?? Todo(
            id: UUID(),
            title: "",
            text: "",
            createDate: Date(),
            isCompleted: false
        )
        
        titleTextField.text = todo.title
        createDateLabel.text = todo.createDate.slashStyle
        descriptionTextField.text = todo.text
        
        self.todo = todo
    }
}

extension TodoDetailViewImpl: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
            // title textField
        case 0:
            todo?.title = textField.text ?? ""
            // description textField
        default:
            todo?.text = textField.text ?? ""
        }
        
        if let todo {
            presenter.todoEditingFinished(todo)
        }
    }
}
