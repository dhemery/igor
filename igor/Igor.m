//
//  Created by Dale Emery on 11/3/11.
//

#import "Igor.h"
#import "IgorParser.h"
#import "Matcher.h"
#import "TreeWalker.h"

@implementation Igor

-(NSArray*) findViewsThatMatchPattern:(NSString*)pattern fromRoot:(UIView*)root {
    id<Matcher> matcher = [[IgorParser new] parse:pattern];
    NSMutableSet* matchingViews = [NSMutableSet set];
    [[TreeWalker alloc] findViewsThatMatch:matcher fromRoot:root intoSet:matchingViews];
    return [matchingViews allObjects];
}

-(NSArray*) selectViewsWithSelector:(NSString*)pattern {
    return [self findViewsThatMatchPattern:pattern
                                  fromRoot:[[UIApplication sharedApplication] keyWindow]];
}

@end