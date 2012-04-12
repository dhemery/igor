@class PredicateMatcher;
@protocol IgorQueryScanner;

@interface PredicateParser : NSObject

- (void)parsePredicateMatcherFromQuery:(id<IgorQueryScanner>)query intoArray:(NSMutableArray *)matchers;

+ (PredicateParser *)parser;

@end
