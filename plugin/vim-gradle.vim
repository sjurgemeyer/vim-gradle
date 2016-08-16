function! FindGradleRoot()
	let root = expand('%:p')
	let previous = ""

	while root !=# previous

		let path = globpath(root, '*.gradle', 1)
		if path == ''
		else
			return fnamemodify(path, ':h')
		endif
		let previous = root
		let root = fnamemodify(root, ':h')
	endwhile
	return ''
endfunction
