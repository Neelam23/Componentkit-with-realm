#This is a documentation of ComponentKit-with-realm assignment
Following is the brief view of how I worked on this assignment.

#Part One was to first download and run the wildeguess example given on componentkit website to get an idea, what the app does.

1.	Second step was to take out this wildeguess app and make it as standalone app where I could plugin component kit framework and realm framework. So I faced first challenge here - lack of documentation. There is only one example, which tells about running the componentkit, but no further examples about how to actually work with this kit. I found help from following source regarding this issue, which directed me to a Github project. This project gave me an idea about how to structure the app and add component kit.
Missing basic examples (Where to start after getting-started) https://github.com/facebook/componentkit/issues/220
Basic example https://github.com/MarcoSero/HackerNews
So, I figured that first I have to put the whole componentkit download bundle in project (app) and then link componentkit in framework and library. It’s necessary because componentkit looks for the header file in its bundle and throws compilation error otherwise.
 
#Part two was to add realm to this project-
For this, I referred (https://realm.io/docs/objc/latest/#getting-started ) official documentation to get started. Another good resources for realm was a Youtube talk. Even though it was for an older version, It gave me a good idea about how to work with realm https://www.youtube.com/watch?v=cGptaE2_WEQ ( he was working on static framework and I used going to do dynamic realm framework which doesn’t require C++ lib)

1.	After I integrated both the frameworks and made single app. I had some run-time issues and that was because of the image assests in the project (app icon and launch icon fix).
2.	Now, I added example code in appdelegate.mm file to run realm and see- how it creates database. So even though there was no error, it didn’t work. Later I found out that apart from including the realm. framework , it also has to be copied in the project structure.
3.	At this point all the integration was done and I was able to create the database with realm and run the app.


#Part Three: Third important was to create a model class or use existing model class of the app and replace the hardcoded quotes values with dynamically store and fetched DB values (quotes, author in this case)



Storing data

I tried to create new model class and used http://alcatraz.io/ url to download a script which helps in creating realm base classes with (cmd+new) for a new file.But then, I realized there is a model class already in the app and I should modify it. Following are changes I did to make the dynamic fetch of data.

•	First, I removed whole static data(commented). And decided to make a method to insert data into the database instead.

•	So I created a new method in QuoteModelController.m file and called it from application view controller to insert the data.

•	Challenge here was to isolate the quotes and authors so that I can use them as property of my realm database. I ended up making array of strings for both quote an authors.

•	Originally data was in a multilevel array format- each node had a {text, author} value. Like so-  [{text,author},{text,author}..]

•	I designed database like following- 
Schema/Entity (RealmObject) : RandomQuotesSchema
Property/field1: QuoteText
Property/field2: QuoteAuthor
 
•	My reasoning for this was to easily save and fetch the values from the DB

•	Next, I created a DB with these given values ( I didn’t get take any user inputs ) but my assumption is that this data is coming from front end or backend server and temporarily storing in device’s persistent storage as cache.

•	So, I am inserting these over and over but every time when the program runs the I clear the database like clearing cache and then start a fresh insert

•	Now Insert part is done  - Some issues faced here was regarding NSArray , RLMArray and defaultRealm and understanding all terminology. Realm has a lot of community help on stackoverflow which solved my issues here.



Fetching data dynamically
•	SO I am done with storing data in the database but now I have to get the data and show it in the front end of the app. I tried to use the same code and logic of wildeguess app. But it disnt work very well
•	Issue here is – Its easy to fetch data from realm database but it have a different result type RLMResults ,RLMArary etc and its not possible to change them to NSString , NSArray or NSDictionary.
•	So, I used the RLMResults for getting data and then passed the result properties into another classes, which helps in sending data back to view controlled, and display on the app view.
•	I solved the above compatibility issue by looking at how to query data from realm – I tried different ways and finally it worked. (This took a lot of time)
•	And one last thing that caused some issue was the generating random quotes. Because database gives back data in the same array sequence at it is stored and we cannot randomize it. Finally I worked around a little patch to randomize the array index when sending data back to view in the end.

Other issues:

Finding the DB folder of the simulator device and figuring out how to use and see data in realm browser
 
