#import "Igor.h"
#import "ScanningIgorQueryParser.h"
#import "SubjectMatcher.h"
#import "TreeWalker.h"
#import "IgorQueryScanner.h"
#import "IgorQueryStringScanner.h"
#import "ScanningInstanceChainParser.h"
#import "InstanceParser.h"
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
    NSArray *simplePatternParsers = [NSArray arrayWithObjects:[ClassParser parserWithScanner:scanner], [PredicateParser parserWithScanner:scanner], nil];
    NSArray *subjectPatternParsers = [NSArray arrayWithObject:[InstanceParser parserWithSimplePatternParsers:simplePatternParsers]];
    id <InstanceChainParser> instanceChainParser = [ScanningInstanceChainParser parserWithScanner:scanner subjectPatternParsers:subjectPatternParsers];
    id <IgorQueryParser> parser = [ScanningIgorQueryParser parserWithScanner:scanner instanceParser:[subjectPatternParsers lastObject] instanceChainParser:instanceChainParser];
    return [self igorWithParser:parser];
}

+ (Igor *)igorWithParser:(id <IgorQueryParser>)parser {
    return [[self alloc] initWithParser:parser];
}

- (Igor *)initWithParser:(id <IgorQueryParser>)theParser {
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
