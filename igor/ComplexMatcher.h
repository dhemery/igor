#import "SubjectMatcher.h"

@interface ComplexMatcher : NSObject<SubjectMatcher>

@property(strong, readonly) id <SubjectMatcher> head, subject, tail;

+ (ComplexMatcher *)withHead:(id <SubjectMatcher>)head subject:(id <SubjectMatcher>)subject;
+ (ComplexMatcher *)withHead:(id <SubjectMatcher>)head subject:(id <SubjectMatcher>)subject tail:(id <SubjectMatcher>)tail;
+ (ComplexMatcher *)withSubject:(id <SubjectMatcher>)subject;
+ (ComplexMatcher *)withSubject:(id <SubjectMatcher>)subject tail:(id <SubjectMatcher>)tail;
@end
