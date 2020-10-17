/// Dynamic class should be used for binding ViewModel (from MVVM) variables to the ViewController.
///
/// When the value in Dynamic class will be updated, bind block will be triggered.
/// # Example of use
/// ```
/// class ViewModel {
///
///     var displayString: Dynamic<String> = Dynamic<String>("")
///
///     // ...
///
/// }
///
/// class ViewController: UIViewController {
///
///     var viewModel: ViewModel!
///
///     var label: UILabel
///
///     func viewDidLoad() {
///         super.viewDidLoad()
///
///         viewModel = ViewModel()
///
///         bindToViewModel()
///     }
///
///     func bindToViewModel() {
///         viewModel.displayString.bindAndFire { (_, newValue) in
///             label.text = newValue
///         }
///     }
///
///     // ...
///
/// }
/// ```
class Dynamic<T> {

    var bind: (_ oldValue: T, _ newValue: T) -> Void = { _, _ in }

    var value: T {
        didSet {
            bind(oldValue, value)
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func bindAndFire(bind: @escaping ((_ oldValue: T, _ newValue: T) -> Void)) {
        self.bind = bind
        bind(value, value)
    }

}
