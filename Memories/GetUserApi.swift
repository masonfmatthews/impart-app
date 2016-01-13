import Foundation

final class GetUserApi : Api {
    
    var json : [String: AnyObject]?
    
    init(user_id : Int) {
        super.init()
        
        let urlString = self.domain + self.path + "users/\(user_id)?token=\(self.session.token!)"
        if let url = NSURL(string: urlString),
            data = NSData(contentsOfURL: url) {
                self.json = (try? NSJSONSerialization.JSONObjectWithData(data, options: [])) as? [String: AnyObject]
        }
    }
    
    func getUser() -> User? {
        if json != nil {
            return User(id: json!["id"] as! Int,
                name: json!["name"] as! String,
                email: json!["email"] as! String)
        } else {
            return nil
        }
    }
    
    func getNextQuestions() -> [Question] {
        if json != nil {
            var questions:[Question] = []
            let array = json!["next_questions"] as! [[String: AnyObject]]
            for result in array {
                questions.append(Question(id: result["id"] as! Int,
                    question: result["question"] as! String))
            }
            return questions
        } else {
            return []
        }
    }
    
}