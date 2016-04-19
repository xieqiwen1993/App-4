
#ifndef App_UI_h
#define App_UI_h

#pragma mark - Color

#define COLORA(rgba) \
                     \
        [UIColor colorWithRed:(float)((rgba>>24)&0xFF)/255.0f \
                        green:(float)((rgba>>16)&0xFF)/255.0f \
                         blue:(float)((rgba>>8)&0xFF)/255.0f  \
                        alpha:(float)((rgba)&0xFF)/255.0f]

#define COLOR(rgb) \
                   \
        [UIColor colorWithRed:(float)((rgb>>16)&0xFF)/255.0f \
                        green:(float)((rgb>>8)&0xFF)/255.0f \
                         blue:(float)((rgb)&0xFF)/255.0f \
                        alpha:1]

#define COLOR_RANDOM [UIColor colorWithRed:arc4random()%255/255.0 \
									 green:arc4random()%255/255.0 \
									  blue:arc4random()%255/255.0 \
									 alpha:1.0]

#pragma mark - Font

#define FONT_YOOLI_50           [UIFont systemFontOfSize:50]
#define FONT_YOOLI_48           [UIFont systemFontOfSize:48]
#define FONT_YOOLI_42           [UIFont systemFontOfSize:42]
#define FONT_YOOLI_40           [UIFont systemFontOfSize:40]
#define FONT_YOOLI_39           [UIFont systemFontOfSize:39]
#define FONT_YOOLI_36           [UIFont systemFontOfSize:36]
#define FONT_YOOLI_32           [UIFont systemFontOfSize:32]
#define FONT_YOOLI_30           [UIFont systemFontOfSize:30]
#define FONT_YOOLI_31           [UIFont systemFontOfSize:31]
#define FONT_YOOLI_29           [UIFont systemFontOfSize:29]
#define FONT_YOOLI_28           [UIFont systemFontOfSize:28]
#define FONT_YOOLI_24           [UIFont systemFontOfSize:24]
#define FONT_YOOLI_22           [UIFont systemFontOfSize:22]
#define FONT_YOOLI_20           [UIFont systemFontOfSize:20]
#define FONT_YOOLI_19           [UIFont systemFontOfSize:19]
#define FONT_YOOLI_18           [UIFont systemFontOfSize:18]
#define FONT_YOOLI_16           [UIFont systemFontOfSize:16]
#define FONT_YOOLI_14           [UIFont systemFontOfSize:14]
#define FONT_YOOLI_13           [UIFont systemFontOfSize:13]
#define FONT_YOOLI_12           [UIFont systemFontOfSize:12]
#define FONT_YOOLI_11           [UIFont systemFontOfSize:11]
#define FONT_YOOLI_10           [UIFont systemFontOfSize:10]
#define FONT_YOOLI_17           [UIFont systemFontOfSize:17]
#define FONT_YOOLI_15           [UIFont systemFontOfSize:15]

#define FONT_YOOLI_BOLD_18      [UIFont boldSystemFontOfSize:18]
#define FONT_YOOLI_BOLD_14      [UIFont boldSystemFontOfSize:14]

#pragma mark - Position

#define MARGIN_H_20         20
#define MARGIN_H_15         15
#define PADDING_H			5

#pragma mark - Size

#define FOOTER_BUTTON_HEIGHT 53
#define DEFAULT_BUTTON_WIDTH 67
#define DEFAULT_BUTTON_HEIGHT 28

#pragma mark - 不在规范中 但时目前用到的颜色

#define COLOR_YOOLI_LIGHT_GRAY_ALPHA  COLORA(0xacb0b330)
#define COLOR_YOOLI_DARK_BLUE   COLOR(0x0B4285)
#define COLOR_YOOLI_BLUE_ALPHA  COLORA(0x0079ff7f)
#define COLOR_YOOLI_GREEN       COLOR(0x00b650)
#define COLOR_YOOLI_WHITE       COLOR(0xffffff)
#define COLOR_WEB_PAGE_BG		COLOR(0xefefef)

#pragma mark - 设计规范

#pragma mark - 字色

#define COLOR_YOOLI_DARK_GRAY   COLOR(0x2e353b)
#define COLOR_YOOLI_GRAY        COLOR(0x69737b)
#define COLOR_YOOLI_LIGHT_GRAY  COLOR(0xa1acb4)
#define COLOR_YOOLI_GRAY_BUTTON	COLOR(0xd0d5d9)
#define COLOR_YOOLI_BLUE        COLOR(0x4e82d7)
#define COLOR_YOOLI_ORANGE      COLOR(0xfc8936)
#define COLOR_YOOLI_RED			COLOR(0xd35353)

#define COLOR_BG_APP            COLOR(0xf0f4f7)
#define COLOR_BG_NAVI           COLOR(0xf9f9f9)

#define COLOR_COUPON_INVAILD    COLOR(0xa1acb4)
#define COLOR_COUPON_DEFAULT    COLOR(0x44da5e)

#define COLOR_UNLOCK_BG			COLOR(0xf0f4f7)

#pragma mark - 边距

#define MARGIN_H_1      15
#define MARGIN_H_2      10      //数据过多时

#define MARGIN_V        10

#pragma mark - 标题栏

#define FONT_NAVI_TITLE         [UIFont systemFontOfSize:18]
#define COLOR_NAVI_TITLE        COLOR_YOOLI_DARK_GRAY

#define FONT_NAVI_BTN           [UIFont systemFontOfSize:16]
#define COLOR_NAVI_BTN          COLOR_YOOLI_BLUE

#pragma mark - 列表栏(cell)

#define HEIGHT_CELL_44          44
#define HEIGHT_CELL_55          55
#define HEIGHT_CELL_70          70
#define COLOR_CELL_SPLITTER     COLOR(0xe7eaed)
#define COLOR_CELL_SPLITTER_2     COLOR(0xc2c3c4)
#define COLOR_CELL_BG           COLOR(0xffffff)

#define HEIGHT_SECTION_HEADER_35 35

#pragma mark -  按钮

#define HEIGHT_CELL_BTN         HEIGHT_CELL_44
#define FONT_CELL_BTN           FONT_YOOLI_17

#define COLOR_CELL_BTN_GRAY     COLOR(0xb2b2b2)
#define COLOR_FONT_GRAY			COLOR(0xc2c2c2)


#pragma mark -  Segment

#define COLOR_SEGMENT_SELECT    COLOR_YOOLI_BLUE
#define COLOR_SEGMENT_HIGHLIGHT COLOR_YOOLI_BLUE_ALPHA
#define COLOR_SEGMENT_BORDER    COLOR_YOOLI_BLUE

#endif
