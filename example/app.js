
// Not necessary

require('it.smc.navitems');


// Creating the window

var window = Ti.UI.createWindow({
	title: 'Multiple items',

	// The `rightNavItems` is an array of views

	rightNavItems: [
		Ti.UI.createButton({
			title: 'Example'
		}),
		Ti.UI.createButton({
			title: 'Another one'
		})
	]
});


// Required as of Titanium SDK 3.2+

var navWindow = Ti.UI.iOS.createNavigationWindow({
	window: window
});

navWindow.open();
