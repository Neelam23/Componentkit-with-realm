# This is a documentation of ComponentKit-with-realm assignment

Following is the brief view of how i worked on this assignment.

#1. Part One, First downloaded and ran the wildguess example given on component kit website to get an idea, what the app does. 

2. Second step was to take out this wildness app and make it as standalone app where I could plugin component kit framework and realm framework. So I faced first challenge here - lack of documentation. There is only one example which tells about running the component kit example but no further example about how to actually work with this kit. I found help from following source, which directed me to a github project- which gave me an idea about, how to structure the app and add component kit.


Missing basic examples (Where to start after getting-started)
https://github.com/facebook/componentkit/issues/220

Basic example
https://github.com/MarcoSero/HackerNews


So, I figured first put the whole componentkit download bundle in project and then put the componentkit.xproject in framework (because its external framework) —and then link componentkit in framework and library. Its necessary because componentkit looks for header file in the bundle.


# 3.part two was to add realm to this project-
For this, I referred (https://realm.io/docs/objc/latest/#getting-started official documentation) to get started. Another good resources for this was a youtube talk- even though it was for an older version. It gave a good idea how to started with realm 
https://www.youtube.com/watch?v=cGptaE2_WEQ ( he was working on static but I used going to do dynamic realm framework which doesn’t require c++ lib)


4. After I integrated both the framework and make single app. I had some run-time issues and It was because of the image assists in the project (app icon and launch icon fix).

5. Now, I added example code in appdelegate.mm file to run realm and see how it creates database. So even though there was no error, it didn’t work. Later I found out that apart from including the ream.framework , it also has to be copied in the project structure. 

6. At this point all the integration was done and I was able to create the database with realm. 


# 7. Third important was to create a model class or use existing model class of the app and replace the hardcoded quotes values with dynamically fetched DB values.

I tried to create new model class and used http://alcatraz.io/ url to download a script which helps in creating realm base classes with (cmd+new) for a new file.

But then, I realized there is a model class already in the app and I should modify it. Following are changes I did to make the dynamic fetch of data.

-First, I removed whole static data(commented). And decided to make a method to insert data into the database instead. 

- So I created a new method in QuoteModelController file and called it from application view controller.

- Challenge here was to isolate the quotes and authors so that I can use them as property of my realm database. I ended up making array of strings for both the things

-Originally data was in a multilevel array format- each node had a {text, author} value.
[{text,author},{text,author}..]

- I designed database like following 






