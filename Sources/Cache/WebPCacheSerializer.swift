import Kingfisher
import Foundation

public struct WebPCacheSerializer: CacheSerializer {
    public static let `default` = WebPCacheSerializer()
    
    public func data(with image: KFCrossPlatformImage, original: Data?) -> Data? {
        if let original = original, !original.isWebPFormat {
            return DefaultCacheSerializer.default.data(with: image, original: original)
        } else {
            return image.kf.normalized.kf.webpRepresentation()
        }
    }
    
    public func image(with data: Data, options: KingfisherParsedOptionsInfo) -> KFCrossPlatformImage? {
        WebPImageProcessor.default.process(item: .data(data), options: options)
    }
}

