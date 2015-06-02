# Ironhack-Blocks

# Exercises #

## Blocks ##

Understand how blocks work and make use of them

### Open project ###

Learn the basics.

1. Clone the repo
2. Open Models.xcworkspace with XCode
3. Have a look at the project and all the classes it has
4. Make sure you understand all the classes and how do they interact among them
5. Have a special look to the models `Movie` and `Show`. What is the difference with these models and the ones we created yesteday?
6. Have a look now at the ShowsTableViewController. How is the shows JSON being retrieved? How is it being stored into the file system? Shouldn't we have different classes for this?
7. We are going to refactor this code making good use of blocks. Should be fun!

### Our first block based API ###

1. Implement a new detail for TV Shows
    1. Add a UILabel for the description
    2. Add a UIImageView for the image
    3. Remove the code from `didSelectRowAtIndexPath:` method and show the new detail view controller
2. Add a like button (UIBarButtonItem) to the navigation toolbar
3. Create a UIBarButtonItem subclass and implement a block based callback API
    1. As UIBarButtonItems deal with selector we are good with a subclass UIBarButtonItem
    2. Think about the method definition, a custom init, that we would need to create our new custom bar button item. Which essential parameters do we need in our init method? Look at the documentation https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIBarButtonItem_Class/ on how to create a bar button item programmatically (hint: `initWithTitle:style:target:action:`)
    3. Think about having `typedef` for defining our blocks in the method header. Take a look at http://fuckingblocksyntax.com/ if you don't know how to typedef a block
    4. Basically, we will need to call somehow a block whenever the UIBarButtonItem's selector is fired. Take a look at the documentation of UIBarButtonItem and how does it deal with the target and the selector
    5. How are we going to store our block?
    6. Use our new fancy UIBarButtonItem in our detail view controller
    7. Use it also in the master view controler changing the two existing bar button items

### Getting serious with blocks ###

Learn how to convert a delegate based API into a block based API with categories

1. Show an alert view with the like confirmation within the block of our UIBarButtonItem
2. Transform the UIAlertViewDelegate into a block based api
    1. This time we would need a category on UIAlertView for transforming a delegate based api into a block based api
    2. Again, remember how a UIAlertView is normally built https://developer.apple.com/library/prerelease/ios/documentation/UIKit/Reference/UIAlertView_Class/index.html (`initWithTitle:message:delegate:cancelButtonTitle:otherButtonTitles:`)
    3. Think about having `typedef` for blocks
    4. How are we going to store our block? We can't have normal properties on categories. So how should we do it then?
    5. Have a look and read about associated objects http://www.sebastianrehnby.com/blog/2013/01/24/associated-objects-by-example/ in order to have properties on categories
    6. Remember to prefix our category methods http://nshipster.com/namespacing/
    7. Identify which case can create a retain cycle and avoid it
    8. Use our new block based api to show the alert view

### libextobjcWHAT? ###

Make use of the libextobjc library to deal with retain cycles

1. Check again the scenarios that could lead to retain cycles and solve them, if not done yet.
2. Add de libextobjc 0.x dependency on your Podfile. Run pod install to update the project
3. Make use of the @weafiky / @strongify macros

### Networking block based API ###

1. Add AFNetworking 2.x dependency on your Podfile. Run pod install after it.
2. Create a RequestManager subclass of NSObject (being a Facade http://en.wikipedia.org/wiki/Facade_pattern) that will internally compose AFNetworking GET requests
    1. First have a look at the class documentation: http://cocoadocs.org/docsets/AFNetworking/2.0.0/Classes/AFHTTPRequestOperationManager.html Which methods do we need to use?
    2. Think about our API. What should our method declaration look like? Which parameters does it need to have? (path string? blocks?)
    3. Within manager, make requests and return results and errors in a block based way.
3. Create a ShowsProvider class that internally uses the RequestManager to compose requests
    1. Think about our API. What should our method declaration look like? Which parameters does it need to have?
    2. Use the RequestManager to make requests. 
    3. Within the ShowsProvider parse and give back the shows
4. Use the ShowsProvider from the ShowsViewController to retrieve the shows. Do we need to avoid retain cycles?

