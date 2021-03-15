//
//  EmojiArtDocument.swift
//  EmojiArt
//
//  Created by Vorapon Sirimahatham on 13/3/21.
//

import SwiftUI

class EmojiArtDocument : ObservableObject {
    // ObservableObject : things changed in model we will see em
    
//    static let palette : String = "🥨🥦🍐🥪🧈🥥"
    static let palette : String = "🥨🥦🍐🥪🧈🥥🍇🫓🥩"
    
    @Published private(set) public var backgroundImage : UIImage?
    
    @Published private var emojiArt : EmojiArt = EmojiArt()
    
    var emojis : [EmojiArt.Emoji] { emojiArt.emojis }
    
    // MARK - Intext(s)
    
    func addEmoji(_ emoji : String, at location : CGPoint, size : CGFloat) {
        emojiArt.addEmoji(emoji, x: Int(location.x), y: Int(location.y), size: Int(size))
    }
    
    func moveEmoji(_ emoji : EmojiArt.Emoji, by offset : CGSize )  {
        if let index = emojiArt.emojis.firstIndex(matching: emoji){
            emojiArt.emojis[index].x += Int(offset.width)
            emojiArt.emojis[index].y += Int(offset.height)
        }
    }
    
    func scaleEmoji(_ emoji : EmojiArt.Emoji, by scale : CGFloat) {
        if let index = emojiArt.emojis.firstIndex(matching: emoji){
            emojiArt.emojis[index].size = Int((CGFloat(emojiArt.emojis[index].size) * scale).rounded(.toNearestOrEven))
        }
    }
    
    func setBackgroundURL(_ url : URL?){
        emojiArt.backgroundURL = url?.imageURL
        fetchBackgroundImageData()
    }
    
    private func fetchBackgroundImageData() {
        backgroundImage = nil // clear old background to show suddenly respond
        if let url = self.emojiArt.backgroundURL {
                
            DispatchQueue.global(qos: .userInitiated).async {
                if let imageData = try? Data(contentsOf: url){
                    // try : prepare for internet error, timeout bra bra
                    // if error just return nil
                    // imageData can be jpeg/png bra bra
                    DispatchQueue.main.async {
                        if url == self.emojiArt.backgroundURL {
                            self.backgroundImage = UIImage(data: imageData )
                            print("Loaded")
                        }
                    }
                    
                }
            }
           
        }
    }
}

extension EmojiArt.Emoji {
    var fontSize : CGFloat { CGFloat(self.size) }
    var location : CGPoint { CGPoint(x : CGFloat(x), y : CGFloat(y))}
}
