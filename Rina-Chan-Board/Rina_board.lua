local tr = aegisub.gettext
script_name = tr("Rina-Board")
script_description = tr("Generate Rina Emoji")
script_author = "domo&kiriko"
script_version = "0.8"


function is_include(value, tbl)
	if value==nil or tbl==nil then
		return false
	end
	for k,v in pairs(tbl) do
		if type(value)~="table" and v == value then
			return true
		elseif type(value)=="table" then
			if deepcompare(value,tbl[k],false) then
				return true
			end
		end 
	end
	return false
end

function HTML2ASS(html_str)
	rr,gg,bb,aa=string.match(html_str,"#(..)(..)(..)(..)")
	ass_a = string.format("&H%s&",aa)
	ass_c = string.format("&H%s%s%s&",bb,gg,rr)
    return ass_c,ass_a
end

function deepcompare(t1,t2,ignore_mt)
	local ty1 = type(t1)
	local ty2 = type(t2)
	if ty1 ~= ty2 then return false end
	-- non-table types can be directly compared
	if ty1 ~= 'table' and ty2 ~= 'table' then return t1 == t2 end
	-- as well as tables which have the metamethod __eq
	local mt = getmetatable(t1)
	if not ignore_mt and mt and mt.__eq then return t1 == t2 end
	for k1,v1 in pairs(t1) do
		local v2 = t2[k1]
		if v2 == nil or not deepcompare(v1,v2) then return false end
	end
	for k2,v2 in pairs(t2) do
		local v1 = t1[k2]
		if v1 == nil or not deepcompare(v1,v2) then return false end
	end
	return true
end

function save_to_file(res_tbl,name)
	local ADP=aegisub.decode_path
	local ADO=aegisub.debug.out
	local tbl_str="\n".."emoji_all"..string.format('["%s"]={',name)
	includepath=ADP("?data").."\\automation\\include\\"
    data_file = io.open(includepath.."baseboard_data.lua" ,"a")
    emoji_all[name]={}
	for k,v in pairs(res_tbl) do
		if v==true then
            tbl_str=tbl_str..k..","
            local x,y = string.match(k,"{(%d+),(%d+)}")
            table.insert(emoji_all[name],{x,y})
		end
    end
	tbl_str=tbl_str.."}\n"
	data_file:write(tbl_str)
	data_file:close()
end

