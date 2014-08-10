package vk_prison.data {
public class Question {
    private var _number:uint;
    private var _question: String;
    private var _answers: Array;

    public function Question(number:uint, question:String, r1:String, r1s:uint, r2:String, r2s:uint, r3:String = null, r3s:uint = 0, r4:String = null, r4s:uint = 0):void {
        _number = number;
        _question = question;
        _answers = [];
        _answers.push(reformatResponse(r1, r1s));
        _answers.push(reformatResponse(r2, r2s));
        _answers.push(reformatResponse(r3, r3s));
        _answers.push(reformatResponse(r4, r4s));

        function reformatResponse(r:String, rs:uint):Object {
            var resp:Object = {};
            resp.value = r;
            resp.score = rs;

            return resp;
        }
    }

    public function get number():uint {
        return _number;
    }

    public function get question():String {
        return _question;
    }

    public function get answers():Array {
        return _answers;
    }
}
}
