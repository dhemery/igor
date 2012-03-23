#import "Igor.h"
#import "IgorPattern.h"
#import "RelationshipMatcher.h"
#import "TreeWalker.h"

@implementation Igor

- (NSArray *)findViewsThatMatchPattern:(NSString *)pattern fromRoot:(UIView *)root {
    id<RelationshipMatcher> matcher = [[IgorPattern forPattern:pattern] parse];
    NSMutableSet *matchingViews = [NSMutableSet set];
    void (^collectMatches)(UIView *) = ^(UIView *view) {
        if ([matcher matchesView:view withinTree:nil]) {
            [matchingViews addObject:view];
        }
    };
    [TreeWalker walkTree:root withVisitor:collectMatches];
    return [matchingViews allObjects];
}

- (NSArray *)selectViewsWithSelector:(NSString *)pattern {
    return [self findViewsThatMatchPattern:pattern
                                  fromRoot:[[UIApplication sharedApplication] keyWindow]];
}

@end