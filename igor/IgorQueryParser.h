@protocol SubjectMatcher;
@protocol IgorQueryScanner;


@interface IgorQueryParser

+ (id <SubjectMatcher>)matcherFromQuery:(id<IgorQueryScanner>)query;

@end
