## UsingPods 

UsingPods app uses Cocoapods to integrate some useful third party libraries into its workspace. The app uses the Flickr api 
search for a photo in a location. 

The Following libraries include: 
* Alamofire: for networking 
* SnapKit: for programmable autolayout
* Kingfisher: image caching 

**Note:** After cloning this project create the following Swift file named ```APIKeys.swift``` as it will be missing from your project and cause a compile time error: 

```swift
struct APIKeys {
    static let apiKey = "YOUR FLICKR API KEY GOES HERE"
}
```
