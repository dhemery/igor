@protocol SubjectMatcher;

@protocol IgorQueryParser <NSObject>

- (id <SubjectMatcher>)parseMatcherFromQuery:(NSString *)query;

@end