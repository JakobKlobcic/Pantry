# Pantry 
## Hackathon format
This was an app I built during a 24 hour hackathon. It involved me as the programmer and a product manager (PM). At the beginning of the event PM's presented ideas and developers got to pick which PM they want to work with. The one I picked had an idea I had already thought of a few years ago but never executed it, so conceptually I already knew how I would build it. 
## Idea
The idea for the app is to help prevent food in a persons kitchen from going bad.   
## Code & Functionality
This is a Flutter app with a Firebase backend. It has 4 views. 
1. List of all the food in ones pantry sorted by the experation date with the most recent on top. It also indicates how close the experation date is by the color of the date. Red->less tahn a week to experation; Orange -> less than two weeks; Green -> more than two weeks to experation. Swiping the item left deletes it right adds it to the shopping cart.
2. Adding the individual items to the pantry. It requires a name and experation date.
3. Shopping list. It is a simple list with check boxes for shopping convenience. Swiping the item to the left adds it to the Pantry list and swiping right deletes it.
4. Recepie list. In Firebase I added a few very simple recepies and look at the contents of the pantry. Then I would sort the Recepie list by comparing it to the available food in the pantry. 
