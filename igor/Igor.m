#import "Igor.h"
#import "IgorQueryParser.h"
#import "SubjectMatcher.h"
#import "TreeWalker.h"
#import "IgorQueryStringScanner.h"
#import "ScanningInstanceChainParser.h"

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
    id <IgorQueryScanner> scanner = [IgorQueryStringScanner withQueryString:query];
    id<InstanceChainParser> instanceChainParser = [ScanningInstanceChainParser withQueryScanner:scanner];
    IgorQueryParser* parser = [IgorQueryParser withQueryScanner:scanner instanceChainParser:instanceChainParser];
    id <SubjectMatcher> matcher = [parser nextMatcher];
    return [self findViewsThatMatchMatcher:matcher inTree:tree];
}

- (NSArray *)selectViewsWithSelector:(NSString *)query {
    UIView *tree = [[UIApplication sharedApplication] keyWindow];
    return [self findViewsThatMatchQuery:query inTree:tree];
}

@end