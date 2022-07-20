import Foundation
import Kingfisher

public struct WebPImageProcessor: ImageProcessor {
    public static let `default` = WebPImageProcessor()
    
    public let identifier: String = "dev.noppe.WebPProcessor"
    
    public init() {}
    
    public func process(
        item: ImageProcessItem,
        options: KingfisherParsedOptionsInfo
    ) -> KFCrossPlatformImage? {
        switch item {
        case .image(let image):
            return image.kf.scaled(to: options.scaleFactor)
        case .data(let data):
            if data.isWebPFormat {
                return KingfisherWrapper<KFCrossPlatformImage>.image(
                    data: data,
                    scale: options.scaleFactor,
                    options: options.imageCreatingOptions
                )
            } else {
                return DefaultImageProcessor.default.process(
                    item: item,
                    options: options
                )
            }
        }
    }
}

