#import "SubjectMatcher.h"

@interface ComplexMatcher : NSObject<SubjectMatcher>

@property(nonatomic, strong) id <SubjectMatcher> head;
@property(nonatomic, strong) id <SubjectMatcher> subject;
@property(nonatomic, strong) id <SubjectMatcher> tail;

+ (ComplexMatcher *)withHead:(id <SubjectMatcher>)head subject:(id <SubjectMatcher>)subject;
+ (ComplexMatcher *)withHead:(id <SubjectMatcher>)head subject:(id <SubjectMatcher>)subject tail:(id <SubjectMatcher>)tail;
+ (ComplexMatcher *)withSubject:(id <SubjectMatcher>)subject;

@end
