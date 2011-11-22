//
//  ClassSelector.h
//  
//
//  Created by Dale Emery on 11/18/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "Matcher.h"

@interface ClassMatcher : NSObject<Matcher>

@property(retain,readonly) Class targetClass;

-(ClassMatcher*) initWithTargetClass:(Class)targetClass;

@end
