# Reasons

Sometimes, We maybe build some views repeatedly. Because We think that they just will be used under a condition. It's the curse
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

The QR code image as follows:
![QR code image](https://github.com/ZeroOnet/UIExtensions/blob/master/UIExtensions/Display/QRCode.png)




<i><b>To be continue...</b></i>
