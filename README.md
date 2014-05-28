NSW
===
*An application for Carleton's New Student Week*

Note: Make sure to open ```NSW.xcworkspace``` **not** ~~```NSW.xcodeproj```~~, otherwise the app won't build

Checklist:
---
- [x] Complete ```NSWEvent```, ```Contact```, and ```CarlTerm``` models
- [x] DataSource classes for all of the above
- [x] Functional UI
- [x] Drawer-style navigation with [SWRevealController](https://github.com/John-Lluch/SWRevealViewController)

- [ ] Hunt down the evil character(s):trollface: that is(/are) [preventing us from decoding the ics file as proper UTF-8](https://github.com/BTIN/NSW/blob/master/NSW/EventDataSource.m#L29-L30):rage:
  - May be fixed by loading from local data :point_down:
- [ ] Get all the DataSources to download their network source files (ics, html, json) to local and read from local
  - Reload by checking if "date-modified" (probably not the actual term for that) was 1 day or more before current time
- [x] Get ```CarlTermDataSource``` reading from a file (waiting on Web Services to host and agree on data format)
- [x] Flesh out stub classes
- [x] COLORS 
- [ ] Write tests
- [x] Implement custom ```UITableViewCell``` subclass(es) for ContactVC (and CarlTermVC and maybe EventListVC)
  - [ ] Want accordian-style detail view without opening whole new view. (maybe learn from [Expandable-Collapsable-TableView](https://github.com/singhson/Expandable-Collapsable-TableView)?)
- [ ] About page

Suggestions:
---
- [ ] take away arrows from "Carl Speak"
- [ ] make events scrollable 
- [ ] change notification button color when selected
- [ ] swipe left and right animation on schedule days
- [ ] put arrows on each side of a day's title, so it would look like <- September 10 ->
- [ ] change "carl speak" icons
- [ ] have an actual splash screen
- [ ] display full names in "carl speak"
- [ ] be able to go to a day a few days over without having to swipe left or right all the way there
- [ ] constrain date to new student week
