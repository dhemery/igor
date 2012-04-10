@class PredicateMatcher;
@class IgorQueryScanner;

@interface PredicateParser

+ (void)parse:(IgorQueryScanner *)query intoArray:(NSMutableArray *)matchers;

@end
