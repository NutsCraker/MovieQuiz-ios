import UIKit

final class MovieQuizViewController: UIViewController, AlertPresenterDelegate, MovieQuizViewControllerProtocol {

    // MARK: - Lifecycle
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var textLabel: UILabel!
    @IBOutlet weak private var counterLabel: UILabel!
    @IBOutlet weak private var yesButton: UIButton!
    @IBOutlet weak private var noButton: UIButton!

    private var alertPresenter: AlertPresenter?
    private var presenter: MovieQuizPresenter!
    private var statisticService: StatisticService = StatisticServiceImplementation()
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MovieQuizPresenter(viewController: self)
        alertPresenter = AlertPresenter()
        alertPresenter?.delegate = self

    }
   
    
    // MARK: - AlertPresenterDelegate
    func didPresentAlert(alert: UIAlertController?) {
        guard let alert = alert else {
            return
        }
        DispatchQueue.main.async {[weak self] in
        self?.present(alert, animated: true, completion: nil)
        }
    }
    
    func show(quiz quizStepViewModel: QuizStepViewModel) {

        imageView.image = quizStepViewModel.image
        imageView.layer.cornerRadius = 20
        textLabel.text = quizStepViewModel.question
        counterLabel.text = quizStepViewModel.questionNumber
        
    }
    
    func showAnswerResult(isCorrect: Bool){
        imageView.layer.masksToBounds = true 
        imageView.layer.borderWidth = 8
        imageView.layer.cornerRadius = 20
        if isCorrect {
            imageView.layer.borderColor = UIColor.ypGreen.cgColor
            presenter.didAnswer(isCorrect: true)
        } else{
            imageView.layer.borderColor = UIColor.ypRed.cgColor
            
        }
        noButton.isEnabled = false
        yesButton.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: { [weak self] in
            guard let self = self else {
                return
            }

            self.noButton.isEnabled = true
            self.yesButton.isEnabled = true
            self.imageView.layer.borderWidth = 0
            self.presenter.statisticService = self.statisticService
            self.presenter.alertPresenter = self.alertPresenter
            self.presenter.showNextQuestionOrResults()
            
        })

    }
    
    
    func showLoadingIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    func showNetworkError(message: String) {
        hideLoadingIndicator()
        
        let alertModel = AlertModel(title: "Ошибка",
                                          message: message,
                                          buttonText: "Попробовать еще раз",
                                          completion: { [weak self] _ in
                                                        guard let self = self else {
                                                            return
                                                        }
                                           self.presenter.restartGame()
                                        })
        alertPresenter?.show(result: alertModel)
    }
    
    @IBAction private func noButtonClicked(_ sender: Any) {
        presenter.noButtonClicked()
    }
    
    @IBAction private func yesButtonClicked(_ sender: Any) {
        presenter.yesButtonClicked()
    }
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
}
