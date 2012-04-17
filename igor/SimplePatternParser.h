@protocol IgorQueryScanner;
@protocol Matcher;

@protocol SimplePatternParser <NSObject>

- (id <Matcher>)parseMatcher;

@end
