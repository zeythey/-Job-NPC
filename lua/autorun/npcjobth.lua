local job_npc = {}

if SERVER then
	
	util.AddNetworkString("npcjobth")
	resource.AddFile("resource/fonts/BebasNeue-Regular.ttf")
	resource.AddFile("resource/fonts/CaviarDreams_Bold.ttf")

end

if CLIENT then

	surface.CreateFont( "job_npcth1", {
		font = "Bebas Neue", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
		extended = false,
		size = 24,
		weight = 500,
	} )

	surface.CreateFont( "job_npcth2", {
		font = "Caviar Dreams", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
		extended = false,
		size = 14,
		weight = 500,
	} )

	surface.CreateFont( "job_npcth3", {
		font = "Caviar Dreams", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
		extended = false,
		size = 34,
		weight = 500,
	} )

	surface.CreateFont( "job_npcth4", {
		font = "Caviar Dreams", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
		extended = false,
		size = 25,
		weight = 500,
	} )
	
	job_npc.base = function(len,ply)

		local jobchoosed = nil

		local wb = 800

		local hb = 466

		local categoriesselect = 1
		local categoriesselect_name = ""

		local cm = 1

		local jobb = vgui.Create("DFrame")
		jobb:SetSize(wb-185,hb)
		jobb:SetPos(185		,0)
		jobb:SetTitle(" ")
		jobb:SetDraggable(false)
		jobb:ShowCloseButton(false)
		jobb.Paint = function(self,w,h)

			draw.RoundedBox(0,	0,0,	w,	h,	Color(255,	54,	54,	0))

		end

		local categoriesf = vgui.Create("DFrame")
		categoriesf:SetSize(185, hb)
		categoriesf:SetPos(0,0)
		categoriesf:SetTitle(" ")
		categoriesf:ShowCloseButton(false)
		categoriesf:SetDraggable(false)
		categoriesf.Paint = function(self,w,h)

			draw.RoundedBox(0,	0,0,	w,	h,	Color(255,	54,	54,	0))

		end

		local jobbs = vgui.Create("DFrame")
		jobbs:SetSize(180,340)
		jobbs:SetPos(20,80)
		jobbs:SetTitle(" ")
		jobbs:SetDraggable(false)
		jobbs:ShowCloseButton(false)
		jobbs.Paint = function(self,w,h)

			draw.RoundedBox(0,	0,0,	w,	h,	Color(255,	54,	54,	0))


		end

		local jobbm = vgui.Create("DModelPanel", jobbs)
		jobbm:SetSize(jobbs:GetWide(), jobbs:GetTall())
		jobbm:SetModel("models/Humans/Group01/Female_01.mdl")
		jobbm.LayoutEntity = function() return end
			
		local eyepos = jobbm.Entity:GetBonePosition( jobbm.Entity:LookupBone( "ValveBiped.Bip01_Head1" ) )
		eyepos:Add( Vector( 10, 0, -10 ) )	-- Move up slightly

		jobbm:SetLookAt( eyepos )
		
		jobbm:SetCamPos( eyepos-Vector( -12, 0, 0 ) )	-- Move cam in front of eyes


		local jobjoin = vgui.Create("DButton")
		jobjoin:SetVisible(false)
		jobjoin:SetSize(142,42)
		jobjoin:SetPos(wb-142,hb-42)
		jobjoin:SetFontInternal("job_npcth1")
		jobjoin:SetTextColor(Color(255,	255,	255,	255))
		jobjoin:SetText("Devenir")
		jobjoin.Paint = function(self,w,h)

			draw.RoundedBox(0,	0,	0,	w,	h,	Color(30,	150,	30,	255))

		end
		jobjoin.DoClick = function(self)

			RunConsoleCommand("say", "/"..jobchoosed.command)
				net.Start("DarkRP_preferredjobmodel")
				net.WriteUInt(jobchoosed.team, 8)
				if istable(jobchoosed.model) then
					net.WriteString(jobchoosed.model[cm])
				else
					net.WriteString(jobchoosed.model)
				end
				net.SendToServer()
			self:GetParent():Remove()


		end

		local jobprec = vgui.Create("DButton")
		jobprec:SetVisible(false)
		jobprec:SetSize(142,42)
		jobprec:SetPos(wb-284,hb-42)
		jobprec:SetFontInternal("job_npcth1")
		jobprec:SetTextColor(Color(255,	255,	255,	255))
		jobprec:SetText("Précédent")
		jobprec.Paint = function(self,w,h)

			draw.RoundedBox(0,	0,	0,	w,	h,	Color(150,	30,	30,	255))

		end
		jobprec.DoClick = function(self)
			
			jobchoosed = nil

		end

		local buj = vgui.Create("DButton")
		buj:SetVisible(false)
		buj:SetSize(80,	23)
		buj:SetPos(20,hb-43)
		buj:SetText("<")
		buj:SetFontInternal("job_npcth1")
		buj:SetTextColor(Color(255,255,	255,	255))
		buj.Paint = function(self,w,h)
			if self:IsHovered() then
				draw.RoundedBox(0,	0,	0,	w,	h,	Color(140,	140,	140,	255))
			else
				draw.RoundedBox(0,	0,	0,	w,	h,	Color(100,	100,	100,	255))
			end
		end
		buj.DoClick = function(self)

			if istable(jobchoosed.model) then
				if cm == 1 then return end
				cm = cm - 1
			else
				return
			end

		end

		local buj2 = vgui.Create("DButton")
		buj2:SetVisible(false)
		buj2:SetSize(80,	23)
		buj2:SetPos(100,hb-43)
		buj2:SetText(">")
		buj2:SetFontInternal("job_npcth1")
		buj2:SetTextColor(Color(255,255,	255,	255))
		buj2.Paint = function(self,w,h)
			if self:IsHovered() then
				draw.RoundedBox(0,	0,	0,	w,	h,	Color(140,	140,	140,	255))
			else
				draw.RoundedBox(0,	0,	0,	w,	h,	Color(100,	100,	100,	255))
			end
		end
		buj2.DoClick = function(self)

			if istable(jobchoosed.model) then
				if cm == #jobchoosed.model then 
					cm = 1 
				else
					cm = cm + 1
				end

			else
				return
			end

		end

		local b = vgui.Create("DFrame")
		b:SetSize(800,	466)
		b:Center()
		b:MakePopup()
		b:ShowCloseButton(false)
		b:SetTitle(" ")
		b.Paint = function(self,w,h)

			draw.RoundedBox(0,	0,	0,	w,	h,	Color(24,24,	24,	255))
			if jobchoosed != nil then

				draw.SimpleText(jobchoosed.name, "job_npcth3",20,20,Color(255,	255,	255,	255),TEXT_ALIGN_LEFT)
				draw.SimpleText("Salaire : "..jobchoosed.salary.."€",	"job_npcth3",200,80,Color(255,	255,	255,	255),TEXT_ALIGN_LEFT)
				local parsed = ""
				if jobchoosed.description != nil then
					parsed = markup.Parse( "<font=job_npcth4><colour=255, 255, 255, 255>"..jobchoosed.description.."</colour></font>",580 )
				end	
				draw.DrawText("Description : \n",	"job_npcth3",200,140,Color(255,	255,	255,	255),TEXT_ALIGN_LEFT)
				parsed:Draw( 200,180, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT )

			end

		end
		b.Think = function(self)

				if jobchoosed != nil then
					
					jobb:SetVisible(false)
					categoriesf:SetVisible(false)
					jobbs:SetVisible(true)
					jobjoin:SetVisible(true)
					buj:SetVisible(true)
					buj2:SetVisible(true)
					jobprec:SetVisible(true)
					if istable(jobchoosed.model) then
					jobbm:SetModel(jobchoosed.model[cm])
					else
					jobbm:SetModel(jobchoosed.model)
					end
				else
					buj:SetVisible(false)
					buj2:SetVisible(false)
					jobb:SetVisible(true)
					categoriesf:SetVisible(true)
					jobbs:SetVisible(false)
					jobjoin:SetVisible(false)
					jobprec:SetVisible(false)
				end


		end

		jobjoin:SetParent(b)

		jobb:SetParent(b)
		jobbs:SetParent(b)
		buj:SetParent(b)
		buj2:SetParent(b)
		jobprec:SetParent(b)

		local jobscroll = vgui.Create( "DScrollPanel", jobb )
		jobscroll:Dock( FILL )
		jobscroll:GetVBar().Paint = function(self,w,h) draw.RoundedBox(0, 0, 0, w, h, Color(200,	200,	200,	100)) end
    	jobscroll:GetVBar().btnUp.Paint = function(self,w,h) draw.RoundedBox(0, 0, 0, w, h, Color(54,	54,	54,	255)) end
    	jobscroll:GetVBar().btnDown.Paint = function(self,w,h) draw.RoundedBox(0, 0, 0, w, h, Color(54,	54,	54,	255)) end
		jobscroll:GetVBar().btnGrip.Paint = function(self, w, h) draw.RoundedBox(0, 0, 0, w, h, Color(54,	54,	54,	255)) end

		local j = {}
		local c = 0
		local jm = {}
		local j2 = {}

		for k , v in pairs(RPExtraTeams) do
			
			j[k] = jobscroll:Add("DFrame")
			j[k]:SetSize(120,120)
			j[k]:SetPos(( c%5 )*120,(math.floor(c/5)*120))
			j[k]:ShowCloseButton(false)
			j[k]:SetTitle(" ")
			j[k]:SetVisible(false)
			j[k].Paint = function(self,w,h)

				draw.RoundedBox(0,	0,	0,	w,	h,	Color(54,	54,	54,	200))

			end

			jm[k] =  vgui.Create("DModelPanel", j[k])
			jm[k]:SetSize(j[k]:GetWide(), j[k]:GetTall())
			if istable(v.model) then
				jm[k]:SetModel(v.model[1])
				else
				jm[k]:SetModel(v.model)
			end
			jm[k].LayoutEntity = function() return end
			
			local eyepos = jm[k].Entity:GetBonePosition( jm[k].Entity:LookupBone( "ValveBiped.Bip01_Head1" ) )
			eyepos:Add( Vector( 2, 0, 0 ) )	-- Move up slightly

			jm[k]:SetLookAt( eyepos )
		
			jm[k]:SetCamPos( eyepos-Vector( -12, 0, 0 ) )	-- Move cam in front of eyes

			j2[k] = vgui.Create("DButton", jm[k])
			j2[k]:SetSize(120,120)
			j2[k]:SetText(" ")
			j2[k].Paint = function(self,w,h)
				draw.RoundedBox(0,	0,	self:GetTall()-25,	self:GetWide(),	25,	Color(24,	24,	24,	200))
				draw.SimpleText(v.name,	"job_npcth2",self:GetWide()/2,self:GetTall()-20,Color(255,	255,	255,	255),TEXT_ALIGN_CENTER)

			end
			j2[k].DoClick = function(self)

				jobchoosed = v

			end

			c = c +1

		end	

		local c = vgui.Create("DButton", b)
		c:SetSize(50,20)
		c:SetPos(wb-50,0)
		c.Paint = function(self,w,h)

			draw.RoundedBox(0,0,0,w,h,Color(255,100,100,255))

		end
		c:SetTextColor(Color(255,255,255,255))
		c:SetText("X")
		c.DoClick = function(self)

			b:Remove()

		end


		-- Parent

		categoriesf:SetParent(b)

		local categoriesfscroll = vgui.Create( "DScrollPanel", categoriesf )
		categoriesfscroll:Dock( FILL )
		categoriesfscroll:GetVBar().Paint = function(self,w,h) draw.RoundedBox(0, 0, 0, w, h, Color(200,	200,	200,	100)) end
    	categoriesfscroll:GetVBar().btnUp.Paint = function(self,w,h) draw.RoundedBox(0, 0, 0, w, h, Color(54,	54,	54,	255)) end
    	categoriesfscroll:GetVBar().btnDown.Paint = function(self,w,h) draw.RoundedBox(0, 0, 0, w, h, Color(54,	54,	54,	255)) end
		categoriesfscroll:GetVBar().btnGrip.Paint = function(self, w, h) draw.RoundedBox(0, 0, 0, w, h, Color(54,	54,	54,	255)) end

		local bc = {}
		local c = 0
		local jc = {}

		local categories = DarkRP.getCategories() or {}

		for k , v in pairs(DarkRP.getCategories()) do
			local eoo = 1
			
			if k == "jobs" then

				for a , b in pairs(v) do

					if v[eoo]['members'][1] == nil then continue end
				
					bc[a] = categoriesfscroll:Add("DButton")
					bc[a]:SetSize(categoriesf:GetWide(),50)
					bc[a]:SetPos(0,50*c)
					bc[a]:SetTextColor(Color(255,255,255,255))
					bc[a]:SetText(v[eoo]['members'][1]['category'])
					bc[a]:SetFontInternal("job_npcth1")
					bc[a].Paint = function(self,w,h)

						draw.RoundedBox(0,	0,	0,	w,	h,	Color(54,	54,	54,	255))

					end
					
					bc[a].DoClick = function(self)

						local ae = 0

						categoriesselect = eoo
						categoriesselect_name = b['members'][1]["category"]

						for k , v in pairs(RPExtraTeams) do

							if v.category == categoriesselect_name then
								

								j[k]:SetVisible(true)
								j[k]:SetPos(( ae%5 )*120,(math.floor(ae/5)*120))

								ae = ae + 1
							else

								j[k]:SetVisible(false)

							end	

						end

					end



					eoo = eoo + 1
					c = c + 1

				end
			end
		end	

	end
	net.Receive("npcjobth", job_npc.base)

end	