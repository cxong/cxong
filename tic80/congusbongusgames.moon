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
	-- LRUD: left/right/up/down
	-- T: T-junction (e.g. LT = points up, right and down)
	-- E: End (e.g. LE = points right only)
	-- HV: Horizontal/Vertical
	-- UL: Upper-Left corner (points right and down)
	@LT=0
	@RT=1
	@UE=2
	@LE=3
	@H=4
	@RE=5
	@UL=16
	@UR=17
	@V=18
	@UT=19
	@DL=32
	@DR=33
	@DE=34
	@DT=35

	@WIDTH=8
	@HEIGHT=8

	new:=>
		@x=0
		@y=0

	a:=>
		y=@y
		spr(@@UL,@x,y)
		y+=@@HEIGHT
		spr(@@V,@x,y)
		y+=@@HEIGHT
		spr(@@LT,@x,y)
		y+=@@HEIGHT
		spr(@@DE,@x,y)

		@x+=@@WIDTH
		y=@y
		spr(@@H,@x,y)
		y+=@@HEIGHT
		y+=@@HEIGHT
		spr(@@H,@x,y)

		@x+=@@WIDTH
		y=@y
		spr(@@UR,@x,y)
		y+=@@HEIGHT
		spr(@@V,@x,y)
		y+=@@HEIGHT
		spr(@@RT,@x,y)
		y+=@@HEIGHT
		spr(@@DE,@x,y)

		@x+=@@WIDTH


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
		cf.x=50
		cf.y=50
		cf\a!
		cf\a!

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
-- 016:0000099900099aaa009aaaac09accaaa09acaaaa9aaaaaaa9aaaaaaa9acaaaaa
-- 017:99900000aaa99000caaaa900aaaaaa90aaaaaa90aaaaaaa9aaaaaaa9aaaaaaa9
-- 018:9acaaaa99acaaaa99acaaaa99acaaaa99acaaaa99acaaaa99acaaaa99acaaaa9
-- 019:99000099aa9009aaaaa99accaaaaaacaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
-- 032:9acaaaaa9aaaaaaa9aaaaaaa09aaaaaa09aaaaaa009aaaaa00099aaa00000999
-- 033:aaaaaaa9aaaaaaa9aaaaaaa9aaaaaa90aaaaaa90aaaaa900aaa9900099900000
-- 034:9acaaaa99aaaaaa99aaaaaa99aaaaaa99aaaaaa99aaaaaa909aaaa9000999900
-- 035:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99aaaaa9009aa99000099
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

