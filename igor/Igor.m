#import "Igor.h"
#import "QueryParser.h"
#import "TreeWalker.h"
#import "QueryScanner.h"
#import "StringQueryScanner.h"
#import "ChainParser.h"
#import "InstanceParser.h"
#import "ClassParser.h"
#import "PredicateParser.h"
#import "BranchParser.h"
#import "DescendantCombinatorParser.h"

@implementation Igor

@synthesize parser;

- (NSArray *)findViewsThatMatchMatcher:(id <Matcher>)matcher inTree:(UIView *)tree {
    NSMutableSet *matchingViews = [NSMutableSet set];
    void (^collectMatches)(UIView *) = ^(UIView *view) {
        if ([matcher matchesView:view]) {
            [matchingViews addObject:view];
        }
    };
    [TreeWalker walkTree:tree withVisitor:collectMatches];
    return [matchingViews allObjects];
}

- (NSArray *)findViewsThatMatchQuery:(NSString *)query inTree:(UIView *)tree {
    id <QueryScanner> scanner = [StringQueryScanner scannerWithString:query];
    id <Matcher> matcher = [parser parseMatcherFromScanner:scanner];
    return [self findViewsThatMatchMatcher:matcher inTree:tree];
}

+ (Igor *)igor {
    id <PatternParser> classParser = [ClassParser new];
    id <PatternParser> predicateParser = [PredicateParser new];
    NSArray *simplePatternParsers = [NSArray arrayWithObjects:classParser, predicateParser, nil];

    id <PatternParser> instanceParser = [InstanceParser parserWithSimplePatternParsers:simplePatternParsers];

    NSArray *combinatorParsers = [NSArray arrayWithObject:[DescendantCombinatorParser new]];
    ChainParser *chainParser = [ChainParser parserWithCombinatorParsers:combinatorParsers];
    id <PatternParser> branchParser = [BranchParser parserWithChainParser:chainParser];
    NSArray *subjectParsers = [NSArray arrayWithObjects:instanceParser, branchParser, nil];
    chainParser.subjectParsers = subjectParsers;

    id <PatternParser> parser = [QueryParser parserWithChainParser:chainParser];

    return [self igorWithParser:parser];
}

+ (Igor *)igorWithParser:(id <PatternParser>)parser {
    return [[self alloc] initWithParser:parser];
}

- (Igor *)initWithParser:(id <PatternParser>)theParser {
    self = [super init];
    if (self) {
        parser = theParser;
    }
    return self;
}

- (NSArray *)selectViewsWithSelector:(NSString *)query {
    UIView *tree = [[UIApplication sharedApplication] keyWindow];
    return [self findViewsThatMatchQuery:query inTree:tree];
}

@end
