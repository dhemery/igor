@class PredicateMatcher;
@class IgorQueryScanner;

@interface PredicateParser

+ (PredicateMatcher *)parse:(IgorQueryScanner *)query;

@end
