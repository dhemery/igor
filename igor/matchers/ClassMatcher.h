//
//  ClassSelector.h
//  
//
//  Created by Dale Emery on 11/18/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "Matcher.h"

@protocol ClassMatcher <Matcher>

@property(retain,readonly) Class matchClass;

@end
