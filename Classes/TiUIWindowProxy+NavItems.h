//
//  TiUIWindowProxy+NavItems.h
//  TiNavItems
//
//  Copyright 2013 © SMC Treviso s.r.l.
//

#import "TiBase.h"
#import "TiUIWindowProxy.h"

@interface TiUIWindowProxy (NavItems)

-(void)cleanupWindowDecorationsForMultipleItems;

-(void)setupWindowDecorationsForMultipleItems;

-(void)setRightNavButton:(id)proxy withObject:(id)properties;

-(void)setRightNavItems:(id)newItems withObject:(id)properties;

-(void)viewWillAppear:(BOOL)animated;

-(void)viewWillDisappear:(BOOL)animated;

@end
