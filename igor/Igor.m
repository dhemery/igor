#import "Igor.h"
#import "IgorPattern.h"
#import "RelationshipMatcher.h"
#import "TreeWalker.h"

@implementation Igor

- (NSArray *)findViewsThatMatchMatcher:(id <RelationshipMatcher>)matcher fromRoot:(UIView *)root {
    NSMutableSet *matchingViews = [NSMutableSet set];
    void (^collectMatches)(UIView *) = ^(UIView *view) {
        if ([matcher matchesView:view withinTree:root]) {
            [matchingViews addObject:view];
        }
    };
    [TreeWalker walkTree:root withVisitor:collectMatches];
    return [matchingViews allObjects];

}

- (NSArray *)findViewsThatMatchPattern:(NSString *)pattern fromRoot:(UIView *)root {
    id <RelationshipMatcher> matcher = [[IgorPattern forPattern:pattern] parse];
//    NSLog(@"Parsed pattern %@ into matcher %@", pattern, matcher);
    return [self findViewsThatMatchMatcher:matcher fromRoot:root];
}

- (NSArray *)selectViewsWithSelector:(NSString *)pattern {
    return [self findViewsThatMatchPattern:pattern
                                  fromRoot:[[UIApplication sharedApplication] keyWindow]];
}

@end