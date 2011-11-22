//
//  ClassEqualsSelector.h
//  igor
//
//  Created by Dale Emery on 11/9/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "ClassMatcher.h"

@interface MemberOfClassMatcher : ClassMatcher

+(MemberOfClassMatcher*) forClass:(Class)targetClass;

@end
