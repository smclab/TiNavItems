//
//  TiUIWindowProxy+NavItems.h
//  TiNavItems
//
//  Created by pier on 12/12/13.
//
//

#import "TiBase.h"
#import "TiUIWindowProxy.h"

@interface TiUIWindowProxy (NavItems)

-(void)cleanupWindowDecorationsForMultipleItems;

-(void)setupWindowDecorationsForMultipleItems;

-(void)setRightNavItems:(id)newItems withObject:(id)properties;

-(void)setRightNavItems:(id)newItems;

-(void)viewWillAppear:(BOOL)animated;

-(void)viewWillDisappear:(BOOL)animated;

@end
