# InvestmentTracker
#### Video Demo: https://www.youtube.com/watch?v=smFcLAd0qtg
#### GitHub Link: https://github.com/MrRonanX/InvestmentTracker
#### Description:

The purpose of this app is to track personal crypto investments. It consists of 3 screens and each screen has 1 subscreen. Information is saved locally using CoreData and Network Requests are completed via newsapi.org and apidapi.com. Most views are created using MMVM design paters - it consists of the view itself and the view model for that view.

The first screen is Overview Screen. It is built dynamically - if the user doesn't have active investments it prompts to switch to the next screen to add assets.
Otherwise, it shows the details about the owned crypto. It includes basic information + a candlestick chart. At the top of the screen, there is a delete button to erase this asset.
Below the screen title, there is a 'Get News' button. It queries newsapi.org for the currently shown crypto.
If there is more than 1 active investment this view is organized into a Page TabView. A user can scroll through the pages using a swipe.

The second screen is Add Investment Screen. It prompts the user to query the most popular cryptos from the list or to query some other crypto using the text field and search button.
The queried asses appear on the list with the updated price. A user can press 'Add' and a new screen will be presented modally with details about this crypto.
A user can edit the purchase price and date as they might have some investments before installing the app. Pressing on the 'Save' button will execute saving this crypto into the local CoreData storage.
It will determine if a user already owns this crypto and if yes it will sum up the shares and calculate the shared price.
If crypto was saved successfully a user will see an alert confirming the result and prompting them to visit Overview Screen to track added crypto.

The third screen is News Screen. There is a text field and search button. The user is prompted to type a query and execute the search request. A new screen will be presented with search results.
Every article is clickable and opens the article in the in-app Safari browser.

I plan to work more on this project and continue developing it. From the current point, these are the things that can be improved and added.
1. Homescreen Widget. I want to utilize Apple's Widget framework to present a candlestick graph and info about owned assets on the iPhone's main screen.
2. Add more error handling. 
3. Improve the algorithm that calculated the average price for the assets if they were bought at different price points.
4. Add a segmented control to present candlestick charts for different time ranges - hour, 4 hours, 12 hours.
5. Add more information about the asset. It should include the highest historical price, and buy dates.
6. Add more control to owned crypto - a user must be able to remove some of the owned shares, or add more from the home screen.

