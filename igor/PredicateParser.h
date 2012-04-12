@class PredicateMatcher;
@protocol IgorQueryScanner;

@interface PredicateParser

+ (void)parsePredicateMatcherFromQuery:(id<IgorQueryScanner>)query intoArray:(NSMutableArray *)matchers;

@end
