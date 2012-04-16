@protocol Matcher;

@protocol SubjectPatternParser <NSObject>

- (id <Matcher>)parseSubjectMatcher;

@end