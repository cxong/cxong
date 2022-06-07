-- title:   congusbongusgames
-- author:  congusbongus
-- desc:    intro screen
-- site:    cxong.github.io
-- license: MIT License
-- version: 0.1
-- script:  moon

WIDTH=240
HEIGHT=136
COLOR_BG=0
MUSSPLASH=0
MUSTEMPO=100
MUSSPD=3
FPS=60
MUSBEATTICKS=FPS*60/MUSTEMPO*MUSSPD/6
SFXNEXT=1

class ChunkyFont
	@SYM_MAP={
		"}":0,
		"{":1,
		"^":2,
		"<":3,
		"=":4,
		">":5,
		"]":6,
		"[":7,
		"r":16,
		"?":17,
		"|":18,
		"Y":19,
		"o":20,
		"T":21,
		"P":22,
		"7":23,
		"6":32,
		"j":33,
		"v":34,
		"m":35,
		"_":37,
		"L":38,
		"J":39,
	}

	@WIDTH=8
	@HEIGHT=8

	@LETTERS={
		"a":{
			"",
			"r?",
			"6v"
		},
		"b":{
			"^",
			"]?",
			"Lj"
		},
		"c":{
			"",
			"r>",
			"6>"
		},
		"d":{
			" ^",
			"r[",
			"6J"
		},
		"e":{
			"",
			"r?",
			"6>"
		},
		"f":{
			"r>",
			"]>",
			"v"
		},
		"g":{
			"",
			"r7",
			"6[",
			"<j"
		},
		"h":{
			"^",
			"]?",
			"vv"
		},
		"i":{
			"o",
			"^",
			"v"
		},
		"j":{
			" o",
			" ^",
			" |",
			"<j"
		},
		"k":{
			"^",
			"]>",
			"vo"
		},
		"l":{
			"^",
			"|",
			"v"
		},
		"m":{
			"",
			"PT?",
			"vvv"
		},
		"n":{
			"",
			"P?",
			"vv"
		},
		"o":{
			"",
			"r?",
			"6j"
		},
		"p":{
			"",
			"P?",
			"]j",
			"v"
		},
		"q":{
			"",
			"r7",
			"6[",
			" v"
		},
		"r":{
			"",
			"P>",
			"v"
		},
		"s":{
			"",
			"r>",
			"<j"
		},
		"t":{
			"^",
			"]>",
			"6>"
		},
		"u":{
			"",
			"^^",
			"6J"
		},
		"v":{
			"",
			"^^",
			"Lj"
		},
		"w":{
			"",
			"^^^",
			"6mj"
		},
		"x":{
			"",
			"oo",
			"oo"
		},
		"y":{
			"",
			"^^",
			"6[",
			"<j"
		},
		"z":{
			"",
			"<?",
			"6>"
		},
		"A":{
			"r=?",
			"]=[",
			"v v"
		},
		"B":{
			"P=?",
			"]={",
			"L=j"
		},
		"C":{
			"r=>",
			"|",
			"6=>"
		},
		"D":{
			"P=?",
			"| |",
			"L=j"
		},
		"E":{
			"P=>",
			"]=>",
			"L=>"
		},
		"F":{
			"P=>",
			"]>",
			"v"
		},
		"G":{
			"r=>",
			"|<7",
			"6=J"
		},
		"H":{
			"^ ^",
			"]=[",
			"v v"
		},
		"I":{
			"T",
			"|",
			"_"
		},
		"J":{
			"  ^",
			"^ |",
			"6=j"
		},
		"K":{
			"^ ^",
			"]={",
			"v v"
		},
		"L":{
			"^",
			"|",
			"L=>"
		},
		"M":{
			"PY7",
			"|v|",
			"v v"
		},
		"N":{
			"P?^",
			"|||",
			"v6J"
		},
		"O":{
			"r=?",
			"| |",
			"6=j"
		},
		"P":{
			"P=?",
			"]=j",
			"v"
		},
		"Q":{
			"r=?",
			"| |",
			"6=o"
		},
		"R":{
			"P=?",
			"]={",
			"v v"
		},
		"S":{
			"r=>",
			"6=?",
			"<=j"
		},
		"T":{
			"<T>",
			" |",
			" v"
		},
		"U":{
			"^ ^",
			"| |",
			"6=j"
		},
		"V":{
			"^ ^",
			"|rj",
			"Lj"
		},
		"W":{
			"^ ^",
			"|^|",
			"6mj"
		},
		"X":{
			"o o",
			" o",
			"o o"
		},
		"Y":{
			"^ ^",
			"6Yj",
			" v"
		},
		"Z":{
			"<=7",
			"r=j",
			"L=>"
		}
	}
	@WIDTHADJ={
		"j":-1
	}

	new:=>
		@x=0
		@y=0

	ch:(c)=>
		xadj=@@WIDTHADJ[c]
		if xadj==nil
			xadj=0
		width=0
		y=@y
		for row in *@@LETTERS[c]
			x=@x+xadj*@@WIDTH
			rowwidth=0
			hasletter=false
			for i=1,#row
				letter=row\sub(i,i)
				if letter!=" "
					hasletter=true
					spr(@@SYM_MAP[letter],x,y)
				if hasletter
					rowwidth+=1
				x+=@@WIDTH
			y+=@@HEIGHT
			width=math.max(width,rowwidth)
		@x+=(width+xadj)*@@WIDTH
	
	s:(s)=>
		x=@x
		for i=1,#s
			c=s\sub(i,i)
			if c=="\n"
				@x=x
				@y+=@@HEIGHT*4
			else
				@ch(c)

