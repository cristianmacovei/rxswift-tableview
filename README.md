# rxswift-tableview

Small project testing the syntax of RxSwift in creating a tableview without using delegate methods.

I defined an object MenuItems which have two properties: imageName and title, both of type String. There is no need for Assets, as I used the built-in xCode SF-Symbols.
The MenuItemViewModel initializes the items as a RxSwift-specific PublishSubject type that stores an array of our MenuItems. The onNext() function tells our items that the next collection is menuItems. The onCompleted() function tells our publisher that the observer is allowed to notify when data has changed and is completed.

In the ViewController class we then create the tableview similar to when using the delegate methods, but we only declare the tableView, where we directly register the cells with the identifier "cell".

The bindTableData then binds the aforementioned objects to each cell by passing the model.title and model.imageName attributes. The modelSelected function tells you what type of model you want to look for, by binding to the onNext. This will give back the menuItem that will be selected, that will be printed out in the console. 


Last but not least, we call the fetchItems() method, otherwise our tableView will show empty on the simulator. 
