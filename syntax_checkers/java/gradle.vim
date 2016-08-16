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
		echom "Running gradle build..."
		return SyntasticMake({ 'makeprg': makeprg, 'errorformat': errorformat })

    endif
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'java',
    \ 'name': 'gradlebuild',
	\ 'exec': 'pwd'})


