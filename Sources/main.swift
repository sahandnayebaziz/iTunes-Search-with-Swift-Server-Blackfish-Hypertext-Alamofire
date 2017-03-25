import Foundation
import Blackfire

let app = Flame(type: .concurrent)

app.get("/") { (req, res) in
    print("fulfilling request")
    res.send(text: "Hello World")
}

app.get("/search", AppleMusicController.getSearch)


app.start(port: 3000) { result in
    switch result {
    case .success:
        print("Server started on port 3000")
    case .failure(let error):
        print("Server failed with error: \(error)")
    }
}
