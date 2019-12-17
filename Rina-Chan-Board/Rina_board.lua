local tr = aegisub.gettext
script_name = tr("Rina-Board")
script_description = tr("Generate Rina Emoji")
script_author = "domo&kiriko"
script_version = "0.2"


local function is_include(value, tbl)
	for k,v in ipairs(tbl) do
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

local function save_to_file(checkbox_tbl)

end

function rina_board(subs,selected_lines)
	require'baseboard_data'
    local ADD=aegisub.dialog.display
	local ADO=aegisub.debug.out
    xn=26
    yn=22
	eyes_type={}
	mouth_type={}
	--Read saved emoji table
	for k,v in pairs(emoji_eyes) do
		table.insert(eyes_type,k)
	end
	for k,v in pairs(emoji_mouth) do
		table.insert(mouth_type,k)
	end
	--Show functions of this script
	prim_dia_conf={
		{x=0, y=0, class="label", label="Configuration"},
		{x=0, y=1, class="label", label="Choose Emoji"},
		{x=0, y=2, class="label", label="Eyes:"},
		{x=1, y=2, class="dropdown", items=eyes_type, name="eye_type"},
		{x=0, y=3, class="label", label="Mouth:"},
		{x=1, y=3, class="dropdown", items=mouth_type, name="mouth_type"},
		
		{x=2, y=1, class="label", label="Style Config"},
		{x=2, y=2, class="label", label="Base Color:"},
		{x=3, y=2, class="coloralpha", value="#FFFFFF00",name="base_c"},
		{x=2, y=3, class="label", label="Highlight Color:"},
		{x=3, y=3, class="coloralpha", value="#AD00FF00",name="high_c"},
		{x=2, y=4, class="label", label="Border Color:"},
		{x=3, y=4, class="coloralpha", value="#FFC2F900",name="border_c"},

	}
	btn_main, res_main=ADD(prim_dia_conf,{"Generate", "Customize", "Cancel"})
	eye_bit_tbl=emoji_eyes[res_main.eye_type]
	mouth_bit_tbl=emoji_mouth[res_main.mouth_type]
	--Generate base board using checkbox
	bitmap_conf={}
	for x=1,xn do
		bitmap_conf[#bitmap_conf+1]={x=x, y=0, class="label",label=tostring(x)}
	end
	for y=1,yn do
		bitmap_conf[#bitmap_conf+1]={x=0, y=y, class="label",label=tostring(y)}
		for x=1,xn do
			if baseboard[y][x]==1 then
				v=(is_include({y,x},eye_bit_tbl) or is_include({y,x},mouth_bit_tbl))
				bitmap_conf[#bitmap_conf+1]={x=x, y=y, class="checkbox",name="("..tostring(x)..","..tostring(y)..")",value=v}
			end
		end
	end
	
	repeat
	if btn_main=="Customize" then
		btn_bit, res_bit=ADD(bitmap_conf,{"Generate","Save"})
	end
	until btn_bit=="Generate"
end


aegisub.register_macro(script_name, script_description, rina_board)
