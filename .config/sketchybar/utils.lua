local split_string = function(string, regex)
	local result_table = {}
	for space in string.gmatch(string, regex) do
		table.insert(result_table, space)
	end
	return result_table
end

return {
	split_string = split_string,
}
