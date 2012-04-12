@protocol SubjectMatcher;

@protocol InstanceParser <NSObject>

- (id<SubjectMatcher>)parseInstanceMatcher;

@end