class State
	new:=>
		@tt=0
		@nextstate=self

	reset:=>
		@tt=0

	update:=>
		@tt+=1

	finish:=>return

	next:=>return self

	draw:=>return

class SkipState extends State
	new:(grace)=>
		super!
		@grace=grace

	finish:=>
		sfx(SFXNEXT)

	next:=>
		if @tt>@grace and (btnp(0) or btnp(1) or btnp(2) or btnp(3) or btnp(4) or btnp(5))
			@finish!
			@nextstate\reset!
			return @nextstate
		return self

class SplashState extends SkipState
	new:=>
		super(10)
		@len=250
		@texts={
			{t:0,tx:"con"},
			{t:1,tx:"congus"},
			{t:2,tx:"congus\nbon"},
			{t:3,tx:"congus\nbongus"},
			{t:4,tx:"congus\nbongus\ngames"},
		}

	reset:=>
		super!
		music(MUSSPLASH,-1,-1,false)

	draw:=>
		super!
		cls(COLOR_BG)
		print("Splash screen", 30, 40)
		tx=nil
		for text in *@texts
			if @tt<text.t*MUSBEATTICKS
				break
			tx=text.tx
		if tx!=nil
			cf=ChunkyFont!
			cf\s(tx)

	next:=>
		if @tt>=@len
			@finish!
			@nextstate\reset!
			return @nextstate
		return super!

class TitleState extends SkipState
	new:=>
		super(10)

	reset:=>
		super!
		music!	-- stop music

	finish:=>return

	draw:=>
		super!
		cls(COLOR_BG)
		print("This is the title screen! Press any key to go back to the splash screen", 30, 40)
		spr 1,60,60,14,3,0,0,2,2

splashState = SplashState!
titleState = TitleState!
splashState.nextstate = titleState
titleState.nextstate = splashState
state=splashState
state\reset!

export TIC=->
	state\update!
	state\draw!
	state=state\next!

