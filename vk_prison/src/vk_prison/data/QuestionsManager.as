/**
 * Created by wawilon on 10.08.2014.
 */
package vk_prison.data {
public class QuestionsManager {
    private var _questions:Array = [];
    private var _currentQuestion:int = -1;
    private var _score:uint = 0;

    public function QuestionsManager() {
        _questions.push(new Question(1, "Авто какой марки вы предпочитаете?", "Mercedes", 1, "BMW", 3, "Lexus", 2, "Ни одну из перечисленных", 0));
        _questions.push(new Question(2, "Сколько раз за свою жизнь вы были на стрелках?", "1-3 раза", 1, "3-5 раз", 2, "более 5 раз", 3, "Ни разу", 0));
        _questions.push(new Question(3, "Какой из фильмов вы бы посмотрели в первую очередь?", "Сериал Бригада", 2, "Брат/Брат2", 1, "Бумер", 3, "Ни один из перечисленных", 0));
        _questions.push(new Question(4, "Какого из исполнителей/групп вы уважаете больше, чем остальных?", "Словетский/Константа", 2, "Каспийский груз", 3, "Гармора", 1, "Ни один из перечисленных", 0));
        _questions.push(new Question(5, "Занимаетесь ли вы боевыми искусствами?", "Нет, но занимался раньше", 2, "Да", 3, "Нет, но планирую в будущем", 1, "Нет и не планирую в будущем", 0));
        _questions.push(new Question(6, "Считаете ли вы себя лидером в коллективе?", "Да", 2, "Трудно ответить", 1, "Нет", 0));
        _questions.push(new Question(7, "Имеется ли у вас дома бейсбольная бита?", "Да, но она для занятий бейсболом", 1, "Нет, но планирую приобрести", 2, "Нет, но была раньше", 3, "Нет, т.к. в этом нет необходимости", 0));
        _questions.push(new Question(8, "Обучены ли вы стрельбе из автоматического оружия?", "Да, остались навыки владения оружием", 3, "Проходил обучение, но навыков не осталось", 1, "Нет, но планирую пройти обучение", 2, "Нет, обучение проходить НЕ планирую", 0));
        _questions.push(new Question(9, "Согласны ли вы с утверждением \"незаменимых нет\"?", "Да", 2, " Нет", 0, "Трудно ответить", 1));
        _questions.push(new Question(10, "Готовы ли вы повести за собой людей, если ситуация того требует?", "Да", 2, "Нет", 0, "Трудно ответить", 0));
    }

    public function getNextQuestion(btnNum:int):Question {
        if (btnNum >= 0) {
            _score += _questions[_currentQuestion].answers[btnNum].score;
        }
        _currentQuestion++;
        if (_questions.length > _currentQuestion) {
            return _questions[_currentQuestion];
        } else {
            return null;
        }
    }

    public function get score():uint {
        return _score;
    }
}
}
