@protocol Matcher;

@protocol SubjectPatternParser <NSObject>

- (id <Matcher>)parseMatcher;

@end