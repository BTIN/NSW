NSW
===
*An application for Carleton's New Student Week*

Note: Make sure to open ```NSW.xcworkspace``` **not** ~~```NSW.xcodeproj```~~, otherwise the app won't build

Done:
---
- Complete ```NSWEvent```, ```Contact```, and ```CarlTerm``` models
- All DataSources 95+% complete
- Functional
- Drawer-style navigation with [SWRevealController](https://github.com/John-Lluch/SWRevealViewController)

To-Do:
---
- Get ```CarlTermDataSource``` reading from a file (waiting on Web Services to host and agree on data format)
- ~~Flesh out stub classes~~
- COLORS 
- Write tests
- Implement custom ```UITableViewCell``` subclass(es) for ContactVC (and CarlTermVC and maybe EventListVC)
  - Want accordian-style detail view without opening whole new view. (maybe learn from [Expandable-Collapsable-TableView](https://github.com/singhson/Expandable-Collapsable-TableView)?)
