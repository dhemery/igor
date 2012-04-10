@protocol SubjectMatcher;
@class IgorQueryScanner;

@interface IgorQueryParser

+ (id <SubjectMatcher>)parse:(IgorQueryScanner *)query;

@end
