# News-App
Simple iOS News App that shows the Latest Breaking News Of The Day written in Swift 4

## Preview
![Alt Text](https://media.giphy.com/media/dXiPEPf3vNdnhLl8cr/giphy.gif)

**Built with**
- Ios 11.4
- Xcode 9.4 

## Features
- **Get the Latest Breaking News of the Day using the [News API](https://newsapi.org/)**
- **Parse JSON Objects from ```API``` easily using [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON), and using [Alamofire](https://github.com/Alamofire/Alamofire) to handle ```HTTP Networking```**
- **Download News images Asynchronously using [SDWebImage](https://github.com/rs/SDWebImage)**
- **Click on News Article ```TableViewCell``` to open full article on the Web**
- **Handle ```JSON null values``` for the News Images with a placeholder image**

## Requirements
```swift
import Alamofire
import SwiftyJSON
import SDWebImage
```

**_Pod Files_**
```swift
  pod 'SwiftyJSON', '~> 4.0'
  pod 'Alamofire', '~> 4.6'
  pod 'SDWebImage', '~> 4.0' 
```
[SDWebImage](https://github.com/rs/SDWebImage)   
[SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)  
[Alamofire](https://github.com/Alamofire/Alamofire)   

## License
Standard MIT [License](https://github.com/johnnyperdomo/News-App/blob/master/LICENSE)
