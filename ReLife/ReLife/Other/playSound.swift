import AVFoundation

var player: AVAudioPlayer?

func playSound(file:String = "FF5_fanfare", ext:String = "mp3", volume: Float = 0.1) -> Void {
    guard let url = Bundle.main.url(forResource: file, withExtension: ext)
    else { return }
    
    do {
        player = try AVAudioPlayer(contentsOf: url)
        
        player?.volume = volume
        
        player?.prepareToPlay()
        player?.play()
        
    } catch let error {
        print(error.localizedDescription)
    }
}

func stopSound() {
    player?.stop()
}
