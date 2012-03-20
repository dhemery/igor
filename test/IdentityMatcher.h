//
//  IdentityMatcher.h
//  igor
//
//  Created by Dale Emery on 3/20/12.
//  Copyright (c) 2012 Dale H. Emery. All rights reserved.
//

#import "Matcher.h"

@interface IdentityMatcher : NSObject<Matcher>

+(IdentityMatcher*) forView:(UIView*)view;

@end
