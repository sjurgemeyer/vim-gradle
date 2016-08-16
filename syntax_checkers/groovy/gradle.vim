
let g:vim_gradle_source_dir=expand("<sfile>:h:h:h")

function! SyntaxCheckers_groovy_codenarc_GetLocList() dict
    let root = FindGradleRoot()
    if empty(root)
    else
        let initScript = g:vim_gradle_source_dir . "/data/initgradle.gradle"
		let codenarcOutput = root . '/build/reports/codenarc/main.txt'
		let makeprg = self.makeprgBuild({
					\'exe': 'cd ' . root . ';gradle -I ' . initScript . ' codenarcMain;sed "s@File: @File: ' . root . '/src/main/groovy/@g" ' . codenarcOutput,
					\'filetype': 'groovy',
					\'subchecker': 'codenarc'
					\ })

		let errorformat = '%P%.%#File:\ %f,%.%#Violation%.%#Line=%l%.%#Msg=[%m'
		"let errorformat = '%m'
		echom "Running gradle codenarc..."
		return SyntasticMake({ 'makeprg': makeprg, 'errorformat': errorformat })

    endif
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'groovy',
    \ 'name': 'codenarc',
	\ 'exec': 'pwd'})


function! SyntaxCheckers_groovy_gradlebuild_GetLocList() dict
    let root = FindGradleRoot()
    if empty(root)
    else
		let makeprg = self.makeprgBuild({
					\'exe': 'cd ' . root . ';gradle build;echo ',
					\'filetype': 'groovy',
					\'subchecker': 'gradlebuild'
					\ })
		let errorformat = '%f:\ %l:\ %m@\ line %.%#\,\ column %c%.%#'
		"let errorformat = '%m'
		echom "Running gradle build..."
		return SyntasticMake({ 'makeprg': makeprg, 'errorformat': errorformat })

    endif
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'groovy',
    \ 'name': 'gradlebuild',
	\ 'exec': 'pwd'})
