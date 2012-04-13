@protocol SubjectMatcher;

@protocol SubjectPatternParser <NSObject>

- (id<SubjectMatcher>)parseSubjectMatcher;

@end