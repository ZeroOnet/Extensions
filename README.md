# Reasons

Sometimes, we maybe build some views repeatedly. Because we think that they just will be used under a condition. It's the curse
of breaking the rule: <b>DRY</b>. In fact, If we are conscious of view's reusing, we will make more efforts to make it
completely independent.

So for recording my growth, for writing less codes, for better tomorrow......

I should create this repository to summary some UI(cocoa Touch) extensions that are likely to be used in our work. 

# Usage

## UIButtom + ImageAlignment

The code like this:

```
button.setImage(image, imageAlignment: .top, spacing: 0, state: .normal)
```

Effect just like this:

![bottom image](https://github.com/ZeroOnet/UIExtensions/blob/master/UIExtensions/Display/bottom.png)
![left margin image](https://github.com/ZeroOnet/UIExtensions/blob/master/UIExtensions/Display/leftMargin.png)
![right margin image](https://github.com/ZeroOnet/UIExtensions/blob/master/UIExtensions/Display/rightMargin.png)
![top image](https://github.com/ZeroOnet/UIExtensions/blob/master/UIExtensions/Display/top.png)

## UIImage + QRCodeImage

A sample class func:

```
QRImageView.image = UIImage.qrImage(content: "我(I) you 🤣", size: CGSize(width: 200, height: 200))
```

The QR code image as follows:<br></br>
![QR code image](https://github.com/ZeroOnet/UIExtensions/blob/master/UIExtensions/Display/QRCode.png)

## UIImageView + SaveImage

In some cases, we need to save image to local. for example, user avatar, qr code......

`UIImageWriteToSavedPhotosAlbum` can help us finish it simply. But there is a point should be noticed: get current context graphics image and then save. You can use it like this under this extension:

```
imageView.saveImage(finishedHandler: ((UIImage) -> Void)? = nil, failedHandler: ((Error) -> Void)? = nil)
```

## UIView + MenuTrigger

We need edit function, we need edit function, we need edit function, so:

```
myLabel.asMenuTrigger([MenuItem(title: "test", action: #selector(testAction))])
```
UIImageView and UILabel contain default copy action.

<i><b>To be continue...</b></i>
