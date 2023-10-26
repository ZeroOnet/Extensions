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

![bottom image](https://github.com/ZeroOnet/Extensions/blob/master/Extensions/Display/bottom.png)
![left margin image](https://github.com/ZeroOnet/Extensions/blob/master/Extensions/Display/leftMargin.png)
![right margin image](https://github.com/ZeroOnet/Extensions/blob/master/Extensions/Display/rightMargin.png)
![top image](https://github.com/ZeroOnet/Extensions/blob/master/Extensions/Display/top.png)

## UIImage

- Generate QR code:

```swift
QRImageView.image = UIImage.zon.qrImage(content: "我(I) you 🤣", size: CGSize(width: 200, height: 200))
```

The QR code image as follows:<br></br>
![QR code image](https://github.com/ZeroOnet/Extensions/blob/master/Extensions/Display/QRCode.png)

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

## UITableView

- Reuse
- Scroll to bottom.

## UICollectionView

- Reuse
- Scroll to bottom.

<i><b>To be continue...</b></i>
