# Reasons

Sometimes, we maybe build some views repeatedly. Because we think that they just will be used under a condition. It's the curse
of breaking the rule: <b>DRY</b>. In fact, If we are conscious of view's reusing, we will make more efforts to make it
completely independent.

So for recording my growth, for writing less codes, for better tomorrow......

I should create this repository to summary some UI(cocoa Touch) extensions that are likely to be used in our work.

# Usage

## UIButtom + ImageAlignment

The code like this:

```swift
button.zon.setImage(image, imageAlignment: .top, spacing: 0, state: .normal)
```

Effect just like this:

![bottom image](https://github.com/ZeroOnet/Extensions/blob/master/Extensions/Display/bottom.png)
![left margin image](https://github.com/ZeroOnet/Extensions/blob/master/Extensions/Display/leftMargin.png)
![right margin image](https://github.com/ZeroOnet/Extensions/blob/master/Extensions/Display/rightMargin.png)
![top image](https://github.com/ZeroOnet/Extensions/blob/master/Extensions/Display/top.png)

## UIImage + QRCodeImage

A sample class func:

```swift
QRImageView.image = UIImage.zon.qrImage(content: "我(I) you 🤣", size: CGSize(width: 200, height: 200))
```

The QR code image as follows:<br></br>
![QR code image](https://github.com/ZeroOnet/Extensions/blob/master/Extensions/Display/QRCode.png)

## UIImageView + SaveImage

Save image of UIImageView to album by Photos:

```swift
imageView.zon.saveImage(completion: @escaping (Result<UIImage, Error>) -> Void)
```

## UIView + MenuTrigger

We need edit function, we need edit function, we need edit function, so:

```swift
myLabel.zon.asMenuTrigger([MenuItem(title: "test", action: #selector(testAction))])
```

<i><b>To be continue...</b></i>
