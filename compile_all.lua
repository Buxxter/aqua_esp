function compile_all( ... )

	l = file.list();
	for fname,v in pairs(l) do
		print("name:"..fname..", size:"..v)
		if string.sub(fname, -3, -1) == "lua" then
			node.compile(fname)
	        file.remove(fname)
	    end
	end
end