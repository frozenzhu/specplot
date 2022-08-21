# class Plot2D()

包含属性：
|属性|类型|描述|
|----|----|----|
|fig_title|str|图片标题|
|fig_save_path|str|图片存储路径，默认在脚本所在目录|
|fig_format|str|输出格式默认png|
|fig_dpi|int|图片dpi|
|fig_size|tuple|画布大小，默认(10,8)|
|colormap|str|默认jet| 
|color_level|numpy array|颜色色阶密度|
|contour_line_level|numpy array|轮廓线密度|
|line_color|str|轮廓线颜色，默认黑色|
|line_style|str|轮廓线风格，默认实线|
|xtick_direction|str|x轴刻线方向，默认向内|
|ytick_direction|str|y轴刻线方向，默认向内|
|xlabel|str|x轴标签|
|ylabel|str|y轴标签|
|colorbar_lable|str|colorbar标签|
|xmin|float|x轴起始值|
|xmax|float|x轴终止值|
|ymin|float|y轴起始值|
|ymax|float|y轴终止值|
|normalization|bool|是否归一化，默认False|
|file_path|str|文件读取路径|
|font|str|字体设置，默认Arial|
|title_fontsize|int|标题字号，默认30|
|lable_fontsize|int|坐标轴标签字号，默认28|
|tick_fontsize|int|刻度线标签字号，默认20|
|colorbar_tick_fontsize|int|colorbar刻度标签字号，默认16|
|fontweight|str|字重，默认bold|

