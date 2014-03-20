TiNavItems
==========

[![Built for Titanium SDK][ti-badge]][ti]
[![Available through gitTio][gittio-badge]][gittio-page]

[ti-badge]: http://www-static.appcelerator.com/badges/titanium-git-badge-sq.png
[ti]: http://www.appcelerator.com/titanium/
[gittio-badge]: http://gitt.io/badge.png
[gittio-page]: http://gitt.io/component/it.smc.navitems

Multiple `rightNavItems` for your windows! (iOS only)

### Installation

You can install this module using [gitTio][gittio-cli] with

    gittio install it.smc.navitems

Alternatively you can [download a specific release][rls] for manual installation.

[rls]: https://github.com/smclab/TiNavItems/releases
[gittio-cli]: http://gitt.io/cli

### Example

You can run the example running the following command

    gittio demo it.smc.navitems

The source for this demo application can be found in [the `example` folder][exm].

[exm]: https://github.com/smclab/TiNavItems/tree/master/example


Usage
-----

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

Caveats
-------

Currently only `rightNavItems` on `Ti.UI.Window`s is supported. Support for `leftNavItems` is on the way for `0.2.0`. Full support for PopOvers and others is scheduled for `0.3.0`.

Credits
-------

Humbly made by the spry ladies and gents at SMC.

License
-------

This library, *TiNavItems*, is free software ("Licensed Software"); you can
redistribute it and/or modify it under the terms of the [GNU Lesser General
Public License](http://www.gnu.org/licenses/lgpl-2.1.html) as published by the
Free Software Foundation; either version 2.1 of the License, or (at your
option) any later version.

This library is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; including but not limited to, the implied warranty of MERCHANTABILITY,
NONINFRINGEMENT, or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General
Public License for more details.

You should have received a copy of the [GNU Lesser General Public
License](http://www.gnu.org/licenses/lgpl-2.1.html) along with this library; if
not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth
Floor, Boston, MA 02110-1301 USA
