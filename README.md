Creating routes just like Express on Node...

```swift

app.get("/") { (req, res) in
    print("fulfilling request")
    res.send(text: "Hello World")
}

app.get("/search", AppleMusicController.getSearch)

```

Using structs and protocols in Swift to have great data structures...

```swift
struct AppleMusicTrack: Renderable {
    let trackId: String
    let trackName: String
    let artistName: String
    let trackAlbumArt: String
    var spotifyId: String?
    
    ...
}
```

Using Hypertext to create HTML with full type safety...
```swift
struct AppleMusicTrack: Renderable {
    ...
    
    func render() -> String {
        return div {
            [
                img( ["src": trackAlbumArt] ),
                p { [ b { artistName }, " ", trackName ] }
            ]
        }.render()
    }
}
```

Making requests with Alamofire

```swift
static func getSearch(req: Blackfire.Request, res: Response) -> Void {
        guard let searchQuery = (req.query["query"] as? String)?.removingPercentEncoding, searchQuery != "" else {
            res.status = 400
            res.send(text: "Please include a value under the parameter \"query\" to search iTunes.")
            return
        }

        let parameters = [ "entity": "song", "term": searchQuery, "limit": "10" ]
        request("https://itunes.apple.com/search", method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                let httpResponse = response.response!
                switch httpResponse.statusCode {
                case 200:
                
        ...
 }

```
