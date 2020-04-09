# NijiSaki-1st-Live-OpenSub

「虹ヶ咲学園スクールアイドル同好会」相关字幕脚本

## 总体说明  
本仓库的ASS文件及配套的程序代码等，遵循CC-BY-SA-4.0协议，鼓励保留署名情况下的共享和再次创作。 

## 字幕文件及压制说明  
1.由于使用了大量自定义函数(库)，为方便再次创作，我们打包了一份特殊版本的Aegisub(见[Release](https://github.com/qwe7989199/NijiSaki-1st-Live-OpenSub/releases))；  
2.由于使用了自定义的特效标签，VSFilterMod需要使用Vmoe编译版(by Vmoe 电脑迷97)；  
3.如果您尚不清楚Aegisub自动化的基本运作方式和各个代码片段的依赖关系，我们不建议对ASS字幕文件进行平移以外的操作(重新应用模板等)；  
4.为了效率和效果的最优化，建议严格按照下表进行字幕的挂载： 

|文件(歌曲)名|是否需要挂Mod压制|备注|
|-----------|---------------|----------|
|TOKIMEKI Runners|是|无| 
|夢への一歩|是|无| 
|開花宣言|是|无|  
|☆ワンダーランド☆|是|无| 
|ダイアモンド|否|无|
|オードリー|是|interval1-2是背景的钢琴演奏动画，如果需要，可用普通VSFilter最先挂载；FX1使用VSFilter挂载，FX2使用VSFilterMod挂载| 
|あなたの理想のヒロイン|是|BG(背景)先用普通VSFilter挂载，文本部分用Mod挂载|  
|友&愛|是|无|  
|めっちゃGoing!!|是|无| 
|ドキピポ☆エモーション|是|无|  
|テレテレパシー|是|无|  
|My Own Fairy-Tale|是|无|  
|眠れる森に行きたいな|是|无| 
|Evergreen|否|无| 
|声繋ごうよ|是|无| 
|Wish|是|无| 
|Starlight|是|VSF用VSFilter先挂载，Mod用VSFilterMod后挂载| 
|CHASE!|否|无|  
|MELODY|是|无|
|Love U my friends|否|无|


## BK字体和颜色整理  
|Character|1stアルバム Font|2ndアルバム Font|Color(HTML)|Color(ASS)|
|----|----------|----------|---|---|
|上原歩夢|TsukuMin-E|KikyouAStd-L|![#ff6b96](https://placehold.it/15/FF6B96/000000?text=+) `#FF6B96` |&H966BFF&|
|中須かすみ|A1Gothic|AokaneStd-EB|![#FFE658](https://placehold.it/15/ffe658/000000?text=+) `#FFE658` |&H58E6FF&|
|桜坂しずく||TsukuAOldMin-D|![#6AD2FF](https://placehold.it/15/6ad2ff/000000?text=+) `#6AD2FF` |&HFFD26A&|
|朝香果林|Didot+Mincho||![#96A2FF](https://placehold.it/15/96a2ff/000000?text=+) `#96A2FF` |&HFFA296&|
|宮下愛|GospelStd-EB|KafuNagomiStd-B|![#FFB153](https://placehold.it/15/ffb153/000000?text=+) `#FFB153` |&H53B1FF&|
|近江彼方|TsubameStd-R|ChiaroStd-B|![#C976FF](https://placehold.it/15/c976ff/000000?text=+) `#C976FF` |&HFF76C9&|
|優木せつな|DIN+Gothic|???+Gothic|![#FF464B](https://placehold.it/15/ff464b/000000?text=+) `#FF464B` |&H4B46FF&|
|エマ・ヴェルデ|TsukuCOldMin|SkipStd-B|![#79D834](https://placehold.it/15/79d834/000000?text=+) `#79D834` |&H34D879&|
|天王寺璃奈|Takarhythm|CometStd-B|![#61616F](https://placehold.it/15/61616f/000000?text=+) `#61616F` |&H6F6161&|
|表題曲|RodinMaria-B|MaruGothic|/|/|


备选
|Character|1stアルバム Font|2ndアルバム Font|Color(HTML)|Color(ASS)|
|----|----------|----------|---|---|
|上原歩夢|TsukuMin-E|KikyouAStd-L|![#F2A7B8](https://placehold.it/15/F2A7B8/000000?text=+) `#F2A7B8` |&HB8A7F2&|
|中須かすみ|A1Gothic|AokaneStd-EB|![#DFD00D](https://placehold.it/15/DFD00D/000000?text=+) `#DFD00D` |&H0DD0DF&|
|桜坂しずく||TsukuAOldMin-D|![#01B7ED](https://placehold.it/15/01B7ED/000000?text=+) `#01B7ED` |&HEDB701&|
|朝香果林|Didot+Mincho||![#4A5EC6](https://placehold.it/15/4A5EC6/000000?text=+) `#4A5EC6` |&HC65E4A&|
|宮下愛|GospelStd-EB|KafuNagomiStd-B|![#FF5800](https://placehold.it/15/FF5800/000000?text=+) `#FF5800` |&H0058FF&|
|近江彼方|TsubameStd-R|ChiaroStd-B|![#A664A0](https://placehold.it/15/A664A0/000000?text=+) `#A664A0` |&HA064A6&|
|優木せつな|DIN+Gothic|???+Gothic|![#D81C2F](https://placehold.it/15/D81C2F/000000?text=+) `#D81C2F` |&H2F1CD8&|
|エマ・ヴェルデ|TsukuCOldMin|SkipStd-B|![#84C36E](https://placehold.it/15/84C36E/000000?text=+) `#84C36E` |&H6EC384&|
|天王寺璃奈|Takarhythm|CometStd-B|![#61616F](https://placehold.it/15/61616f/000000?text=+) `#61616F` |&H6F6161&|
|表題曲|RodinMaria-B|MaruGothic|/|/|
