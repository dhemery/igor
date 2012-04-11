#import "SubjectMatcher.h"

@interface ComplexMatcher : NSObject<SubjectMatcher>

@property(nonatomic, strong) NSArray* head;
@property(nonatomic, strong) id <SubjectMatcher> subject;
@property(nonatomic, strong) NSArray* tail;

+ (ComplexMatcher *)withSubject:(id <SubjectMatcher>)subject;
+ (ComplexMatcher *)withHead:(NSArray *)head subject:(id <SubjectMatcher>)subject tail:(NSArray *)tail;

+ (ComplexMatcher *)withHead:(NSArray *)head subject:(id <SubjectMatcher>)subject;
@end
