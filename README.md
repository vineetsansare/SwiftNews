# SwiftNews
This repo holds the code for SwiftNews POC for Loblaw.

## About App

This is a simple app which basically fetches the `swift news` items from Reddit API, and parses the JSON response into models which are `Codable` stucts & ultimately displaying it in a tableview. Every row is a news item which displays article title & thumbnail if available. On tapping any of the item, user can get into the detail screen and read the entire article.

## Note for the Reviewers

**Covered all required activities**
- [x] Object oriented programming approach - 
- [x] Good UI approach - _(MVC pattern followed, though I'm aware of MVVM, VIPER & other architectural design patterns too but I
- [x] Clear README.md that explains how the code and the test can be run and how the coverage reports can be generated

## Running the app

Once you have clonned the app to your local system, you can fire-up the app by opening _SwiftNews.xcworkspace_ file.

## Important Info 
> _To demonstrate that I also have knowledge on using Cocoapods, I'm using Alamofire for networking purpose, as its widely used and really nice library. However, I've also written an APIManager using NSURLSession for the sake of discussion if required._ 

## Orientation & universal support

- App can be run on both the orientations i.e. Landscape and Portrait
- App also runs on iPad
- App is tested on simulators of iPhone SE/X/Xs Max/iPad pro(10.5") running on iOS 12.4 

## App Architecture

On revieiwing the code the code-reviewers will notice that I've tried to keep the code as generic as possible and used the MVC design pattern & partly Protocol-oriented-programming. 

The folder structure is architected to keep the Network layer, UI layer, and App Constants modular for reuability.

**UI Structure**
* MainStoryboard has a MainViewController embeded in NavigationController & ArticleDetailsViewController
* MainViewController has UITableView
* ArticleDetailsViewController has UIImageView and UITextView embeded in a stackview
* The contentView of the cell has an label on uiimageview

**Views**
- **ProgressView** - It's a custom view to that shows that a task is in progress.

**Network structure**
- **DataObjects** - There is a BaseDO class which is the base class for calling APIs. It can be subclassed for every new APIs and configured as required.
- **RequestObjects** - This also has a BaseRequest class that can be subclassed for every API requests for holding request paramaters.
- **ResponseObjects** - Response objects are the codable structs and will be different for every API's response.
- **BusinessObjects** - Business objects can be the models required to hold some business data.

**Constants**
- **AppConstants** - It holds all the app constants
- **DOBOConstants** - It holds all the constants required during networking i.e. API calls.
