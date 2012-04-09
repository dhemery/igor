#import "SubjectMatcher.h"

@protocol ClassMatcher;
@protocol SubjectMatcher;
@protocol SimpleMatcher;

@interface InstanceMatcher : NSObject <SubjectMatcher>

@property(retain, readonly) id<ClassMatcher> classMatcher;
@property(retain, readonly) id<SimpleMatcher> predicateMatcher;

+ (InstanceMatcher *)withClassMatcher:(id<ClassMatcher>)classMatcher predicateMatcher:(id<SimpleMatcher>)predicateMatcher;

@end
