local tr = aegisub.gettext
script_name = tr("Rina-Board")
script_description = tr("Generate Rina Emoji")
script_author = "domo&kiriko"
script_version = "0.1"

function rina_board(subs,selected_lines)
	require'baseboard_data'
    local ADD=aegisub.dialog.display
	local ADO=aegisub.debug.out
    xn=26
    yn=22
	eyes_tbl={}
	mouth_tbl={}
	--Read saved emoji table
	for k,v in pairs(emoji_eyes) do
		table.insert(eyes_tbl,k)
	end
	for k,v in pairs(emoji_mouth) do
		table.insert(mouth_tbl,k)
	end
	--Show functions of this script
	prim_dia_conf={
		{x=0, y=0, class="label", label="Configuration"},
		{x=0, y=1, class="label", label="Choose Emoji"},
		{x=0, y=2, class="label", label="Eyes:"},
		{x=1, y=2, class="dropdown", items=eyes_tbl, value="a"},
		{x=0, y=3, class="label", label="Mouth:"},
		{x=1, y=3, class="dropdown", items=mouth_tbl, value="d"},
		
		{x=2, y=1, class="label", label="Style Config"},
		{x=2, y=2, class="label", label="Base Color:"},
		{x=3, y=2, class="coloralpha", value="#FFFFFF00",name="base_c"},
		{x=2, y=3, class="label", label="Highlight Color:"},
		{x=3, y=3, class="coloralpha", value="#AD00FF00",name="high_c"},
		{x=2, y=4, class="label", label="Border Color:"},
		{x=3, y=4, class="coloralpha", value="#FFC2F900",name="border_c"},

	}
	--Generate base board using checkbox
	bitmap_conf={}
	for x=1,xn do
		bitmap_conf[#bitmap_conf+1]={x=x, y=0, class="label",label=tostring(x)}
	end
	for y=1,yn do
		bitmap_conf[#bitmap_conf+1]={x=0, y=y, class="label",label=tostring(y)}
		for x=1,xn do
			if baseboard[y][x]==1 then
				bitmap_conf[#bitmap_conf+1]={x=x, y=y, class="checkbox",name="("..tostring(x)..","..tostring(y)..")"}
			end
		end
	end
	repeat
	btn_main, res_main=ADD(prim_dia_conf,{"Generate", "Customize", "Cancel"})
	if btn_main=="Customize" then
		btn_bit, res_bit=ADD(bitmap_conf,{"Generate","Save"})
	end
	until btn_bit=="Generate"
end


aegisub.register_macro(script_name, script_description, rina_board)
