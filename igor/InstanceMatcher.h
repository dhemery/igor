#import "RelationshipMatcher.h"

@protocol ClassMatcher;
@protocol RelationshipMatcher;
@protocol SimpleMatcher;

@interface InstanceMatcher : NSObject <RelationshipMatcher>

@property(retain, readonly) id<ClassMatcher> classMatcher;
@property(retain, readonly) id<SimpleMatcher> predicateMatcher;

+ (InstanceMatcher *)withClassMatcher:(id<ClassMatcher>)classMatcher predicateMatcher:(id<SimpleMatcher>)predicateMatcher;

@end
