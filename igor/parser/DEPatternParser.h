@protocol DEMatcher;
@protocol DEQueryScanner;

@protocol DEPatternParser <NSObject>

- (id <DEMatcher>)parseMatcherFromScanner:(id <DEQueryScanner>)scanner;

@end