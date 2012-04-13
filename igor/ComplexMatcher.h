#import "SubjectMatcher.h"

@interface ComplexMatcher : NSObject <SubjectMatcher>

@property(strong, readonly) id <SubjectMatcher> head, subject, tail;

+ (ComplexMatcher *)matcherWithHead:(id <SubjectMatcher>)head subject:(id <SubjectMatcher>)subject;

+ (ComplexMatcher *)matcherWithHead:(id <SubjectMatcher>)head subject:(id <SubjectMatcher>)subject tail:(id <SubjectMatcher>)tail;

+ (ComplexMatcher *)matcherWithSubject:(id <SubjectMatcher>)subject;

+ (ComplexMatcher *)matcherWithSubject:(id <SubjectMatcher>)subject tail:(id <SubjectMatcher>)tail;
@end
