//
//  KindOfClassSelector.h
//  igor
//
//  Created by Dale Emery on 11/17/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "ClassMatcher.h"

@interface KindOfClassMatcher : NSObject<ClassMatcher>

+(id) forClass:(Class)targetClass;

@end
