#import "Igor.h"
#import "IgorQueryParser.h"
#import "SubjectMatcher.h"
#import "TreeWalker.h"
#import "IgorQueryScanner.h"
#import "IgorQueryStringScanner.h"
#import "ScanningInstanceChainParser.h"

@implementation Igor {
    id <InstanceChainParser> instanceChainParser;
    id <IgorQueryScanner> scanner;
}

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
    IgorQueryParser* parser = [IgorQueryParser withQueryScanner:scanner instanceChainParser:instanceChainParser];
    id <SubjectMatcher> matcher = [parser parseMatcherFromQuery:query];
    return [self findViewsThatMatchMatcher:matcher inTree:tree];
}

+ (Igor*)igorWithQueryScanner:(id<IgorQueryScanner>)scanner instanceChainParser:(id<InstanceChainParser>)instanceChainParser {
    return [[self alloc] initWithQueryScanner:scanner instanceChainParser:instanceChainParser];
}

+ (Igor *)igor {
    id <IgorQueryScanner> scanner = [IgorQueryStringScanner new];
    id <InstanceChainParser> instanceChainParser = [ScanningInstanceChainParser parser];
    return [self igorWithQueryScanner:scanner instanceChainParser:instanceChainParser];
}

- (Igor *)initWithQueryScanner:(id<IgorQueryScanner>)theScanner instanceChainParser:(id <InstanceChainParser>)theInstanceChainParser {
    if (self = [super init]) {
        instanceChainParser = theInstanceChainParser;
        scanner = theScanner;
    }
    return self;
}

- (NSArray *)selectViewsWithSelector:(NSString *)query {
    UIView *tree = [[UIApplication sharedApplication] keyWindow];
    return [self findViewsThatMatchQuery:query inTree:tree];
}

@end
