//
//  TF_Singleton.h
//  StarCraftTV
//
//  Created by 고화영 on 2017. 11. 14..
//  Copyright © 2017년 HYKo. All rights reserved.
//

/**
 @brief .h 파일에 싱글톤을 정의하는 매크로
 @param __class 싱글톤으로 정의하려는 클래스
 @author HYKo
 */
#undef  AS_SINGLETON
#define AS_SINGLETON(__class) \
	+ (__class *)sharedInstance;

/**
 @brief .m 파일에 싱글톤을 구현하는 매크로
 @param __class 싱글톤으로 정의하려는 클래스
 @author HYKo
 */
#undef  DEF_SINGLETON
#define DEF_SINGLETON(__class) \
	+ (__class *)sharedInstance \
	{ \
		static dispatch_once_t once; \
		static __class *__singleton__; \
		dispatch_once(&once, ^{ \
			__singleton__ = [[__class alloc] init]; \
		}); \
		return __singleton__; \
	}


#undef  DEF_SINGLETON_XIB
#define DEF_SINGLETON_XIB(__class) \
	+ (__class *)sharedInstance \
	{ \
		static dispatch_once_t once; \
		static __class *__singleton__; \
		dispatch_once(&once, ^{ \
			__singleton__ = [[__class alloc] initWithNibName:NSStringFromClass([__class class]) bundle:nil]; \
		}); \
		return __singleton__; \
	}
