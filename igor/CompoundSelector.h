//
//  CompoundSelector.h
//  igor
//
//  Created by Dale Emery on 11/18/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "Selector.h"

@interface CompoundSelector : NSObject<Selector>
@property(retain) NSMutableArray* simpleSelectors;
-(void) addSelector:(id<Selector>)selector;
@end
