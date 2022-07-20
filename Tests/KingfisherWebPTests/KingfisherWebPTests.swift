import XCTest
import Kingfisher
@testable import KingfisherWebP

final class KingfisherWebPTests: XCTestCase {
    func testExample() throws {
        KingfisherManager.shared.defaultOptions += [
            .processor(WebPImageProcessor.default),
            .cacheSerializer(WebPCacheSerializer.default)
        ]
    }
}
