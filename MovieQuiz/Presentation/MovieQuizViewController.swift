import UIKit

final class MovieQuizViewController: UIViewController, QuestionFactoryDelegate {
    func didRecieveNextQuestion(question: QuizQuestion?) {
            guard let question = question else {return}
            currentQuestion = question
            let viewModel = convert(model: question)
            DispatchQueue.main.async { [weak self] in
                self?.show(quiz: viewModel)
            }}

    override func viewDidLoad() {
        super.viewDidLoad()
        //questionFactory?.delegate = self                   --- Почему такая конструкция не верна? И почему в фабрику нужно добавить init?
        //questionFactory?.requestNextQuestion()
        alertPresenter = AlertPresenter(alertController: self)
        questionFactory = QuestionFactory(delegate: self)
        questionFactory?.requestNextQuestion()
    }
    // MARK: - QuestionFactoryDelegate

 
    //
    private var alertPresenter : AlertPresenter?
    private var correctAnswers: Int = 0
    private var currentQuestionIndex: Int = 0
    private let questionsAmount: Int = 10
    //private let questionFactory: QuestionFactoryProtocol = QuestionFactory()
    private var currentQuestion: QuizQuestion?
    private var questionFactory: QuestionFactoryProtocol? = nil
    
    
    
    
    @IBAction private func yesButtonClicked(_ sender: Any) {
        guard let currentQuestion = currentQuestion else {return}
        let givenAnswer = true
        showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }
    @IBAction private func noButtonClicked(_ sender: Any) {
        guard let currentQuestion = currentQuestion else {return}
        let givenAnswer = false
        showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var textLabel: UILabel!
    @IBOutlet private var counterLabel: UILabel!
    
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var YesButton: UIButton!
    private func showNextQuestionOrResults() {
        if currentQuestionIndex == questionsAmount - 1 {
            // let text = "Ваш результат: \(correctAnswers) из 10"
            //let viewModel = QuizResultsViewModel(title: "Этот раунд окончен!",text: text,buttonText: "Сыграть ещё раз")
            //show(quiz: viewModel)
            let text = "Вы ответили на \(correctAnswers) из 10, попробуйте ещё раз!"
            let viewModel = AlertModel(title: "Этот раунд окончен!",message: text, buttonText: "Сыграть ещё раз")
            
          
            self.alertPresenter?.show(result: viewModel)
            self.currentQuestionIndex = 0
            self.correctAnswers = 0
            
        } else {
            currentQuestionIndex += 1

          //  questionFactory?.requestNextQuestion()
        
    }
        questionFactory?.requestNextQuestion()
    }
    private func show(quiz step: QuizStepViewModel) {
        //questionFactory?.requestNextQuestion()}
        self.imageView.image = step.image
        self.textLabel.text = step.question
        self.counterLabel.text = step.questionNumber
    }
    
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        return QuizStepViewModel(
            image: UIImage(named: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questionsAmount)")
    }
    private func showAnswerResult(isCorrect: Bool) {
    
        imageView.layer.masksToBounds = true // даём разрешение на рисование рамки
        imageView.layer.borderWidth = 1 // толщина рамки
        imageView.layer.borderColor = UIColor.white.cgColor // делаем рамку белой
        imageView.layer.cornerRadius = 6 // радиус скругления углов рамки
       // imageView.layer.borderColor = isCorrect ?? UIColor.yp Green.cgColor : UIColor.yp Red.cgColor Почемуто не видет мой цвет
        
        
     //  почему то не поулчается обратиться к подгруженным цветам....
        if isCorrect == true
        {
            imageView.layer.borderColor = UIColor.ypGreen.cgColor
            correctAnswers = correctAnswers + 1
        }
        else
            {
            imageView.layer.borderColor = UIColor.ypRed.cgColor
        }
            self.YesButton.isEnabled = false
            self.noButton.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else {return}
            self.YesButton.isEnabled = true
            self.noButton.isEnabled = true
            self.imageView.layer.borderWidth = 0 // нужно же убрать рамку!
            self.showNextQuestionOrResults()
        }
    }
/*
      Получается, что нам не требуется отдельый shoe для результатов? Мы ведь показать через AlertPresenter?
      private func show(quiz result: QuizResultsViewModel) {
      //  let alert = UIAlertController(
      //      title: result.title,
      //      message: result.text,
      //      preferredStyle: .alert)
      //  let action = UIAlertAction(title: result.buttonText, style: .default) { [weak self] _ in
      //      guard let self = self else {return}
           
            
            let text = "Вы ответили на \(correctAnswers) из 10, попробуйте ещё раз!"
            let viewModel = AlertModel(title: "Этот раунд окончен!",message: text, buttonText: "Сыграть ещё раз")
            
            
            self.alertPresenter?.show(result: viewModel)
                                        
            //  if let firstQuestion = self.questionFactory.requestNextQuestion() {
           //     self.currentQuestion = firstQuestion
          //      let viewModel = self.convert(model: firstQuestion)
                
          //      self.show(quiz: viewModel)
            self.questionFactory?.requestNextQuestion()
          //  }
        
        //alert.addAction(action)
        //self.present(alert, animated: true, completion: nil)
    
    }
 */
}

