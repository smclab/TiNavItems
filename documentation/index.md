# TiNavItems Module

## Description

Multiple rightNavItems for your windows! (iOS only)

## Usage

```js
var button1 = Ti.UI.createButton({
	title: 'Flic'
});

var button2 = Ti.UI.createButton({
	title: 'Floc'
});

var window = Ti.UI.createWindow({
	rightNavItems: [ button1, button2 ]
});
```

##Caveats

Currently only `rightNavItems` on `Ti.UI.Window`s is supported. Support for `leftNavItems` is on the way for `0.2.0`. Full support for PopOvers and others is scheduled for `0.3.0`.

## Author

Humbly made by the spry ladies and gents at SMC.

## License
This library, TiNavItems, is free software ("Licensed Software"); you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; including but not limited to, the implied warranty of MERCHANTABILITY, NONINFRINGEMENT, or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
