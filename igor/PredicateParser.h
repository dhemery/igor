@protocol IgorQueryScanner;

@protocol PredicateParser <NSObject>

- (void)parsePredicateMatcherIntoArray:(NSMutableArray *)matchers;

@end