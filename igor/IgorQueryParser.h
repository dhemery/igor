@protocol SubjectMatcher;
@class IgorQueryScanner;

@interface IgorQueryParser

+ (id <SubjectMatcher>)matcherFromQuery:(IgorQueryScanner *)query;

@end
