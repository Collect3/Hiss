/* 
	Target Conditionals
*/

#import <TargetConditionals.h>

#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
#define IS_IOS 1
#else
#define IS_MAC 1
#define IS_OSX 1
#endif


/* 
 Logging
 */
#if TARGET_IPHONE_SIMULATOR
	#ifdef DEBUG
		#define ENABLE_LOGGING 1
	#endif
#endif

#if IS_MAC
	#ifdef DEBUG
		#define ENABLE_LOGGING
	#endif
#endif

#ifndef ENABLE_LOGGING
//    #define NSLog(key, ...)
#endif


/* 
 Convenience methods for creating formatted strings, dictionaries, arrays etc
 */ 
#define SF(format, ...) [NSString stringWithFormat: format, ## __VA_ARGS__]
#define DICT(key, ...) [NSDictionary dictionaryWithObjectsAndKeys:key, ## __VA_ARGS__, nil]
#define ARRAY(key, ...) [NSArray arrayWithObjects:key, ## __VA_ARGS__, nil]
#define NI(value) [NSNumber numberWithInteger: value]
#define NB(value) [NSNumber numberWithBool: value]

/*
 Frames
*/
#define RECT_IS_LANDSCAPE(rect) ((rect.size.width > rect.size.height) ? (YES) : (NO))


/* 
 Convenience methods for appending to a mutable string. 
 */
// Appends to local string
#define A(string, value) [string appendString: value]

// Appends to local string with format
#define ASF(string, format, ...) [string appendString: [NSString stringWithFormat:format,  ## __VA_ARGS__]]



/* 
 Logging and profiling
 */
#define DFLog(format, ...) NSLog(@"%s:%@", __PRETTY_FUNCTION__,[NSString stringWithFormat:format, ## __VA_ARGS__]);
#define MARK	DFLog(@"%s", __PRETTY_FUNCTION__);
#define START_TIMER NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
#define END_TIMER(msg) 	NSTimeInterval stop = [NSDate timeIntervalSinceReferenceDate]; NSLog([NSString stringWithFormat:@"%@ Time = %f", msg, stop-start]);
#define DEBUG_FRAME(description, frame) NSLog(@"[%@] X [%f] Y [%f] W [%f] H [%f]", description, frame.origin.x, frame.origin.y, frame.size.width, frame.size.height )
#define SFRAME(frame) SF(@"[%f,%f,%f,%f]", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height )

/* 
 Math / numbers stuff
 */
#define DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) / 180.0 * M_PI)
#define RADIANS_TO_DEGREES(__ANGLE__) ((__ANGLE__ * 180.0) / M_PI)
#define RADIANS_TO_DEGRESS(__ANGLE__) ((__ANGLE__ * 180.0) / M_PI)
// returns a random float between -1 and 1
#define RANDOM_MINUS1_1() ((random() / (float)0x3fffffff )-1.0f)
#define RANDOM_SIGNED_BETWEEN(min,num) (MAX((arc4random() % num), min) * (rand() % 2 == 0 ? 1 : -1))
#define RANDOM_UNSIGNED_BETWEEN(min,num) MAX((arc4random() % num), min)
/*
 Time
*/
#import <QuartzCore/QuartzCore.h>
#define CurrentTime() CACurrentMediaTime()
