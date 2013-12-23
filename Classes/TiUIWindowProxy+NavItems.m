/**
 * Copyright (c) 2013 SMC Treviso s.r.l. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */

#import "TiBase.h"
#import "TiComplexValue.h"
#import "TiUIWindowProxy.h"
#import "TiUIWindowProxy+NavItems.h"

@implementation TiUIWindowProxy (NavItems)


#define SETPROPOBJ_NAVITEMS(m,n,x) \
{\
	id value = [self valueForKey:m]; \
	id button = [self valueForKey:n]; \
	[self replaceValue:nil forKey:m notification:NO];\
	if (value != nil || button != nil)\
	{\
		if ([value isKindOfClass:[TiComplexValue class]])\
		{\
			TiComplexValue *cv = (TiComplexValue*)value;\
			[self x:(cv.value == [NSNull null]) ? nil : cv.value withObject:cv.properties];\
		}\
		else {\
			[self x:(value == [NSNull null]) ? nil : value withObject:nil];\
		}\
	}\
	else {\
		[self replaceValue:nil forKey:m notification:NO];\
	}\
}\


-(void)setupWindowDecorationsForMultipleItems;
{
	if ((controller == nil) || ([controller navigationController] == nil))
	{
		return;
	}

	SETPROPOBJ_NAVITEMS(@"rightNavItems", @"rightNavButton", setRightNavItems);
}


-(void)cleanupWindowDecorationsForMultipleItems;
{
	if ((controller == nil) || ([controller navigationController] == nil)) {
        return;
    }

	NSArray * rightBarItems = controller.navigationItem.rightBarButtonItems;
	
	if (rightBarItems != nil) {
		for (UIBarButtonItem * item in rightBarItems)
		{
			if ([item respondsToSelector:@selector(proxy)]) {
				TiViewProxy* p = (TiViewProxy*)[item performSelector:@selector(proxy)];
				[p removeBarButtonView];
				[self forgetProxy:p];
			}
		}
	}
}


-(void)setRightNavButton:(id)proxy withObject:(id)properties;
{
	[self replaceValue:proxy forKey:@"rightNavButton" notification:NO];
}


-(void)setRightNavItems:(id)newItems withObject:(id)properties;
{
	ENSURE_UI_THREAD_WITH_OBJ(setRightNavItems, newItems, properties);

	ENSURE_TYPE_OR_NIL(newItems, NSArray);

	if (properties == nil)
	{
		properties = [self valueForKey:@"rightNavSettings"];
	}
	else
	{
        [self setValue:properties forKey:@"rightNavSettings"];
    }

	TiViewProxy * rightNavButton = [self valueForKey:@"rightNavButton"];

	ENSURE_TYPE_OR_NIL(rightNavButton, TiViewProxy);

	if (newItems == nil && rightNavButton != nil)
	{
		newItems = [NSArray arrayWithObjects: rightNavButton, nil];
	}

	NSArray * oldItems = [self valueForUndefinedKey:@"rightNavItems"];

	if (![oldItems isKindOfClass:[NSArray class]])
	{
		oldItems = nil;
	}

	BOOL newItemsIsArray = [newItems isKindOfClass:[NSArray class]];

	if (newItemsIsArray)
	{
		for (TiViewProxy * currentItem in newItems)
		{
			if (![currentItem respondsToSelector:@selector(supportsNavBarPositioning)] ||
				![currentItem supportsNavBarPositioning])
			{
				NSString * errorString = [NSString stringWithFormat:@"%@ does not support being in a toolbar!", currentItem];
				[self throwException:errorString subreason:nil location:CODELOCATION];
			}

			if (![oldItems containsObject:currentItem])
			{
				[self rememberProxy:currentItem];
			}
		}
	}

	for (TiViewProxy * currentItem in oldItems) {
		if (newItemsIsArray && [newItems containsObject:currentItem]) {
			continue;
		}
		[self forgetProxy:currentItem];
	}

	if (controller != nil && [controller navigationController] != nil)
	{
		NSArray * existing = [controller toolbarItems];
		UINavigationController * ourNC = [controller navigationController];

		if (existing!=nil)
		{
			for (id current in existing)
			{
				if ([current respondsToSelector:@selector(proxy)])
				{
					TiViewProxy * p = (TiViewProxy *)[current performSelector:@selector(proxy)];
					[p removeBarButtonView];
				}
			}
		}

		NSMutableArray * array = [[NSMutableArray alloc] initWithObjects:nil];
		
		for (TiViewProxy * proxy in newItems)
		{
			if ([proxy supportsNavBarPositioning])
			{
				UIBarButtonItem * item = [proxy barButtonItem];
				[array addObject:item];
			}
		}

		NSArray * reversedArray = [[array reverseObjectEnumerator] allObjects];
		[controller.navigationItem setRightBarButtonItems:reversedArray];
		[array release];
	}
	
	[self replaceValue:nil forKey:@"rightNavButton" notification:NO];
	[self replaceValue:newItems forKey:@"rightNavItems" notification:NO];
}


-(void)viewWillAppear:(BOOL)animated;
{
    shouldUpdateNavBar = YES;
	[self setupWindowDecorations];
	[self setupWindowDecorationsForMultipleItems];
	[super viewWillAppear:animated];
}


-(void)viewWillDisappear:(BOOL)animated;
{
	shouldUpdateNavBar = NO;
	[self cleanupWindowDecorations];
	[self cleanupWindowDecorationsForMultipleItems];
	[super viewWillDisappear:animated];
}


@end
