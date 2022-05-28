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
		"7":17,
		"|":18,
		"Y":19,
		"o":20,
		"T":21,
		"L":32,
		"J":33,
		"v":34,
		"m":35,
		"_":37,
	}

	@WIDTH=8
	@HEIGHT=8

	@LETTERS={
		"a":{
			"",
			"r7",
			"Lv"
		},
		"b":{
			"^",
			"]7",
			"LJ"
		},
		"c":{
			"",
			"r>",
			"L>"
		},
		"d":{
			" ^",
			"r[",
			"LJ"
		},
		"e":{
			"",
			"r7",
			"L>"
		},
		"f":{
			"r>",
			"]>",
			"v"
		},
		"g":{
			"",
			"r7",
			"L[",
			"<J"
		},
		"h":{
			"^",
			"]7",
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
			"<J"
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
			"rT7",
			"vvv"
		},
		"n":{
			"",
			"r7",
			"vv"
		},
		"o":{
			"",
			"r7",
			"LJ"
		},
		"p":{
			"",
			"r7",
			"]J",
			"v"
		},
		"q":{
			"",
			"r7",
			"L[",
			" v"
		},
		"r":{
			"",
			"r>",
			"v"
		},
		"s":{
			"",
			"r>",
			"<J"
		},
		"t":{
			"^",
			"]>",
			"L>"
		},
		"u":{
			"",
			"^^",
			"Lv"
		},
		"v":{
			"",
			"^^",
			"LJ"
		},
		"w":{
			"",
			"^^^",
			"LmJ"
		},
		"x":{
			"",
			"oo",
			"oo"
		},
		"y":{
			"",
			"^^",
			"L[",
			"<J"
		},
		"z":{
			"",
			"<7",
			"L>"
		},
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
			for i=1,#row
				letter=row\sub(i,i)
				if letter!=" "
					spr(@@SYM_MAP[letter],x,y)
					rowwidth+=1
				x+=@@WIDTH
			y+=@@HEIGHT
			width=math.max(width,rowwidth)
		@x+=(width+xadj)*@@WIDTH
	
	s:(s)=>
		for i=1,#s
			@ch(s\sub(i,i))

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

	reset:=>
		super!
		music(MUSSPLASH,-1,-1,false)

	draw:=>
		super!
		cls(COLOR_BG)
		print("Splash screen", 30, 40)
		cf=ChunkyFont!
		cf.x=10
		cf.y=10
		cf\ch("a")
		cf\ch("b")
		cf\s("cdefghijklmn")
		cf.x=10
		cf.y=40
		cf\s("opqrstuvwxyz")

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
-- 000:9acaaaaa9aaaaaaa09aaaaaa009aaaaa009aaaaa09aaaaaa9accaaaa9acaaaaa
-- 001:aaaaaaa9aaaaaaa9aaaaaa90aaaaa900aaaaa900aaaaaa90aaaaaca9aaaaaaa9
-- 002:0099990009aaaa909accaaa99acaaaa99aaaaaa99aaaaaa99aaaaaa99acaaaa9
-- 003:0099999909aaaaaa9accaaac9acaaaaa9aaaaaaa9aaaaaaa09aaaaaa00999999
-- 004:99999999aaaaaaaaccccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999
-- 005:99999900aaaaaa90caaaaaa9aaaaaaa9aaaaaaa9aaaaaaa9aaaaaa9099999900
-- 006:9acaaaa99acaaaaa9acaaaac9acaaaaa9acaaaaa9acaaaaa9acaaaaa9acaaaa9
-- 007:9acaaaa9aacaaaa9ccaaaaa9aaaaaaa9aaaaaaa9aaaaaaa9aaaaaaa99acaaaa9
-- 016:0000099900099aaa009aaaac09accaaa09acaaaa9aaaaaaa9aaaaaaa9acaaaaa
-- 017:99900000aaa99000caaaa900aaaaaa90aaaaaa90aaaaaaa9aaaaaaa9aaaaaaa9
-- 018:9acaaaa99acaaaa99acaaaa99acaaaa99acaaaa99acaaaa99acaaaa99acaaaa9
-- 019:99000099aa9009aaaaa99accaaaaaacaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
-- 020:0099990009aaaa909accaaa99acaaaa99aaaaaa99aaaaaa909aaaa9000999900
-- 021:99999999aaaaaaaaccccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9acaaaa9
-- 032:9acaaaaa9aaaaaaa9aaaaaaa09aaaaaa09aaaaaa009aaaaa00099aaa00000999
-- 033:aaaaaaa9aaaaaaa9aaaaaaa9aaaaaa90aaaaaa90aaaaa900aaa9900099900000
-- 034:9acaaaa99aaaaaa99aaaaaa99aaaaaa99aaaaaa99aaaaaa909aaaa9000999900
-- 035:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99aaaaa9009aa99000099
-- 037:9acaaaa9aacaaaaaccaaaaacaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999
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

