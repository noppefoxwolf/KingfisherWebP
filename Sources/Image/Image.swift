import Kingfisher
import Foundation
import ImageIO
import UniformTypeIdentifiers

private var animatedWebPImageDataKey: Void?

// MARK: - Image Properties
extension KingfisherWrapper where Base: KFCrossPlatformImage {
    private(set) var animatedWebPImageData: Data? {
        get { return getAssociatedObject(base, &animatedWebPImageDataKey) }
        set { setRetainedAssociatedObject(base, &animatedWebPImageDataKey, newValue) }
    }
}

// MARK: - Image Representation
extension KingfisherWrapper where Base: KFCrossPlatformImage {
    /// Returns WebP representation of `base` image.
    ///
    /// - Returns: Original WebP data of image.
    func webpRepresentation() -> Data? {
        base.kf.animatedWebPImageData
    }
}

// MARK: - Create image from WebP data
extension KingfisherWrapper where Base: KFCrossPlatformImage {
    static func image(data: Data, scale: Double, options: ImageCreatingOptions) -> KFCrossPlatformImage? {
        let info: [String: Any] = [
            kCGImageSourceShouldCache as String: true,
            kCGImageSourceTypeIdentifierHint as String: UTType.webP.identifier
        ]
        guard let imageSource = CGImageSourceCreateWithData(data as CFData, info as CFDictionary) else { return nil }
        let frameCount = CGImageSourceGetCount(imageSource)
        if (frameCount == 0) {
            return nil
        }
        
        if (frameCount == 1 || options.onlyFirstFrame) {
            guard let cgImage = CGImageSourceCreateImageAtIndex(imageSource, 0, nil) else {
                return nil
            }
            let image = KFCrossPlatformImage(cgImage: cgImage, scale: scale, orientation: .up)
            image.kf.imageFrameCount = Int(frameCount)
            image.kf.animatedWebPImageData = data
            return image
        }
        
        let cgFrames: [CGImage] = (0..<frameCount).compactMap({ CGImageSourceCreateImageAtIndex(imageSource, $0, nil) })
        let uiFrames: [KFCrossPlatformImage] = cgFrames.map { KFCrossPlatformImage(cgImage: $0, scale: scale, orientation: .up) }
        
        let duration: TimeInterval
        if let properties = CGImageSourceCopyProperties(imageSource, nil) as? [String: Any],
           let webPProperties = properties["{WebP}"] as? [String : Any],
           let frameInfo = webPProperties[kCGImagePropertyWebPFrameInfoArray as String] as? [[String : Double]] {
            duration = frameInfo.compactMap({ $0[kCGImagePropertyWebPDelayTime as String] }).reduce(0, +)
        } else {
            duration = 0.1 * TimeInterval(frameCount)
        }
        let image = KFCrossPlatformImage.animatedImage(with: uiFrames, duration: duration)
        image?.kf.imageFrameCount = Int(frameCount)
        image?.kf.animatedWebPImageData = data
        return image
    }
}
