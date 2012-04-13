#import "Igor.h"
#import "ScanningIgorQueryParser.h"
#import "SubjectMatcher.h"
#import "TreeWalker.h"
#import "IgorQueryScanner.h"
#import "IgorQueryStringScanner.h"
#import "ScanningInstanceChainParser.h"
#import "ScanningInstanceParser.h"
#import "ClassParser.h"
#import "PredicateParser.h"

@implementation Igor {
    id <IgorQueryParser> parser;
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
    id <SubjectMatcher> matcher = [parser parseMatcherFromQuery:query];
    return [self findViewsThatMatchMatcher:matcher inTree:tree];
}

+ (Igor *)igor {
    id <IgorQueryScanner> scanner = [IgorQueryStringScanner new];
    id <SimplePatternParser> predicateParser = [PredicateParser parserWithScanner:scanner];
    id <SimplePatternParser> classParser = [ClassParser parserWithScanner:scanner];
    id <InstanceParser> instanceParser = [ScanningInstanceParser parserWithClassParser:classParser predicateParser:predicateParser];
    id <InstanceChainParser> instanceChainParser = [ScanningInstanceChainParser parserWithScanner:scanner instanceParser:instanceParser];
    id <IgorQueryParser> parser = [ScanningIgorQueryParser parserWithScanner:scanner instanceParser:instanceParser instanceChainParser:instanceChainParser];
    return [self igorWithParser:parser];
}

+ (Igor*)igorWithParser:(id<IgorQueryParser>)parser {
    return [[self alloc] initWithParser:parser];
}

- (Igor *)initWithParser:(id<IgorQueryParser>)theParser {
    if (self = [super init]) {
        parser = theParser;
    }
    return self;
}

- (NSArray *)selectViewsWithSelector:(NSString *)query {
    UIView *tree = [[UIApplication sharedApplication] keyWindow];
    return [self findViewsThatMatchQuery:query inTree:tree];
}

@end
