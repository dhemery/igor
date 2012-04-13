@protocol SubjectMatcher;

@protocol SubjectPatternParser <NSObject>

- (BOOL)parseSubjectMatcherIntoArray:(NSMutableArray *)subjectMatchers;

@end