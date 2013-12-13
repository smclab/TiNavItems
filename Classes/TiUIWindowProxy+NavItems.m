//
//  TiUIWindowProxy+NavItems.m
//  TiNavItems
//
//  Created by pier on 12/12/13.
//
//

#import "TiBase.h"
#import "TiComplexValue.h"
#import "TiUIWindowProxy.h"
#import "TiUIWindowProxy+NavItems.h"

@implementation TiUIWindowProxy (NavItems)


#define SETPROPOBJ(m,x) \
{\
	id value = [self valueForKey:m]; \
	if (value!=nil)\
	{\
		if ([value isKindOfClass:[TiComplexValue class]])\
		{\
			TiComplexValue *cv = (TiComplexValue*)value;\
			[self x:(cv.value==[NSNull null]) ? nil : cv.value withObject:cv.properties];\
		}\
		else {\
			[self x:(value==[NSNull null]) ? nil : value withObject:nil];\
		}\
	}\
	else {\
		[self replaceValue:nil forKey:m notification:NO];\
	}\
}\


-(void)setupWindowDecorationsForMultipleItems;
{
	NSLog(@"[ERROR] YYY 1");
	
	if ((controller == nil) || ([controller navigationController] == nil))
	{
		NSLog(@"[ERROR] YYY 2");
		return;
	}
	
	/*SETPROPOBJ(@"leftNavItems", setLeftNavItems)*/
	SETPROPOBJ(@"rightNavItems", setRightNavItems)
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
			}
		}
	}
}


/*-(void)setRightNavItems:(NSArray *)newItems
{
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
				*/ /*
				 *        Note that this theoretically could mean proxies are improperly remembered
				 *        if a later entry causes this exception to be thrown. However, the javascript
				 *        should NOT be using nonproxy objects and the onus is on the Javascript
				 */ /*
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

	

	[self replaceValue:newItems forKey:@"rightNavItems" notification:NO];
}*/


/*-(void)setLeftNavItems:(id)proxy withObject:(id)properties;
{
	ENSURE_UI_THREAD_WITH_OBJ(setLeftNavItems, proxy, properties);

	DebugLog(@"[ERROR] Non male LEFT");
 }*/

-(void)setRightNavItems:(id)newItems withObject:(id)properties;
{
	[self setRightNavItems:newItems];
}


-(void)setRightNavItems:(id)newItems;
{
	ENSURE_TYPE_OR_NIL(newItems, NSArray);

	if (![NSThread isMainThread]) {
		id o = [NSArray arrayWithObjects:@"" "setRightNavItems", NULL_IF_NIL(newItems), nil];
		TiThreadPerformOnMainThread(^{
			[self _dispatchWithObjectOnUIThread:o];
		},NO);
		return;
	}
	
	NSLog(@"[ERROR] XXX 1");

	NSArray * oldItems = [self valueForUndefinedKey:@"rightNavItems"];
	
	if (![oldItems isKindOfClass:[NSArray class]])
	{
		NSLog(@"[ERROR] XXX 2");
		
		oldItems = nil;
	}

	BOOL newItemsIsArray = [newItems isKindOfClass:[NSArray class]];

	if (newItemsIsArray)
	{
		NSLog(@"[ERROR] XXX 3");

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
		NSLog(@"[ERROR] XXX 4");
		
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
				NSLog(@"[ERROR] XXX 7");

				UIBarButtonItem * item = [proxy barButtonItem];
				[array addObject:item];
			}
		}

		[controller.navigationItem setRightBarButtonItems:array];
		[array release];
	}
	
	[self replaceValue:newItems forKey:@"rightNavItems" notification:NO];
		
	/*if (controller != nil && [controller navigationController] != nil)
	{
		if (proxy == nil || [proxy supportsNavBarPositioning])
		{
			UIBarButtonItem * item = controller.navigationItem.rightBarButtonItem;

			if (item != nil && [item respondsToSelector:@selector(proxy)])
			{
				TiViewProxy * p = (TiViewProxy *)[item performSelector:@selector(proxy)];
				[p removeBarButtonView];
			}

			controller.navigationItem.rightBarButtonItem = nil;
			
			if (proxy != nil)
			{
				BOOL animated = NO; // TODO

				[controller.navigationItem setRightBarButtonItems:newItems];
			}
		}
	}
	else {
		[self replaceValue:newItems forKey:@"rightNavItems" notification:NO];
	}*/
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
