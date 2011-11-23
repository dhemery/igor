//
//  PropertyMatcher.h
//  igor
//
//  Created by Dale Emery on 11/22/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "Matcher.h"

@protocol PropertyMatcher <Matcher>

@property(readonly,retain) NSString* matchProperty;

@end
