import SwiftUI
import Kingfisher
import KingfisherWebP

struct ContentView: View {
    
    init() {
        KingfisherManager.shared.cache.clearCache()
        KingfisherManager.shared.defaultOptions += [
            .processor(WebPImageProcessor.default),
            .cacheSerializer(WebPCacheSerializer.default)
        ]
    }
    
    var body: some View {
        KFAnimatedImage
            .url(Bundle.main.url(forResource: "animated-webp-supported", withExtension: "webp"))
            .frame(width: 120, height: 120)
    }
}

