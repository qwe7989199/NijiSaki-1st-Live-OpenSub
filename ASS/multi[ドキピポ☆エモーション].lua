function multi1()
	if j==1 then
		loop_i=0
		shapes_i=1
		loop_n=0
		loops={}
		for k=1,#shapes do
			if points_num(shapes[k].text) >= 70 then
				local outline=_G.shape.outline(shapes[k].text,1,"Flat","Miter")
				local len=math.round(_G.shape.length(outline)/10)+1
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
		if loop_i == loops[1][1] then
			retime("line",line.duration/2*syl.i/line.kara.n+200,-200+600*syl.i/line.kara.n)
			return string.format("{\\fad(300,300)\\pos(%d,%d)\\p1\\an7}%s",line.left+syl.left+shapes[shapes_i].x,line.top+shapes[shapes_i].y,shapes[shapes_i].text)
		else
			relayer(2)
			retime("abs",line.start_time-300+line.duration/2*syl.i/line.kara.n+800*loop_i/loops[1][1],line.start_time-300+line.duration/2*syl.i/line.kara.n+800*loop_i/loops[1][1]+1000)
			local xy=_G.shape.point_at_percent(_G.shape.outline(shapes[shapes_i].text,1,"Flat","Miter"),loop_i/loops[1][1])
			local px=math.round(line.left+syl.left+shapes[shapes_i].x+xy.x)
			local py=math.round(line.top+shapes[shapes_i].y+xy.y)
			return string.format("{\\pos(%d,%d)\\shad0\\p1\\an7\\fad(100,200)\\blur1\\bord0\\fsc%d\\c&HFFFFFF&\\%s}m 0 -20 l 1 -1 l 20 0 l 1 1 l 0 20 l -1 1 l -20 0 l -1 -1 l 0 -20",px,py,math.random(80,100),AutoTags(300,"alpha&H00&","alpha&HFF&",0,math.random(300),math.random(700,1000)))
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