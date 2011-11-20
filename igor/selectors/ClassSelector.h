//
//  ClassSelector.h
//  
//
//  Created by Dale Emery on 11/18/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "Selector.h"

@interface ClassSelector : NSObject<Selector>

@property(retain,readonly) Class targetClass;
-(ClassSelector*) initWithTargetClass:(Class)targetClass;

@end
