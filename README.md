NSW
===
*An application for Carleton's New Student Week*

Note: Make sure to open ```NSW.xcworkspace``` **not** ~~```NSW.xcodeproj```~~, otherwise the app won't build

Done:
---
- Mostly complete ```Event```, ```Contact```, and ```CarlTerm``` models
- Stubs of Event and Contact DataSources
- Stubs of Events, Contacts, "Speak Carleton" and Map UIs
- Tab bar navigation between various screens

To-Do:
---
- Implement ```CarlTermDataSource```(waiting on Web Services to host and agree on data format)
- Introduce ```MMDrawerController``` in place of ```UITabBarController``` (unfortunately, its more complex than just that)
- Flesh out stub classes
- Implement actual UI style standards to match mockups
- Write tests
- Implement custom ```UITableViewCell``` subclass(es) for ContactVC (and CarlTermVC and maybe EventListVC)
  - Want accordian-style detail view without changing scenesew view
