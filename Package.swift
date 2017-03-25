import PackageDescription

let package = Package(
    name: "iTunes-Search-with-Swift-Server-Blackfish-Hypertext-Alamofire",
    dependencies: [
        .Package(url: "https://github.com/Alamofire/Alamofire.git", majorVersion: 4),
        .Package(url: "https://github.com/elliottminns/blackfire.git", majorVersion: 0),
        .Package(url: "https://github.com/sahandnayebaziz/Hypertext.git", majorVersion: 2)
    ]
)