-- <TILES>
-- 000:9acaaaa99aaaaaaa09aaaaac009aaaaa009aaaaa09aaaaaa9accaaaa9acaaaa9
-- 001:9acaaaa9aaaaaaa9caaaaa90aaaaa900aaaaa900aaaaaa90aaaaaca99aaaaaa9
-- 002:0099990009aaaa909accaaa99acaaaa99aaaaaa99aaaaaa99aaaaaa99acaaaa9
-- 003:0099999909aaaaaa9accaaac9acaaaaa9aaaaaaa9aaaaaaa09aaaaaa00999999
-- 004:99999999aaaaaaaaccccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999
-- 005:99999900aaaaaa90caaaaaa9aaaaaaa9aaaaaaa9aaaaaaa9aaaaaa9099999900
-- 006:9acaaaa99acaaaaa9acaaaac9acaaaaa9acaaaaa9acaaaaa9acaaaaa9acaaaa9
-- 007:9acaaaa9aacaaaa9ccaaaaa9aaaaaaa9aaaaaaa9aaaaaaa9aaaaaaa99acaaaa9
-- 016:0000099900099aaa009aaaac09accaaa09acaaaa9aaaaaaa9aaaaaaa9acaaaa9
-- 017:99900000aaa99000caaaa900aaaaaa90aaaaaa90aaaaaaa9aaaaaaa99aaaaaa9
-- 018:9acaaaa99acaaaa99acaaaa99acaaaa99acaaaa99acaaaa99acaaaa99acaaaa9
-- 019:99000099aa9009aacaa99accaaaaaacaaaaaaaaaaaaaaaaaaaaaaaaa9acaaaa9
-- 020:0099990009aaaa909accaaa99acaaaa99aaaaaa99aaaaaa909aaaa9000999900
-- 021:99999999aaaaaaaaccccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9acaaaa9
-- 022:999999999aaaaaaa9accaaac9acaaaaa9aaaaaaa9aaaaaaa9aaaaaaa9acaaaa9
-- 023:99999999aaaaaaa9ccccaaa9aaaaaaa9aaaaaaa9aaaaaaa9aaaaaaa99acaaaa9
-- 032:9acaaaa99aaaaaaa9aaaaaac09aaaaaa09aaaaaa009aaaaa00099aaa00000999
-- 033:9acaaaa9aaaaaaa9caaaaaa9aaaaaa90aaaaaa90aaaaa900aaa9900099900000
-- 034:9acaaaa99aaaaaa99aaaaaa99aaaaaa99aaaaaa99aaaaaa909aaaa9000999900
-- 035:9acaaaa9aacaaaaaccaaaaacaaaaaaaaaaaaaaaaaaa99aaaaa9009aa99000099
-- 037:9acaaaa9aacaaaaaccaaaaacaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999
-- 038:9acaaaa99acaaaaa9acaaaac9acaaaaa9aaaaaaa9aaaaaaa9aaaaaaa99999999
-- 039:9acaaaa9aaaaaaa9cacaaaa9aaaaaaa9aaaaaaa9aaaaaaa9aaaaaaa999999999
-- </TILES>

-- <WAVES>
-- 000:01358acefeca853101368acefeca8531
-- 001:0123456789abcdeffedcba9876543210
-- 002:0123456789abcdef0123456789abcdef
-- </WAVES>

-- <SFX>
-- 000:00000000000000001000300040004000500050007000700090009000a000a000c000d000e000e000f000e000e000e000e000e000e000e000e000e000377000000000
-- 001:0100417061c09100a100c100f100f100f100f100f100f100f100f100f100f100f100f100f100f100f100f100f100f100f100f100f100f100f100f100450000000300
-- </SFX>

-- <PATTERNS>
-- 000:400008100000000000000000b00006100000000000000000f00006100000000000000000b00006100000000000000000b00008100000000000000000000000400008000000000000022600000000000000000000000000000000000000000000100000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 001:00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000060000800000000000042260a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 002:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000800008022600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 003:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b22608000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- </PATTERNS>

-- <TRACKS>
-- 000:180301000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ec02df
-- </TRACKS>

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>

