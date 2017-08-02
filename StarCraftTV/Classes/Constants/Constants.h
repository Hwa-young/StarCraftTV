//
//  Constants.h
//  StarCraftTV
//
//  Created by 고화영 on 2017. 5. 23..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#ifndef Constants_h
#define Constants_h


#endif /* Constants_h */

#define yYOUTUBEAPI @"AIzaSyAanh-c7aGoFdAEAX9Ie6QQXZBVQjpTrGg"
#define yITEMS      @"items"
#define ySNIPPETS   @"snippet"
#define yLOCALIZED  @"localized"
#define yTITLE      @"title"
#define yTHUMBNAILS @"thumbnails"
#define yDEFAULTS   @"default"
#define yURL        @"url"
#define yID         @"id"
#define yRESOURCEID @"resourceId"
#define yVIDEOID    @"videoId"
#define yCHANNELID  @"UCX1DpoQkBN4rv5ZfPivA_Wg"

// For Category Menu
#define CATEGORY_LEAGUE                 @"category_league"
#define CATEGORY_ZERG_PROGAMER          @"category_zerg"
#define CATEGORY_TERRAN_PROGAMER        @"category_terran"
#define CATEGORY_PROTOSS_PROGAMER       @"category_protoss"

// For Free Paid App
#define ISPAIDAPP [[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.starcraft.tv.app"] ? TRUE : FALSE

#if defined(ISPAIDAPP) == TRUE // DEBUG is not defined or defined to be 0
#define HEIGHT_BANNER 0
#else
#define HEIGHT_BANNER 0
#endif

#define PROGAMER_LIST   @"강구열,강도경,강민,고석현,고인규,구성훈,권수현,권오혁,기욤패트리,김구현,김기현,김남기,김대엽,김도우,김동건,김동수,김동우,김동준,김동진,김동현,김명운,김민구,김상욱,김성대,김성제,김세현,김승현,김유진,김윤중,김윤환,김재춘,김재훈,김정민,김정우,김창희,김태균,김택용,김현진,김환중,나경보,나도현,도재욱,마재윤,문성진,문준희,민찬기,박경락,박대경,박대만,박명수,박문기,박상우,박성균,박성준,박성훈,박세정,박수범,박신영,박영민,박용욱,박재영,박재혁,박정길,박정석,박정욱,박지수,박지호,박찬수,박태민,박현준,백동준,백영민,베르트랑,변길섭,변은종,변형태,서경종,서지훈,성학승,손승완,손주흥,손찬웅,송병구,신노열,신대근,신동원,신상문,신상호,신희승,심소명,안상원,염보성,오영종,오충훈,우정호,원종서,유병준,윤용태,윤종민,이경민,이병민,이성은,이승석,이승훈,이신형,이영한,이영호,이운재,이윤열,이재호,이재훈,이제동,이주영,이창훈,이학주,임동혁,임성춘,임요환,임정현,임정호,임진묵,임효진,장용석,장윤철,장진남,장진수,전상욱,전태규,전태양,정명훈,정재호,정종현,조병세,조병호,조용호,조일장,조정현,주진철,주현준,진영수,진영화,차명환,최연성,최인규,최호선,한동훈,한상봉,한승엽,한웅렬,허영무,홍진호"

#define ZERG_PROGAMER_LIST @"강도경,고석현,권수현,김기현,김남기,김도우,김동우,김동현,김명운,김민구,김상욱,김성대,김세현,김윤환,김재춘,김정우,나경보,마재윤,문성진,민찬기,박경락,박명수,박문기,박상우,박성균,박성준,박신영,박재혁,박지수,박찬수,박태민,박현준,변은종,서경종,성학승,신노열,신대근,신동원,신상문,심소명,염보성,윤종민,이성은,이승석,이영한,이영호,이재호,이제동,이주영,이창훈,임동혁,임정현,임정호,장진남,장진수,전상욱,정명훈,정재호,조용호,조일장,주진철,차명환,최호선,한상봉,홍진호"

#define PROTOSS_PROGAMER_LIST @"강민,권오혁,기욤패트리,김구현,김대엽,김동수,김성제,김승현,김유진,김윤중,김재훈,김태균,김택용,김환중,도재욱,문준희,박대경,박대만,박성훈,박세정,박수범,박영민,박용욱,박재영,박정길,박정석,박지호,백동준,백영민,손승완,손찬웅,송병구,신상호,오영종,우정호,유병준,윤용태,이경민,이승훈,이영호,이재훈,임성춘,임효진,장윤철,전태규,조병호,진영화,한동훈,허영무"

#define TERRAN_PROGAMER_LIST @"강구열,고인규,구성훈,김기현,김도우,김동건,김동준,김동진,김윤환,김정민,김창희,김현진,나도현,민찬기,박상우,박성균,박정욱,박지수,베르트랑,변길섭,변형태,서지훈,손주흥,신상문,신희승,안상원,염보성,오충훈,원종서,이병민,이성은,이신형,이영호,이운재,이윤열,이재호,이학주,임요환,임진묵,장용석,전상욱,전태양,정명훈,정종현,조병세,조정현,주현준,진영수,최연성,최인규,최호선,한승엽,한웅렬"

typedef enum {
    TAG_TRIBE_TERRAN        = 1000,
    TAG_TRIBE_PROTOSS,
    TAG_TRIBE_ZERG,
} TRIBE_TYPE;








