@class PredicateMatcher;
@protocol IgorQueryScanner;

@interface PredicateParser

+ (void)addPredicateMatcherFromQuery:(id<IgorQueryScanner>)query toArray:(NSMutableArray *)matchers;

@end