function gen_drawing(res_bit,base_c,base_bord_c,pos_x,pos_y,side_length,gen_base,merge,subs,selected_lines)
    line=subs[selected_lines[1]]
	line.text=""
	--Generate baseboard drawing
    if gen_base then
        colors={}
	    colors['base_c'],colors['base_a']=HTML2ASS(base_c)
        colors['base_bord_c'],colors['base_bord_a']=HTML2ASS(base_bord_c)
		for y=1,yn do
			for x=1,xn do
				if baseboard[y][x]==1 then
					line.text=line.text..string.format("m %d %d l %d %d l %d %d l %d %d ",
											(x-1)*1.2*side_length-15.5*side_length  ,  (y-1)*1.2*side_length-15.5*side_length,
											(x*1.2-0.2)*side_length-15.5*side_length,  (y-1)*1.2*side_length-15.5*side_length,
											(x*1.2-0.2)*side_length-15.5*side_length,(y*1.2-0.2)*side_length-15.5*side_length,
											(x-1)*1.2*side_length-15.5*side_length  ,(y*1.2-0.2)*side_length-15.5*side_length)
				end
			end	
		end
		line.text=string.format("{\\an7\\pos(%d,%d)\\p1\\1c%s\\1a%s\\3c%s\\3a%s}",
					pos_x,pos_y,
					colors.base_c,colors.base_a,colors.base_bord_c,colors.base_bord_a)
					..line.text
		subs[0]=line
	end
	
	--Generate highlight drawing
	line.layer=1
	local x,y={},{}
	line.text=""
	for k,v in pairs(res_bit) do
        if v == true then
            x[#x+1],y[#y+1]=string.match(k,"{(%d+),(%d+)}")
        elseif type(v) == "table" and v.value then
            x[#x+1],y[#y+1]=v.x,v.y
		end
	end
	if merge then
		for i=1,#x do
			line.text=line.text..string.format("m %d %d l %d %d l %d %d l %d %d ",
									(x[i]-1)*1.2*side_length-15.5*side_length  ,  (y[i]-1)*1.2*side_length-15.5*side_length,
									(x[i]*1.2-0.2)*side_length-15.5*side_length,  (y[i]-1)*1.2*side_length-15.5*side_length,
									(x[i]*1.2-0.2)*side_length-15.5*side_length,(y[i]*1.2-0.2)*side_length-15.5*side_length,
									(x[i]-1)*1.2*side_length-15.5*side_length  ,(y[i]*1.2-0.2)*side_length-15.5*side_length)
		end
		line.text=string.format("{\\an7\\pos(%d,%d)\\p1}",pos_x,pos_y)..line.text
		subs[0]=line
	else
		for i=1,#x do
			line.text=string.format("{\\an7\\pos(%d,%d)\\p1}",
						x[i]*1.2*side_length-15.5*side_length+pos_x,
						y[i]*1.2*side_length-15.5*side_length+pos_y)..
					  string.format("m %d %d l %d %d l %d %d l %d %d ",
						-side_length/2,-side_length/2,
						 side_length/2,-side_length/2,
						 side_length/2, side_length/2,
						-side_length/2, side_length/2)
			subs[0]=line
		end
	end
end

function rina_board(subs,selected_lines)
    require'baseboard_data'
    local ADD=aegisub.dialog.display
	local ADO=aegisub.debug.out
    local x_res,y_res=aegisub.video_size()
    local pos_x,pos_y,side_length = 0,0,10
    local base_c,base_bord_c="#FFFFFF00","#C0C0C000"
    local use_all,merge,gen_base=false,true,true
    local eyes_type,mouth_type,all_type="blank","blank","blank"
    xn=26
    yn=22
	--Load saved emoji table
    local get_type_tbl = function(emoji_tbl)
        local type_tbl = {}
        for k,v in pairs(emoji_tbl) do
            table.insert(type_tbl,k)
        end
        return type_tbl
    end
	
	if x_res and y_res then
		pos_x,pos_y=x_res/2,y_res/2
	end
	
	--Show functions of this script
	::main_dia::
	prim_dia_conf={
		{x=0, y=0, class="label", label="Configuration"},
		{x=0, y=1, class="label", label="Choose Emoji"},
		{x=0, y=2, class="label", label="Eyes:"},
		{x=1, y=2, class="dropdown", items=get_type_tbl(emoji_eyes), name="eyes_type", value=eyes_type},
		{x=0, y=3, class="label", label="Mouth:"},
		{x=1, y=3, class="dropdown", items=get_type_tbl(emoji_mouth), name="mouth_type", value=mouth_type},
		{x=0, y=4, class="checkbox",label="Use all",name='use_all',value=use_all},
		{x=1, y=4, class="dropdown", items=get_type_tbl(emoji_all), name="all_type", value=all_type},
		{x=0, y=5, class="checkbox",label="Merge",name='merge',value=merge},
		
		{x=3, y=1, class="label", label="Style Config"},
		{x=3, y=2, class="label", label="Base Color:"},
		{x=4, y=2, class="coloralpha", value=base_c,name="base_c"},
		{x=3, y=3, class="label", label="Base Bord Color:"},
		{x=4, y=3, class="coloralpha", value=base_bord_c,name="base_bord_c"},
		{x=3, y=4, class="label", label="Side Length:"},
		{x=4, y=4, class="intedit",name="side_length",value=side_length},
		{x=3, y=5, class="label", label="Center x:"},
		{x=4, y=5, class="intedit",name="pos_x",value=pos_x},
		{x=3, y=6, class="label", label="Center y:"},
		{x=4, y=6, class="intedit",name="pos_y",value=pos_y},
		{x=3, y=7, class="checkbox",label="Generate Baseboard",name='gen_base',value=gen_base},
	}
	
	btn_main, res_main=ADD(prim_dia_conf,{"Generate","Customize/Preview","Cancel"},{close="Cancel"})
    
    pos_x, pos_y, side_length = res_main.pos_x, res_main.pos_y, res_main.side_length
    base_c, base_bord_c = res_main.base_c, res_main.base_bord_c
    use_all, merge,gen_base = res_main.use_all, res_main.merge, res_main.gen_base
    eyes_type, mouth_type, all_type = res_main.eyes_type, res_main.mouth_type, res_main.all_type

	if btn_main=="Cancel" then
		aegisub.cancel()
	end

	eye_bit_tbl=emoji_eyes[res_main.eyes_type]
	mouth_bit_tbl=emoji_mouth[res_main.mouth_type]
	all_bit_tbl=emoji_all[res_main.all_type]
	if res_main.use_all then eye_bit_tbl,mouth_bit_tbl={},{} end
	
	--Generate base board data using checkbox
	if not from_back or (eyes_type~="blank" and mouth_type~="blank" or (res_main.use_all and all_type~="blank")) then
		bitmap_conf={}
		for x=1,xn do
			bitmap_conf[#bitmap_conf+1]={x=x, y=0, class="label",label=tostring(x)}
		end
		for y=1,yn do
			bitmap_conf[#bitmap_conf+1]={x=0, y=y, class="label",label=tostring(y)}
			for x=1,xn do
				if baseboard[y][x]==1 then
					v=(is_include({x,y},eye_bit_tbl) or is_include({x,y},mouth_bit_tbl) or is_include({x,y},all_bit_tbl))
					bitmap_conf[#bitmap_conf+1]={x=x, y=y, class="checkbox",name="{"..tostring(x)..","..tostring(y).."}",value=v}
				end
			end
		end
	end
	--Generate drawing directly
	if btn_main=="Generate" then
		gen_drawing(bitmap_conf,base_c,base_bord_c,pos_x,pos_y,side_length,gen_base,merge,subs,selected_lines)
	else
		repeat
			if btn_main=="Customize/Preview" then
				from_back=true
				btn_bit, res_bit=ADD(bitmap_conf,{"Back<","Generate","Save","Cancel"},{close="Cancel"})
				if btn_bit=="Save" then
					btn_save,res_name=ADD({
					{x=0,y=0,class="label",label="Input emoji name:"},
					{x=0,y=1,class="edit",value="",name="emoji_name"}},
					
					{"OK","Cancel"})
					emoji_name=res_name.emoji_name
					if is_include(emoji_name,get_type_tbl(emoji_all)) then
                        ADD({{class="label",label="Same emoji name exists, please change the name."}},{"OK"},{close='OK'})
					else
						if btn_save=="OK" then
							save_to_file(res_bit,emoji_name)
							ADD({{class="label",label="Saved."}},{"OK"},{close='OK'})
						end
					end
				end
				--Update bitmap_conf
				bitmap_conf={}
				for x=1,xn do
					bitmap_conf[#bitmap_conf+1]={x=x, y=0, class="label",label=tostring(x)}
				end
				for y=1,yn do
					bitmap_conf[#bitmap_conf+1]={x=0, y=y, class="label",label=tostring(y)}
				end
				for k,v in pairs(res_bit) do
					x,y=string.match(k,"(%d+),(%d+)")
					bitmap_conf[#bitmap_conf+1]={x=x,y=y,class="checkbox",name="{"..tostring(x)..","..tostring(y).."}",value=v}
				end
				if btn_bit=="Cancel" then
					aegisub.cancel()
				end
				if btn_bit=="Back<" then
					goto main_dia
				end
			end
		until (btn_bit=="Generate")
		gen_drawing(res_bit,base_c,base_bord_c,pos_x,pos_y,side_length,gen_base,merge,subs,selected_lines)
	end

end

aegisub.register_macro(script_name, script_description, rina_board)