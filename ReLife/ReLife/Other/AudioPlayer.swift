import AVFoundation

class AudioPlayer {
    static let shared = AudioPlayer()
    
    var player: AVAudioPlayer?
    
    var isPlaying: Bool { player?.isPlaying ?? false }
    
    private init() { 
        guard let url = Bundle.main.url(forResource: "FF5_fanfare", withExtension: "mp3")
        else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            
            player?.volume = Config.shared.soundVolume.value
            
            player?.prepareToPlay()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playSound(file:String = "FF5_fanfare", ext:String = "mp3") -> Void {
        guard let url = Bundle.main.url(forResource: file, withExtension: ext)
        else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            
            player?.volume = Config.shared.soundVolume.value
            
            player?.prepareToPlay()
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func stopSound() {
        player?.stop()
    }
}
