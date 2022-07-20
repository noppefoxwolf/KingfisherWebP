# KingfisherWebP

Kingfisher webp plugin completely using CoreGraphics (without libwebp).

# Example

```swift
KingfisherManager.shared.defaultOptions += [
    .processor(WebPImageProcessor.default),
    .cacheSerializer(WebPCacheSerializer.default)
]
```

# Requirements

- iOS 14.0+
- Swift 5.6

## Installation

### Swift Package Manager

- File > Swift Packages > Add Package Dependency
- Add https://github.com/noppefoxwolf/KingfisherWebP.git
- Select "Up to Next Major" with "0.0.1"

# License

KingfisherWebP is released under the MIT license. See LICENSE for details.
