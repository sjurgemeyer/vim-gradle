let g:vim_gradle_source_dir=expand("<sfile>:h:h:h")

function! SyntaxCheckers_java_gradlebuild_GetLocList() dict
    let root = FindGradleRoot()
    if empty(root)
    else
		let makeprg = self.makeprgBuild({
					\'exe': 'cd ' . root . ';gradle build;echo ',
					\'filetype': 'java',
					\'subchecker': 'gradlebuild'
					\ })

		let errorformat = '%f:%l:%m'
		"let errorformat = '%m'
		return SyntasticMake({ 'makeprg': makeprg, 'errorformat': errorformat })

    endif
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'java',
    \ 'name': 'gradlebuild',
	\ 'exec': 'pwd'})


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
