function multi1()
	if j==1 then
		loop_i=0
		shapes_i=1
		loop_n=0
		loops={}
		for k=1,#shapes do
			if points_num(shapes[k].text) >= 70 then
				len=2+math.random(5,10)
				loop_n=loop_n+len
				loops[k]={len,3,{}}
			elseif points_num(shapes[k].text) >= 50 then
				loop_n=loop_n+1
				loops[k]={1,2,{}}
			else
				loop_n=loop_n+2
				loops[k]={2,1,{rst=math.random(-300,300)}}
			end
		end
	end
	maxloop(loop_n)
	loop_i=loop_i+1
	relayer(1)
	if loop_i > loops[1][1] then
		loop_i=loop_i-loops[1][1]
		shapes_i=shapes_i+1
		_G.table.remove(loops,1)
	end
	if loops[1][2] == 3 then
		if loop_i == 1 then
			retime("line",line.duration/2*syl.i/line.kara.n-300,-200+600*syl.i/line.kara.n)
			return string.format("{\\fad(100,300)\\pos(%d,%d)\\fsc0\\t(0,250,0.5,\\fsc120)\\t(250,400,\\fsc100)\\p1\\an7}%s",line.left+syl.left+shapes[shapes_i].x,line.top+shapes[shapes_i].y,shapes[shapes_i].text)
		elseif loop_i == 2 then
			relayer(4)
			retime("abs",line.start_time-300+line.duration/2*syl.i/line.kara.n,line.start_time-300+line.duration/2*syl.i/line.kara.n+600)
			local px=shapes[shapes_i].x+line.left+syl.left
			local py=shapes[shapes_i].y+line.top
			return string.format("{\\pos(%d,%d)\\shad0\\p1\\an7\\fad(50,200)\\alpha&H20&\\blur1\\bord0\\c&HFFFFFF&\\fsc50\\t(0,300,0.5,\\fsc120)\\t(300,600,2,\\fsc80)}%s",px,py,center_shapes[math.random(#center_shapes)])
		else
			relayer(math.random(0,2))
			local start_t=line.start_time-300+line.duration/2*syl.i/line.kara.n+math.random(300)
			local px=shapes[shapes_i].x+line.left+syl.left
			local py=shapes[shapes_i].y+line.top
			local r1=math.random(30,50)
			local r2=math.random(60,80)
			local theta=math.rad(math.random(360))
			retime("abs",start_t,start_t+math.random(400,700))
			return string.format("{\\p3\\an7\\fad(100,100)\\move(%d,%d,%d,%d)\\fr%d\\bord0\\blur0.5\\c%s\\alpha&H50&\\t(\\fr%d)}%s",math.round(px+r1*math.cos(theta)),math.round(py-r1*math.sin(theta)),math.round(px+r2*math.cos(theta)),math.round(py-r2*math.sin(theta)),math.random(100,130),_G.ass_color(_G.HSV_to_RGB(math.random(360),0.5,1)),abs_random(90,180),get_shape2(30,60))
		end
	elseif loops[1][2] == 2 then
		retime("line",line.duration/2*syl.i/line.kara.n-200+math.random(-300,300),-200+600*syl.i/line.kara.n)
		return string.format("{\\fad(300,300)\\pos(%d,%d)\\fscy0\\fscx150\\t(0,250,\\fscy130\\fscx80)\\t(250,400,\\fscy80\\fscx110)\\t(400,500,\\fscx100\\fscy100)\\p1\\an7}%s",line.left+syl.left+shapes[shapes_i].x,line.top+shapes[shapes_i].y,shapes[shapes_i].text)
	elseif loops[1][2] == 1 then
		relayer(3)
		if loop_i == loops[1][1] then
			retime("line",line.duration/2*syl.i/line.kara.n-200+loops[1][3].rst,-200+600*syl.i/line.kara.n)
			return string.format("{\\fad(200,300)\\pos(%d,%d)\\fsc200\\t(0,300,\\fsc100)\\p1\\an7}%s",line.left+syl.left+shapes[shapes_i].x,line.top+shapes[shapes_i].y,shapes[shapes_i].text)
		else
			retime("line",line.duration/2*syl.i/line.kara.n-200+loops[1][3].rst,-200+600*syl.i/line.kara.n)
			return string.format("{\\p1\\fad(200,300)\\an7\\bord3\\fsc350\\1a&HFF&\\3c%s\\blur3\\t(0,300,\\fsc100)\\shad0\\pos(%d,%d)}%s",_G.ass_color(_G.HSV_to_RGB(math.random(360),1,1)),line.left+syl.left+shapes[shapes_i].x,line.top+shapes[shapes_i].y,shapes[shapes_i].text)
		end
	end
end


function multi2()
	if j==1 then
		loop_i=0
		shapes_i=1
		loop_n=0
		loops={}
		for k=1,#shapes do
			if points_num(shapes[k].text) >= 80 then
				loop_n=loop_n+6
				loops[k]={6,3}
			elseif points_num(shapes[k].text) >= 40 then
				loop_n=loop_n+1
				loops[k]={1,2}
			else
				loop_n=loop_n+2
				loops[k]={2,1}
			end
		end
	end
	maxloop(loop_n)
	loop_i=loop_i+1
	relayer(1)
	if loop_i > loops[1][1] then
		loop_i=loop_i-loops[1][1]
		shapes_i=shapes_i+1
		_G.table.remove(loops,1)
	end
	if loops[1][2] == 3 then
		if loop_i == loops[1][1] then
			retime("line",-200+syl.start_time,-100+400*syl.i/line.kara.n)
			return string.format("{\\p1\\fscy0\\fscx150\\t(0,250,\\fscy130\\fscx80)\\t(250,400,\\fscy80\\fscx110)\\t(400,500,\\fscx100\\fscy100)\\fad(150,300)\\an7\\pos(%d,%d)\\blur2\\bord3}%s",line.left+syl.left+shapes[shapes_i].x,line.top+shapes[shapes_i].y,shapes[shapes_i].text)
		else
			relayer(math.random(0,2))
			retime("abs",line.start_time-200+syl.start_time,line.start_time-200+syl.start_time+math.random(500,1000))
			return string.format("{\\p1\\fad(100,300)\\an7\\bord0\\shad0\\fsc%d\\t(0,%d,\\fsc%d)\\t(\\fr%s)\\c%s\\move(%d,%d,%d,%d)}%s",math.random(4,8),line.duration/2,math.random(15,35),math.random(-200,200),_G.ass_color(_G.HSV_to_RGB(math.random(360),1,1)),line.left+syl.center,line.middle,math.round(line.left+syl.center+remember("r",math.random(50,70))*math.cos(remember("theta",math.rad(math.random(360))))),math.round(line.middle+recall.r*math.sin(recall.theta)),get_shape(math.random(4)))
		end
	elseif loops[1][2] == 2 then
		relayer(3)
		retime("line",syl.start_time-200+math.random(-200,200),-100+400*syl.i/line.kara.n)
		return string.format("{\\fad(300,300)\\pos(%d,%d)\\fscy\\fscx150\\t(0,250,\\fscy130\\fscx80)\\t(250,400,\\fscy80\\fscx110)\\t(400,500,\\fscx100\\fscy100)\\p1\\an7}%s",line.left+syl.left+shapes[shapes_i].x,line.top+shapes[shapes_i].y,shapes[shapes_i].text)
	elseif loops[1][2] == 1 then
		relayer(3)
		if loop_i == loops[1][1] then
			retime("line",syl.start_time-200,-100+400*syl.i/line.kara.n)
			return string.format("{\\fad(200,300)\\pos(%d,%d)\\fsc0\\t(0,300,\\fsc100)\\p1\\an7}%s",line.left+syl.left+shapes[shapes_i].x,line.top+shapes[shapes_i].y,shapes[shapes_i].text)
		else
			retime("abs",line.start_time+syl.start_time-200,line.start_time+syl.start_time-200+400)
			return string.format("{\\p1\\fad(200,300)\\an7\\bord2\\fsc0\\1a&HFF&\\3c%s\\blur3\\t(\\fsc300)\\shad0\\pos(%d,%d)}%s",_G.ass_color(_G.HSV_to_RGB(math.random(360),1,1)),line.left+syl.left+shapes[shapes_i].x,line.top+shapes[shapes_i].y,shapes[shapes_i].text)
		end
	end
end

function multi3()
	if j==1 then
		loops={}
		for k=1,#shapes do
			if points_num(shapes[k].text) >= 60 then
				loops[k]=2
			else
				loops[k]=1
			end
		end
	end
	maxloop(#shapes)
	relayer(1)
	if loops[j] == 2 then
		retime("line",syl.start_time-200+math.random(-200,200),-100+400*syl.i/line.kara.n)
		return string.format("{\\fad(300,300)\\bord2\\blur2\\pos(%d,%d)\\fscx0\\fscy150\\t(0,250,\\fscx130\\fscy80)\\t(250,400,\\fscx80\\fscy110)\\t(400,500,\\fscx100\\fscy100)\\p1\\an7}%s",line.left+syl.left+shapes[j].x,line.top+shapes[j].y,shapes[j].text)
	elseif loops[j] == 1 then
		relayer(3)
		retime("line",syl.start_time-200+math.random(-200,200),-100+400*syl.i/line.kara.n)
		return string.format("{\\fad(300,300)\\bord2\\blur2\\pos(%d,%d)\\fscy0\\fscx150\\t(0,250,\\fscy130\\fscx80)\\t(250,400,\\fscy80\\fscx110)\\t(400,500,\\fscx100\\fscy100)\\p1\\an7}%s",line.left+syl.left+shapes[j].x,line.top+shapes[j].y,shapes[j].text)
	end
end

function get_shape2(min,max) 
	if math.random(100) > 50 then
		local a=math.round(math.random(80,120)/100*max)
		local b=math.round(math.random(80,120)/100*min)
		s=string.format("m %d %d l %d %d l %d %d l %d %d",0,0,a,0,a,b,0,b)
		if math.random(100) > 60 then
			s=s..string.format(" m %d %d l %d %d l %d %d l %d %d",5,5,5,b-5,a-5,b-5,a-5,5)
		end
		s=_G.shape.bounding_an(s,5)
	else
		if math.random(100) > 50 then
			r_shape="m -40 0 b -40 -53 40 -53 40 0 b 40 53 -40 53 -40 0 "
			local r=math.random(min,max)
			s=_G.shape.scale(r_shape,r/80,r/80)
			if math.random(100) > 60 then
				r_reverse="m -40 0 b -40 53 40 53 40 0 b 40 -53 -40 -53 -40 0"
				s=s.._G.shape.scale(r_reverse,(r-10)/80,(r-10)/80)
			end
		else
			local r=math.random(min,max)
			s=string.format("m %d %d l %d %d l %d %d",math.round(math.cos(math.pi*2/3)*r),-math.round(math.sin(math.pi*2/3)*r),math.round(math.cos(math.pi*4/3)*r),-math.round(math.sin(math.pi*4/3)*r),math.round(math.cos(0)*r),-math.round(math.sin(0)*r))
			if math.random(100) > 60 then
				r=r-7
				s=s..string.format("m %d %d l %d %d l %d %d",math.round(math.cos(math.pi*2/3)*r),-math.round(math.sin(math.pi*2/3)*r),math.round(math.cos(0)*r),-math.round(math.sin(0)*r),math.round(math.cos(math.pi*4/3)*r),-math.round(math.sin(math.pi*4/3)*r))
			end
		end
	end
	return s
end