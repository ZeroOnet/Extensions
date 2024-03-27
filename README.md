# Reasons

Sometimes, we maybe build some views repeatedly. Because we think that they just will be used under a condition. It's the curse
of breaking the rule: <b>DRY</b>. In fact, If we are conscious of view's reusing, we will make more efforts to make it
completely independent.

So for recording my growth, for writing less codes, for better tomorrow......

I should create this repository to summary some UI(cocoa Touch) extensions that are likely to be used in our work.

# List

## UIButton

- Set image alignment:

```swift
button.zon.setImage(image, imageAlignment: .top, spacing: 0, state: .normal)
```

Effect just like this:

![bottom image](https://github.com/ZeroOnet/ZExtensions/blob/master/ZExtensions/Display/bottom.png)
![left margin image](https://github.com/ZeroOnet/ZExtensions/blob/master/ZExtensions/Display/leftMargin.png)
![right margin image](https://github.com/ZeroOnet/ZExtensions/blob/master/ZExtensions/Display/rightMargin.png)
![top image](https://github.com/ZeroOnet/ZExtensions/blob/master/ZExtensions/Display/top.png)

## UIImage

- Generate QR code:

```swift
QRImageView.image = UIImage.zon.qrImage(content: "我(I) you 🤣", size: CGSize(width: 200, height: 200))
```

The QR code image as follows:<br></br>
![QR code image](https://github.com/ZeroOnet/ZExtensions/blob/master/ZExtensions/Display/QRCode.png)

- Rotate image with degree by clockwise.
- Compose image with color.
- Tint image with color.
- Read gif file.

## UIImageView

- Save image of UIImageView to album by Photos:

```swift
imageView.zon.saveImage(completion: @escaping (Result<UIImage, Error>) -> Void)
```

## UIView

- Edit action:

```swift
myLabel.zon.asMenuTrigger([MenuItem(title: "test", action: #selector(testAction))])
```

- Get view controller who contains itself by response chain.
- Shortcuts of frame.
- Hotspot. Expand or shrink user interaction area with AOP.
```swift
let button = UIButton()
// Expand(negative value) or shrink(positive value) extra hotspot area.
button.zon.extraArea = .init(top: 10, left:10, bottom: 10, right: 10)
// Specify minimum positive hotspot size. View will expand its bounds for Hit-Test equally to fit it.
button.zon.minimumSize = .init(width: 44, height: 44)
```
- Add gradient layer:
```swift
let view = UIView()
let layer = view.zon.gradientLayer // GradationSettable, view will add sublayer automatically.

protocol GradationSettable: AnyObject {
    var locations: [CGFloat] { get set }
    var colors: [UIColor] { get set }
    var startPoint: CGPoint { get set }
    var endPoint: CGPoint { get set }
}
```

- Make view highlighted like UIButton when you click:
```swift
view.zon.isHighlightEnabled = true
```
- Add touchUpInside event action like UIButton:
```swift
view.zon.onTouchUpInside {
    // do something.
}
```

## UIViewController

- The time interval of browsing view:

```swift
scene.zon.enableDurationTrack()
scene.zon.duration
```

- Add/Remove child.

## UINavigationController

- Get a visiable navigation controller can push and pop view controller.

## UIPasteboard

- Get/Set sring/image from background queue.

## UIStackView

- Remove all arranged views.
- Set layout padding and background color.

## UITableView

- Reuse
- Scroll to bottom.

## UICollectionView

- Reuse
- Scroll to bottom.

## UIColor

- Init color with hex string like: prefix -> #/0x, suffix -> RGB/RGBA/RRGGBB/RRGGBBAA.

<i><b>To be continue...</b></i>
