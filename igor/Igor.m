#import "Igor.h"
#import "IgorQueryParser.h"
#import "SubjectMatcher.h"
#import "TreeWalker.h"
#import "IgorQueryScanner.h"

@implementation Igor

- (NSArray *)findViewsThatMatchMatcher:(id <SubjectMatcher>)matcher inTree:(UIView *)tree {
    NSMutableSet *matchingViews = [NSMutableSet set];
    void (^collectMatches)(UIView *) = ^(UIView *view) {
        if ([matcher matchesView:view inTree:tree]) {
            [matchingViews addObject:view];
        }
    };
    [TreeWalker walkTree:tree withVisitor:collectMatches];
    return [matchingViews allObjects];

}

- (NSArray *)findViewsThatMatchQuery:(NSString *)query inTree:(UIView *)tree {
    id <SubjectMatcher> matcher = [IgorQueryParser matcherFromQuery:[IgorQueryScanner withQuery:query]];
    return [self findViewsThatMatchMatcher:matcher inTree:tree];
}

- (NSArray *)selectViewsWithSelector:(NSString *)query {
    UIView *tree = [[UIApplication sharedApplication] keyWindow];
    return [self findViewsThatMatchQuery:query inTree:tree];
}

@end