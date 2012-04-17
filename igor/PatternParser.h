@protocol Matcher;

@protocol PatternParser <NSObject>

- (id <Matcher>)parseMatcher;

@end