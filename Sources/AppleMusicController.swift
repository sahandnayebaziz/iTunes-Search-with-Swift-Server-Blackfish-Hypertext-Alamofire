//
//  AppleMusicController.swift
//  iTunesSearchServer
//
//  Created by Sahand on 3/25/17.
//
//

import Foundation
import Blackfire
import Alamofire
import Hypertext

struct AppleMusicTrack: Renderable {
    let trackId: String
    let trackName: String
    let artistName: String
    let trackAlbumArt: String
    var spotifyId: String?

    var appleMusicId: String {
        return trackId
    }
    
    func render() -> String {
        return div {
            [
                img(["src": trackAlbumArt]),
                p { [ b { artistName }, " ", trackName ] }
            ]
        }.render()
    }
}


struct AppleMusicController {

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
                    guard let jsonResponse = response.result.value as? [String: Any], let results = jsonResponse["results"] as? [[String: Any]] else {
                        res.status = 502
                        res.send(text: "Bad response received.")
                        return
                    }

                    let songs: [Renderable] = results.map { result in
                        let track = AppleMusicTrack(trackId: "\(result["trackId"] as? Int ?? 0)", trackName: result["trackName"] as? String ?? "", artistName: result["artistName"] as? String ?? "", trackAlbumArt: (result["artworkUrl100"] as? String ?? ""), spotifyId: nil)
                        return track
                    }
                    return res.send(html: songs.render())
                default:
                    print("received status code from itunes: \(httpResponse.statusCode)")
                    res.send(status: 500)
                    return
                }
        }
    }

}
