//
//  AudioPlayes.swift
//  
//
//  Created by Matthew on 7.09.22.
//

import Foundation
import AVKit
var player: AVAudioPlayer?




func soundtrack() {

    let trackLP: String = "LP"
    let tackNirvana: String = "Nirvana"
    
    let track: String = trackLP
    
    
if let audioUrl = Bundle.main.url(forResource: track, withExtension: "mp3") {
    player = try? AVAudioPlayer(contentsOf: audioUrl)
}

}
