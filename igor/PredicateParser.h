@class PredicateMatcher;
@class IgorQueryScanner;

@interface PredicateParser

+ (void)addPredicateMatcherFromQuery:(IgorQueryScanner *)query toArray:(NSMutableArray *)matchers;

@end
